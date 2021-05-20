#!/bin/sh
curl --location --request POST 'http://localhost:1026/v2/subscriptions/' --header 'Content-Type: application/json' --data-raw '{
  "description": "Notify QuantumLeap of all sensor changes",
  "subject": {
    "entities": [
      {
        "idPattern": ".*",
        "type": "csv_value"
      }
    ],
        "condition": { "attrs": [] }
  },
  "notification": {
    "http": {
      "url": "http://10.1.20.246:8668/v2/notify"
    },
        "attrs": [],
    "metadata": ["dateCreated", "dateModified"]
  }
}'
