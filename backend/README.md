# SafeAlert Backend API

## Description

The backend code of product SafeAlert in GDSC - DUT

## For backend team

### Installation

```bash
# install dependencies
$ npm install
```

### Database initialization

```bash
$ docker compose up -d init_db
```

-   **Note:** Remember to add `--build` option when running the init_db the first time

### Migration

```bash
# Reset database
$ npm run db:reset

# Create new migration file
$ npm run knex migrate:make <migration_name_file.js>

# Run the migration
$ npm run knex migrate:latest

# Rollback the migration
$ npm run knex migration:rollback
```

### Seeding

```bash
# Create seed file
$ npm run knex seed:make <seed_name_file.js>

# Run all seed file
$ npm run knex seed:run

# Run specific seed file
$ npm run knex seed:run --specific=<seed-filename.js>
```

For more information you can read at Knexjs docs

https://knexjs.org/guide/migrations.html#migration-cli

### Run the backend code

```bash
# Dev mode
$ npm run dev

# Production mode
$ npm start
```

Access `localhost:3000/docs` to view the Swagger Docs

### Husky

Run the following command when you first clone the repo

```bash
$ cd backend

$ npm run prepare
```

### Commit convention

View the `commitlint.config.js` file to follow commit convention

## For Frontend and Mobile team

### Run the api

```bash
$ docker compose up -d api
```

-   **Note:** Remember to add `--build` option when running the init_db the first time
