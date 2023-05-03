# Purpose

> WIP - code sample to use Azure Service Bus with Ruby consumers without Azure's SDK (deprecated) - currently it's NOT working :)

# Pre-requisities

- An Azure Service Bus (standard SKU) namespace
- RootManageSharedAccessKey's primary key

# Test

- Update service bus namespace name / credentials / queue name in Ruby files
- Edit `Dockerfile` to chose the implementation to test

Then,

```
docker build -t ruby-sb-amqp .
docker run ruby-sb-amqp
```