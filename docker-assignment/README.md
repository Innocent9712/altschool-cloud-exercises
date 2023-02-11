## How to setup your environment

### prerequisites
- Have Docker engine installed
- Have docker compose installed

clone the repo https://github.com/f1amy/laravel-realworld-example-app.git as `app/`

copy the `docker-compose.yml`, `Dockerfile` files and `docker-compose/` directory to the root of the project `app/`

On your terminal. make sure you're in the root of the project `app/` and run the following command:

```shell
docker compose up -d
```

to bring up the containers. This would build the app image, spin it up. It'll also pull the mysql image and spin it up. It'll also pull the nginx image and spin it up.

```shell
docker ps
```

to check that the 3 containers are up and running
```shell
docker logs <container>
```

to see the log of a particular running container. Our containers are named app, db and nginx-server
And that's all. You're good to go.

Go to your browser and enter `localhost`( if you're running docker locally) or `<ip-address>` of you're using a remote VM. Make sure the necessary ports are open.

---

> P.S: if `docker compose` throws error, try `docker-compose` instead.

