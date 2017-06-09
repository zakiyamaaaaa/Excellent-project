# API Server

## REFERENCE

## ENVIRONMENT
* go 1.8
* glide 0.12.3
* mysql 5.7.17

## DEVELOPMENT

#### SETUP
```
# install go, glide and docker. setup GOPATH.

# initialize docker container
docker-compose up -d

git clone https://github.com/zakiyamaaaaa/excellent-project.git
cd excellent-project
glide install
```

## PRODUCTION

```
# docker install(centos)
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum-config-manager --enable docker-ce-edge
sudo yum makecache fast
sudo yum install docker-ce-17.04.0.ce-1.el7.centos
 
# startup docker deamon
sudo systemctl start docker
 
# startup docker mysql
sudo docker run --name mysql -d -p 3306:3306 -v /home/yamazaki/mysql:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=root
  mysql:5.7.17
```