# chicken-web

A template for CHICKEN scheme web programming

## Dependencies installation

Init CHICKEN repository:

```sh
chicken-install -init vendor
```

Install dependencies:

```sh
CHICKEN_REPOSITORY=$PWD/vendor chicken-install spiffy:5.3.2
CHICKEN_REPOSITORY=$PWD/vendor chicken-install spiffy-uri-match:0.3
CHICKEN_REPOSITORY=$PWD/vendor chicken-install sxml-transforms:1.4.1
```

## Running

### Using [foreman](https://ddollar.github.io/foreman/)

- Create .env file (use .env.def as template)

- Start foreman

```sh
foreman start
```

- Browse http://localhost:5000


### Manual

Pass env vars:

```sh
CHICKEN_REPOSITORY=$PWD/vendor PORT=5000 csi -s web.scm
```