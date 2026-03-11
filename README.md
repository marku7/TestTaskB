# TestTask Project

A simple and efficient task management application built with Laravel and Docker.

## Prerequisites

Ensure you have the following installed on your machine:
- [Docker](https://www.docker.com/) & [Docker Compose](https://docs.docker.com/compose/)
- [Make](https://www.gnu.org/software/make/)
- [Git](https://git-scm.com/)

## Getting Started

Follow these steps to get the project up and running:

1. **Clone the repository**
   ```bash
   git clone https://github.com/marku7/TestTaskB.git
   cd TestTaskB
   ```

2. **Run the setup**
   This command will handle environment setup, container building, migrations, and seeding.
   ```bash
   make setup
   ```

## Access the Application

Once the setup is complete, you can access the following services:

- **Web Application:** [http://localhost:8000](http://localhost:8000)
- **Database (phpMyAdmin):** [http://localhost:8080](http://localhost:8080)

## Available Commands

- `make run`: Start all containers
- `make build`: Build Docker images
- `make down`: Stop and remove containers
- `make restart`: Restart all containers
- `make logs`: View container logs


--------------------------------------------------------
## BONUS QUESTION
###	Have you ever built a multi-stage Dockerfile? If yes, walk us through why you split the stages the way you did and what it saved you.
    ## I have initially setup this as a multi stage Dockerfile, but i changed this to efficiently work with this test task that can only run using one command.

###	If two containers need to talk to each other but neither should be exposed to the outside world, how do you set that up?
    ## I have created a network called testtask_network in my app container inside my docker compose file so that my containers can communicate since they belong to the same network.
    
### What is the difference between a bind mount and a named volume, and when would you use one over the other?
     The bind mount is the very link of my project folder so when i save a file it will see it instantly, while a named volume is directory that is from the docker container, so its like a safebox for my project.

###	Your database container starts before your app is ready and the app crashes on boot because the connection is not available yet. How do you solve that?
    ## In this test task my approach is i have added a wait loop for my database to load in my entrypoint, that is trying to connect to db until its ready.
    
## What does a production Dockerfile look like versus a development one? What changes and why?
    I currently no exposure or experience in production Dockerfile, but i think my current setup is looking ready for the production since its like a multi stage Docker for my CSS/JS. 
    
###	Walk us through how you would handle environment-specific configuration — dev, staging, prod — without duplicating your entire compose file.
   ## I have used my .env file to make sure that the current setup and configuration the same for other users. 
   
## How do you make sure a secret like a database password never ends up in your image or your git history?
    To keep the credentials like passwords ending up in my image or git is i put them to the .env since this is private and ignored in git.
    
### Your container is running but the app inside it is hanging. It is not crashing, just unresponsive. How do you debug that without restarting it?
    To debug that problem without restarting is i just clear some cache using the docker exec command.

### What is a health check and why does it matter beyond just "is the container running"?
    The health check is to make sure that its running first, thats why i have added this in my docker compose whjere it make sures that its ready or running before the other container, its like a ping check.

###	If you had to bring an entire stack up — app, database, reverse proxy — run migrations, and seed data, all in one command, how would you build that?
    ## I need to bring the entire stack up just like in this test task, i would create a docker compose, dockerfile, an entrypoint, and a make file. For this project i have created a "make setup" to bring the entire stack up, making it more easy for other user to run this app in their device.
