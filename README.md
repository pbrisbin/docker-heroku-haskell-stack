# Heroku Haskell Docker Image

This image is for use with Heroku Docker CLI.

## Usage

To build, your project must have

- A `stack.yaml`
- A cabal file
- A LICENSE

This build stops after `stack build --dependencies-only`, so your own Dockerfile
should `COPY` in the appropriate source files and `RUN` `stack install` itself.

Example:

```
FROM pbrisbin/heroku-haskell-stack:1.0.2
MAINTAINER Pat Brisbin <pbrisbin@gmail.com>

COPY src /app/user/src
COPY app /app/user/app
RUN stack install
```

Executables will be installed in `/app/user/bin`, which is added to `$PATH`, in
case you want to set one as `CMD`.

To deploy, your project must have

- A `Procfile`:

  ```
  web: ./bin/foo
  ```

- An `app.json`:

  ```json
  {
    "name": "foo",
    "description": "Doesn't matter"
  }
  ```

- A `docker-compose.yml`

  ```yml
  web:
    build: .
  ```

Then run `heroku docker:release`
