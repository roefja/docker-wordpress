#!/bin/bash

BASENAME='wordpress'
PROJECT='library'

# We are publishing via our own registry. Our own registry replicates to the public Docker Hub Repo
docker build -q -t registry.roefja.dev/"$PROJECT"/"$BASENAME" .
docker push -q registry.roefja.dev/library/"$BASENAME" 