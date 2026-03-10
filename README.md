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
