#!/bin/bash

cmd=$1
shift

init() {
   # This shouldn't be in the Dockerfile or containers built from the same image
   # will have the same credentials.
   if [ ! -e "$HOME/.bitcoin/bitcoin.conf" ]; then
      mkdir -p $HOME/.bitcoin
      bitcoind 2>&1 | grep "^rpc" > $HOME/.bitcoin/bitcoin.conf
   fi
}

case $cmd in
   shell)
      bash -l
      ;;
   init)
      init "@"
      exit 0
      ;;
   run)
      bitcoind "$@"
      exit $?
      ;;
   *)
      echo "Unknown cmd $cmd"
      exit 1
esac