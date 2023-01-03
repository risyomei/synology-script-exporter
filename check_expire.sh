#!/bin/bash

set -o pipefail
set -e

export http_proxy=http://nas-ubuntu.meleeh.com:3128/
export https_proxy=http://nas-ubuntu.meleeh.com:3128/

TargetDates=$(curl -s 'http://cloudcat.infra.cloudera.com/api/provisionedInstanceGroup/filter?filter.username=xli&filter.op.username=Equal&filter.provisionStatus=Destroyed&filter.op.provisionStatus=NotEqual' | jq -r '.provisionedInstanceGroupInstanceList[].expirationTime') 
WarningDate=$(date -d "5 days" +%Y-%m-%dT%H:%M:%S)

for dt in ${TargetDates:?};
do
  if [ ${dt:?} \< ${WarningDate:?} ];                                        
  then
    exit 9;
  fi
done;

exit 0;
