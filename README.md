# Simple Git Server


## How to use?

### Initial Setup

- Run the server

  `docker compose up --build -d`

- Prepare your `authorized_keys` file.

- Create a copy of `example.env` and save it as `.env`

- Edit your `.env` file if needed.

- Put the path for your `authorized_keys` file as the value of `AUTHORIZED_KEYS` in the `.env` file.


### Create a remote repository with `REPO_NAME`

  `docker compose run server create REPO_NAME`


### Push existing repository to your git server

- Go to your local repository and add your origin

  `git remote add new_origin ssh://git@CONTAINER_IP:PORT/repos/REPO_NAME` (8000 is exposed by default on the host)

- Try to push your existing repo to the remote

  `git push new_origin master`

### Clone existing repository

`git clone ssh://git@CONTAINER_IP:PORT/repos/REPO_NAME.git`


### Delete remote repository with NAME

`docker compose run server delete NAME`


### List remote repositories

`docker compose run server list`


## How to stop

`docker compose down -t 1`


## Notes

Your remote repositories will be stored in a volume called `repos`.

