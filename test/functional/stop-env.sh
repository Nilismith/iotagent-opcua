#!/bin/bash

mongodb_status=$(docker ps | egrep -c 'functional_mongodb')
iotcarsrv_status=$(docker ps | egrep -c 'functional_iotcarsrv')
orion_status=$(docker ps | egrep -c 'functional_orion')

if [ $mongodb_status -lt 1 ] && [ $mongodb_status -lt 1 ] && [ $orion_status -lt 1 ]; then
 echo "Test environment already stopped"
 exit 0
fi

docker-compose -f ./test/functional/docker-compose-test.yml down -v

while [ $(docker ps | egrep -c 'functional_mongodb') -gt 0 ]
do
 echo "Wait for mongodb to stop ... "
 sleep 0.5
done

while [ $(docker ps | egrep -c 'functional_iotcarsrv') -gt 0 ]
do
 echo "Wait for iotcarsrv to stop ... "
 sleep 0.5
done

while [ $(docker ps | egrep -c 'functional_orion') -gt 0 ]
do
 echo "Wait for orion to stop ... "
 sleep 0.5
done
