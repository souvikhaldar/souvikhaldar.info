---
title: "Understanding REST and priciples behind designing RESTful HTTP APIs in Go"
date: 2019-08-04T15:58:48+05:30
draft: false
---

# What is REST
REST, acronym for Representational State Transfer, is the architectural approach to building web services. Let's discuss a few characteristics of REST:  

* REST is independent of any underlying protocol. i.e REST API can be build over any protocol like REST HTTP API which means RESTful API built over HTTP protocol.   
* REST is independent of any specific implementation detail. i.e a REST API can be built on any language,tool,environment,etc. Almost every language allows one to write a REST API. The participating Client and Server can be built,modified and scaled separately, as long as they communicate in a consistent manner.  

# Design principles of RESTful HTTP APIs  
* Statelessness: The participating client and server are not required to know the state of each other. Essentially every request/response is independent and does not have any knowledge of the previous request/response.  
* REST API endpoints are designed around *resources* which can be an object,service,data,etc. For example, an endpoint `/addCustomer` is invalid whereas `/customer` with POST verb is better suited (we'll discuss about HTTP verbs later)  
* A resource has an identifier in the URI which helps to uniquely identify the resource. Like `/customer/24` signifies the customer with a unique identifier `24`.  
* The clients communicate with the service by exchanging representations of the resource. There are many exchange formats like XML,JSON,etc but these days JSON is heavily used (Javascript Object Notation).  
* There are four basic HTTP verbs to communicate with the resources.  
    1) `POST` : Create a new resource (non-idempotent in nature)  
    2) `PUT`: Update a resource or collection of resources (idempotent in nature)  
    3) `GET`: Retrieve a resource or collection of resources.  
    4) `DELETE`: Delete a resource or collection of resources.  

# Let's start building  
In this guide we will create a simple API which can perform CRUD operations i.e **C**reate  **R**ead **U**pdate **D**elete.  
C --> create a new customer instance (POST)  
R --> fetch a customer's details (GET)  
U --> update a customer's detail (PUT)  
D --> delete a customer's instance (DELETE)  
The standard library of Go is really very powerful, you can write a full blown server by using just the [standard library](https://golang.org/pkg/)!  
I’m assuming your system is setup for writing Go programs, if not you can [follow this link](https://golang.org/doc/install) and get it done.  

1. Create a directory in the `$GOPATH/src/<vcs-name>/<username>/golang-server` and name it anything you want. I’m naming in `golang-server`. 
The above path is standard golang practice, but after the onset of `go modules` you can create the directory anywhere you want.  
For me the path looks like:-  

    ![](/images/2019-08-04-21-11-41.png)   

2. Create a file called `main.go` (you can name it whatever). This is where the `main` function resides.  
3. We can store data anywhere, but for persistent storage a database is always a good option. In this guide, we will be using [PostgreSQL](https://www.postgresql.org/).   
    *So let's setup the database connection now.*     
    (i) Install postgresql on your system. Follow this [link](https://www.postgresqltutorial.com/install-postgresql/)  
    (ii) Run `psql -U postgres` on the terminal. (NOTE: `postgres` is a default role automatically created, if it's not you need to create it. Also, my commands are for mac, but other OSs should be pretty similar)  
    (iii) Create a new database. `create database guide`, I'm naming it guide, you can name it anything.  
    (iv) Create a simple table with two columns `customer_id` and `customer_name` by running `create table customer(customer_id int,customer_name text);` after connecting the `guide` database (do `\c guide`)  
    (v) We need a third party library for better database handling. Use [govendor](https://github.com/kardianos/govendor) for dependency management hence install it this way:-  
        * At the project root- `govendor init`  
        * `govendor fetch github.com/lib/pq` 
        (Note: If we would have not used govendor for dependency management we could have installed using- `go get -u github.com/lib/pq` but using one is always a better idea)  
    (vi) `init` method in golang is the method that runs first even before running `main` hence we will setup the database connection there.   
        ``` 
        func init() {
            psqlInfo := fmt.Sprintf("host=%s port=%d user=%s dbname=%s sslmode=disable", host, port, user, dbname)
            fmt.Println("conection string: ", psqlInfo)
            var err error
            dbDriver, err = sql.Open("postgres", psqlInfo)
            if err != nil {
                panic(err)
            }

            err = dbDriver.Ping()
            if err != nil {
                panic(err)
            }

            fmt.Println("Successfully connected to postgres!")
        }
        ```


4. First of all, let's register all the handlers that would be performing the `CRUD` operations. We are using a very efficient third-party router called ["gorilla mux"](https://github.com/gorilla/mux).  
    ```
    router := mux.NewRouter()
	router.HandleFunc("/customer", addCustomer).Methods("POST")
	router.HandleFunc("/customer/{id}", updateCustomer).Methods("PUT")
	router.HandleFunc("/customer/{id}", deleteCustomer).Methods("DELETE")
	router.HandleFunc("/customer", fetchCustomers).Methods("GET")
	log.Fatal(http.ListenAndServe(":8192", router))
    ```

5. Now let's write the handler for each of the operations. 
    Below is the handler for adding a new customer's details.   
    ```
    func addCustomer(w http.ResponseWriter, r *http.Request) {
        var requestbody customer
        if err := json.NewDecoder(r.Body).Decode(&requestbody); err != nil {
            http.Error(w, err.Error(), 500)
            return
        }
        fmt.Println("Data recieved: ", requestbody)
        if _, err := dbDriver.Exec("INSERT INTO customer(customer_id,customer_name) VALUES($1,$2)", requestbody.CustomerID, requestbody.CustomerName); err != nil {
            fmt.Println("Error in inserting to the database")
            http.Error(w, err.Error(), 500)
            return
        }
        fmt.Fprintln(w, "Successfully inserted: ", requestbody)
    }

    ```

    What it is doing is, first it is reading the request which contains a JSON data as body and unmarshalling it into `customer` struct, then it is making `INSERT`  query to the database to add the data.
    

6. The code for updating the user is as follows:-    
    ```
    func updateCustomer(w http.ResponseWriter, r *http.Request) {
        v := mux.Vars(r)
        idS := v["id"]
        id, _ := strconv.Atoi(idS)
        fmt.Println("Updating customer: ", id)
        var requestbody customerUpdate
        if err := json.NewDecoder(r.Body).Decode(&requestbody); err != nil {
            http.Error(w, err.Error(), 500)
            return
        }
        if _, err := dbDriver.Exec("UPDATE customer set customer_name=$1 where customer_id=$2", requestbody.CustomerName, id); err != nil {
            fmt.Println("Error in updating: ", err)
            http.Error(w, err.Error(), 500)
        }
        fmt.Fprintln(w, "Succesfully updated user")
    }
    ``` 

We pass the data to be updated in the `body` of the request and customer ID of the customer whose details are being updated is passed in the URL.  
(NOTE: later when you see the request you will understand it better, for now focus on the logic.)  
7. Let's try to `DELETE` a resource now.  

    ```
    func deleteCustomer(w http.ResponseWriter, r *http.Request) {
        v := mux.Vars(r)
        id := v["id"]
        fmt.Println("Deleting user: ", id)
        if _, err := dbDriver.Exec("DELETE FROM customer where customer_id=$1", id); err != nil {
            fmt.Println("Unable to delete the customer: ", err)
            http.Error(w, err.Error(), 500)
            return
        }
        fmt.Fprintln(w, "Successfully deleted!")
    }
    ```

In the above code, we are passing the ID of the customer to be deleted from our records. The query for deletion the simple `DELETE` command.  

8. Now finally, let's try to fetch the details of all customer data in JSON format.  
    ```
    func fetchCustomers(w http.ResponseWriter, r *http.Request) {
        fmt.Println("Fetching all customers")
        rows, err := dbDriver.Query("SELECT * from customer")
        if err != nil {
            fmt.Println("Unable to read the table: ", err)
            http.Error(w, err.Error(), 500)
            return
        }
        var customers []customer
        defer rows.Close()
        for rows.Next() {
            var c customer
            if err := rows.Scan(&c.CustomerID, &c.CustomerName); err != nil {
                fmt.Println("Unable to scan")
            }
            customers = append(customers, c)
        }
        customerJSON, err := json.Marshal(customers)
        if err != nil {
            fmt.Println("Unable to marshall the data: ", err)
            http.Error(w, err.Error(), 500)
            return
        }
        fmt.Println("Customers: ", customers)
        fmt.Fprintln(w, string(customerJSON))
    }
    ```
In the above code, we are querying for all the customer records, accessing them one by one and appending to a slice and finally serializing them into JSON using the `Marshall` method.   

The final code looks like:-
```
package main

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"strconv"

	"github.com/gorilla/mux"
	_ "github.com/lib/pq"
)

const (
	host   = "localhost"
	port   = 5432
	user   = "postgres"
	dbname = "guide"
)

var dbDriver *sql.DB

func init() {
	psqlInfo := fmt.Sprintf("host=%s port=%d user=%s dbname=%s sslmode=disable", host, port, user, dbname)
	var err error
	dbDriver, err = sql.Open("postgres", psqlInfo)
	if err != nil {
		panic(err)
	}

	err = dbDriver.Ping()
	if err != nil {
		panic(err)
	}

	fmt.Println("Successfully connected to postgres!")
}

type customer struct {
	CustomerID   int32
	CustomerName string
}
type customerUpdate struct {
	CustomerName string
}

// Adding a new customer to the database
func addCustomer(w http.ResponseWriter, r *http.Request) {
	fmt.Println("Adding a new customer")
	var requestbody customer
	if err := json.NewDecoder(r.Body).Decode(&requestbody); err != nil {
		http.Error(w, err.Error(), 500)
		return
	}
	fmt.Println("Data recieved: ", requestbody)
	if _, err := dbDriver.Exec("INSERT INTO customer(customer_id,customer_name) VALUES($1,$2)", requestbody.CustomerID, requestbody.CustomerName); err != nil {
		fmt.Println("Error in inserting to the database")
		http.Error(w, err.Error(), 500)
		return
	}
	fmt.Fprintln(w, "Successfully inserted: ", requestbody)
}

// Update the details of a customer
func updateCustomer(w http.ResponseWriter, r *http.Request) {
	v := mux.Vars(r)
	idS := v["id"]
	id, _ := strconv.Atoi(idS)
	fmt.Println("Updating customer: ", id)
	var requestbody customerUpdate
	if err := json.NewDecoder(r.Body).Decode(&requestbody); err != nil {
		http.Error(w, err.Error(), 500)
		return
	}
	if _, err := dbDriver.Exec("UPDATE customer set customer_name=$1 where customer_id=$2", requestbody.CustomerName, id); err != nil {
		fmt.Println("Error in updating: ", err)
		http.Error(w, err.Error(), 500)
	}
	fmt.Fprintln(w, "Succesfully updated user")
}

func deleteCustomer(w http.ResponseWriter, r *http.Request) {
	v := mux.Vars(r)
	id := v["id"]
	fmt.Println("Deleting user: ", id)
	if _, err := dbDriver.Exec("DELETE FROM customer where customer_id=$1", id); err != nil {
		fmt.Println("Unable to delete the customer: ", err)
		http.Error(w, err.Error(), 500)
		return
	}
	fmt.Fprintln(w, "Successfully deleted!")
}

func fetchCustomers(w http.ResponseWriter, r *http.Request) {
	fmt.Println("Fetching all customers")
	rows, err := dbDriver.Query("SELECT * from customer")
	if err != nil {
		fmt.Println("Unable to read the table: ", err)
		http.Error(w, err.Error(), 500)
		return
	}
	var customers []customer
	defer rows.Close()
	for rows.Next() {
		var c customer
		if err := rows.Scan(&c.CustomerID, &c.CustomerName); err != nil {
			fmt.Println("Unable to scan")
		}
		customers = append(customers, c)
	}
	customerJSON, err := json.Marshal(customers)
	if err != nil {
		fmt.Println("Unable to marshall the data: ", err)
		http.Error(w, err.Error(), 500)
		return
	}
	fmt.Println("Customers: ", customers)
	fmt.Fprintln(w, string(customerJSON))
}

func main() {
	router := mux.NewRouter()
	router.HandleFunc("/customer", addCustomer).Methods("POST")
	router.HandleFunc("/customer/{id}", updateCustomer).Methods("PUT")
	router.HandleFunc("/customer/{id}", deleteCustomer).Methods("DELETE")
	router.HandleFunc("/customer", fetchCustomers).Methods("GET")
	log.Fatal(http.ListenAndServe(":8192", router))
}
```


You can checkout the entire code in this [repository](https://github.com/souvikhaldar/golang-API-guide).

Now try the endpoints on `Postman` or `curl`.  
**Link to [API documentation](https://documenter.getpostman.com/view/1921454/SVYrsdwf) is here.**  

Now let's peek into the database once to see/cross-check how our data is stored.  
* `psql -U postgres -d guide` on the terminal.  
* `select * from customer` to see all the data that we've posted via our API.  

# Conclusion  
So our simple RESTful HTTP API built in pure Go is ready to serve requests! As further steps of deployment, you can write a simple [Ansible](https://www.ansible.com/) script and a corresponding [unit file](https://fedoramagazine.org/systemd-getting-a-grip-on-units/) which will keep your webserver running running and make `systemd` take away all the pain of maintainence! Welcome, to the world of Go, hope this article got you started and now you keep **GOing**.









