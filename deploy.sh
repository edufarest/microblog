#!/bin/bash

mix deps.get
export MIX_ENV=prod
mix phx.digest
mix release --env=prod
scp _build/prod/rel/microblog/releases/0.0.1/microblog.tar.gz microblog@eduardofares.com:~/

# Run deploy command on server
ssh microblog@eduardofares.com ~/deploy.sh
