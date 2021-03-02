#!/bin/bash

CURRENT=`pwd`
BASENAME=`basename "$CURRENT"`

version=''

while getopts ":v:" opt; do
  case ${opt} in
    v )
      version=$OPTARG
      ;;
    \? )
      echo "Invalid option: $OPTARG" 1>&2
      ;;
    : )
      echo "Invalid option: $OPTARG requires an argument" 1>&2
      ;;
  esac
done
shift $((OPTIND -1))

docker build -q -t registry.roefja.dev/library/"$BASENAME" .

if [ -n "${version}" ]; then
docker tag registry.roefja.dev/library/"$BASENAME" registry.roefja.dev/library/"$BASENAME":v-$version
fi


docker push -q --all-tags registry.roefja.dev/library/"$BASENAME" 