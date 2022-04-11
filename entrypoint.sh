#!/bin/bash -e
if [ -f $GKE_SA ]
then
    echo "FOUND GCP Service Account - Attempting to login to GCP"
    gcloud auth activate-service-account --key-file=$GKE_SA
    gcloud container clusters get-credentials $GKE_CLUSTER --region $GKE_REGION --project $GKE_PROJECT
fi

if [ $DAEMON == "true" ]
then
    while true
    do
        sleep 1
    done
else
    kubectl $@
fi
