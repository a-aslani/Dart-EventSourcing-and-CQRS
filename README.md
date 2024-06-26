# Event-Driven Architecture in Dart

![Event-driven architecture](https://serverlessland.com/assets/visuals/eda/inside-eda.png)

Event-driven architecture (EDA) is a software architecture paradigm promoting the production, detection, consumption of, and reaction to events.

### Full list what has been used:
[EventStoreDB](https://www.eventstore.com) The database built for Event Sourcing<br/>
[PostgreSQL](https://pub.dev/packages/postgres) Application Database<br/>
[Shelf Router](https://pub.dev/packages/shelf_router) / [Shelf](https://pub.dev/packages/shelf) A lightweight, idiomatic and composable router for building Dart HTTP services<br/>

### Build and run with Docker compose
If you have [Docker Desktop](https://www.docker.com/get-started) installed, you
can build and run with the `docker` command:

```
$ docker compose up
Server listening on port 8080
```

### Swagger UI:

http://localhost:8000

### EventStoreDB UI:

http://localhost:2113