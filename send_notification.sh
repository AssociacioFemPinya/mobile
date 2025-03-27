#!/bin/bash

export GOOGLE_APPLICATION_CREDENTIALS=${1}
SERVER_KEY=$(gcloud auth application-default print-access-token)
DEVICE_TOKEN=${2}

curl -X POST "https://fcm.googleapis.com/v1/projects/fempinya3-73ef3/messages:send" \
  -H "Authorization: Bearer $SERVER_KEY" \
  -H "Content-Type: application/json" \
  -d "{
  \"message\": {
    \"token\": \"${DEVICE_TOKEN}\",
    \"notification\": {
      \"title\": \"Test Notification\",
      \"body\": \"This is a test push notification\"
    },
    \"data\": {
      \"action_url\": \"event\",
      \"resource_id\": \"9651\"
    }
  }
  }"
