Define the following environment vars:

```
S2S_TOKEN=<randomstring>
S2S_TARGET=<Incoming hook Slack URL>
```

Publish this app somewhere and then add a webhook to semaphore with the following URL:

`http://domain.com/<S2S_TOKEN>`
