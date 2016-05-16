## Docker

Create a env in just a minute using docker with this repo. It was specially created to run edirectory >= 11.0.0

#### Requirements
* (Docker v1.11.0)[https://docs.docker.com/engine/installation/]
* (Docker Compose v1.70.0)[]

#### What this include?
* It has PHP 5.6
* Apache 2.4
* Mysql 5.6
* Elasticsearch 2.3

#### Usage

Download this repo and put it in edir's folder(root level), at the same level of the web folder. Goes to the folder and run:

To run:
`
docker-compose up # you can use the flag "d" together. It hides logs message from up.
`

To stop:
`
docker-compose stop
`

##### Errors? Improvements
If you find an error, just create a ticket and I'll be notified. You can do the same for improvements.


DISCLAIME: Use it at your own risk. This env is used by me to develop the edirectory and for a better management of the enviroment.
