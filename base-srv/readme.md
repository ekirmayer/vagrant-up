# Development Environment #

Here you will find the full stack environment required for the develop process. 
The repository contains the following machines:

1. base-dev - This is where basic 3rd-party components are defined. - containing:
    * mongodb:4.0
    * confluent:kafka/zookeeper. 
    * PostgreSQL
    * MySQL
    * Redis
    * Minio
2. elk-dev - contains the elastic stack (elasticsearch, logstash and kibana). This service is off be default
3. selenium - A selnium hub deployment with 1 chrome endpoint executor

## Stack ##

1. Vagrant
2. docker


## How to use the solution ##

This is a vagrant solution. To start the instances use - ``vagrant up``
By default, only the base-dev VM with the base services (mongo, confluent, ZK, PosgreSQL) will be started.
You control what to start by changing the config.yml file. Change to true the services you wish to load.
Once "vagrant up" is done, you can connect to the services based on the machines ip with the appropriate port.

Run Only base-dev:

```bash
    vagrant up base-dev
```

Run Only selenium:

```bash
    vagrant up selenium
```

### Configuration ###

By default, the ips are:

* base-dev - 192.168.20.31
* elk-dev - 192.168.20.32
* selenium - 192.168.20.33

Base-dev:

    Mongo
        * PORT: 31017

    PostgreSQL
        * Database
            * PORT: 5432
            * Username: postgres
            * Password: 12345
        * pgAdmin4
            * PORT: 8080
            * Username: ser@domain.com
            * Password: 12345

    Kafka
        * Zookeeper PORT: 2181
        * Kafka PORT: 9092
        * Kfdrop PORT: 9000 (This will show the status of the kafka)

    MySQL
        * Server
            * PORT: 32306
        * phpMyAdmin:
            * PORT: 32082
    Minio
        * PORT: 32000

Selenium:

    url: http://192.168.20.33:4444/grid/console
