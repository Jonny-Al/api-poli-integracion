docker system prune

docker run -d -p 3306:3306 --name mysql-apiday -e MYSQL_ROOT_PASSWORD=password -d mysql

docker network create --attachable network-api-mysql

docker network connect network-api-mysql mysql-apiday

docker run -p 8080:8080 --env SPRING_PROFILES_ACTIVE=docker repository-app-day:1.0.0.0-SNAPSHOT
