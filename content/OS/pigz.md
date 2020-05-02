---
title: "Pigz: The parallel gzip for modern processors"
date: 2020-05-02T13:57:20+05:30
draft: false
---

While compressing large amount of file using `gzip` I realised that it is quite slow, specially if you use `--best` flag for compressing maximum. While searching on web, I got hold of this tool named [pigz](https://zlib.net/pigz/) which is quite fast as it does the compression in a parralel manner accross multiple cores. The website explains it as:    
> pigz, which stands for parallel implementation of gzip, is a fully functional replacement for gzip that exploits multiple processors and multiple cores to the hilt when compressing data. pigz was written by Mark Adler, and uses the zlib and pthread libraries.   
Let me try to compress files using `pigz` and `gzip` see how fast can `pigz` get:  
CPU  
```
Vendor ID:                       GenuineIntel
CPU family:                      6
Model:                           142
Model name:                      Intel(R) Core(TM) i3-7020U CPU @ 2.30GHz
Stepping:                        9
CPU MHz:                         1102.124
CPU max MHz:                     2300.0000
CPU min MHz:                     400.0000
BogoMIPS:                        4599.93
Virtualization:                  VT-x
L1d cache:                       64 KiB
L1i cache:                       64 KiB
L2 cache:                        512 KiB
L3 cache:                        3 MiB
```
Memory status while running the tools:   
```
free -h
              total        used        free      shared  buff/cache   available
Mem:           11Gi       2.9Gi       2.6Gi       359Mi       5.9Gi       7.9Gi
Swap:         2.0Gi       710Mi       1.3Gi
```  
---

1)  For a single file

The original file:  
```
du VID_20200413_193959.mp4 
1649192	VID_20200413_193959.mp4
```  


*  Compressing this video file using `pigz`:  
    ```
    time pigz --best -k VID_20200413_193959.mp4 

    real	0m31.855s
    user	1m56.362s
    sys	0m2.726s

    ```
    Due to the parallel execution nature of `pigz` all the cores are being used simulataneously. Nice!  
    ![](/images/2020-05-02-15-33-21.png)  

    The output compressed file is:  
    ```
    du VID_20200413_193959.mp4.gz 
    1648308	VID_20200413_193959.mp4.gz
    ```


    *  Compressing using `gzip`:   
    ```
    time gzip --best -k VID_20200413_193959.mp4 

    real	1m16.566s
    user	1m14.458s
    sys	0m1.748s
    ```

    ![](/images/2020-05-02-15-29-49.png)  
    As you can see, due to the single threaded execution nature of `gzip` only one core is being used, that too 100%, while other cores are much free, which is not good!  

    The compressed output file:  
    ```
    du VID_20200413_193959.mp4.gz 
    1648068	VID_20200413_193959.mp4.gz
    ```
    ## Result:  
    ![](/images/2020-05-02-15-41-21.png)
    Even after trying to compress the same file multiple times, we see that `gzip` is faster and compresses more than `pigz`. Hence, parallel execution does not always guarantee faster execution.



2)  For a directory of files.

A directory containing multiple images of similar size.  
```
du -hs Me/
253M	Me/
```

*  Using `gzip`  
    ![](/images/2020-05-02-16-09-11.png)
    ```
    du meGzip.tar.gz 
    249408	meGzip.tar.gz
    ```


*  Using `pigz`  
    ![](/images/2020-05-02-16-10-48.png)  
    Compressed file:  
    ```
    du mePigz.tar.gz 
    249512	mePigz.tar.gz
    ```
    ## Result
    While dealing with parallel execution did help obtain faster compression speed!

## Final Conclusion:  
Here we can see that `pigz` is much faster then `gzip` but `gzip` was able to compress more! Hence when compressing multiple files, using `pigz` but for single file use `gzip`.  