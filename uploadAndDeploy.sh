ssh-add -D && ssh-add ~/.ssh/id_souvikhaldar
git add .
git commit -m "New backup `date +'%Y-%m-%d %H:%M:%S'`";
git push origin master
cd ~/Development/cloudhack
./deploy.sh
