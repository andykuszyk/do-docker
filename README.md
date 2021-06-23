# do-docker
This repo contains a `docker-compose` file which is used to run containers on my Digital Ocean droplet.

## Running locally
* Add host overrides with `sudo make hosts`
* `docker-compose up`
* Open a site, e.g. http://budjot.com, and (in Chrome) type `thisisunsafe` (to bypass the self-signed certificates). 

## Running tests
Some simple smoke tests can be run with `./test.sh`, or with `sudo make test` to perform all the pre-requisites.

## Generating test certificates
* `cd` into the relevant folder in `./certs/`.
* `openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ./privkey.pem -out ./fullchain.pem`

## Deploying new versions of services
Services that are deployed through this repo can be updated to newer versions using the `make release-service` target, e.g:

```sh
make release-service SERVICE=akuszyk TAG=latest
```

## Certificate creation using LetsEncrypt
* `ssh` onto the Docker host
* Manually edit the `nginx.conf` and add an additional `location` directive to the server that needs a certificate like the example below:
```conf
location ^~ /.well-known {
    allow all;
    root /data/letsencrypt/;
}
```
* Restart the `nginx` Docker container (`docker kill`)
* `sudo certbot certonly --webroot -w /root/certs-data/ -d <dns-name>.co.uk -d www.<dns-name>.co.uk`
* Add an HTTP redirect to the `nginx` config and an SSL block to the server configuration.
