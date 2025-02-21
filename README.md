# Negotiator

An app that helps you to practice negotiations with ChatGPT.

## Exercise

- Deploy your app to a cloud platform (like GCP's Cloud Run).
- Use a GitHub actions pipeline to automatically deploy.
- Also deploy your app to a production environment after it has deployed to your staging environment.

## Architecture

Negotiator is a server side rendered app using [Flask](https://flask.palletsprojects.com/).
It uses [Lit](https://lit.dev/) to create [web components](https://developer.mozilla.org/en-US/docs/Web/API/Web_components)
to add dynamic capabilities to each page.
Lit web components are developed and tested in the [web components](./web-components) directory, and build Javascript
and CSS artifacts are copied to the Flask app's [static](./negotiator/static) directory.
This approach allows for the simplicity of server side rendered app with the dynamic features of a single page app.

## Build and run

1.  Install [uv](https://docs.astral.sh/uv/) and dependencies.
    ```shell
    brew install uv nodejs postgresql@14
    brew services run postgresql@14
    make install
    ```

1.  Set up the environment.
    ```shell
    cp .env.example .env
    vi .env
    source .env
    ```

1.  Set up the database.
    ```shell
    psql postgres < databases/drop_and_create_databases.sql
    make migrate migrate-test
    ```

1.  Build the frontend and watch for changes.
    ```shell
    make web-components/watch
    ```

1.  Run the fake oauth server in a separate terminal.
    ```shell
    make fake-auth/run
    ```

1.  Run the app in a separate terminal.
    ```shell
    source .env
    make negotiator/run
    ```

1.  Run tests.
    ```shell
    make test
    ```

### Run with Docker
   
1.  Build container
    ```shell
    make web-components/build
    uv pip compile pyproject.toml -o requirements.txt
    docker build -t negotiator . 
    ```

1.  Run with docker
    ```shell
    docker run -p 8081:8081 --env-file .env.docker negotiator
    ```   
