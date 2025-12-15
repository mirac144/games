#!/bin/bash

SAYI=1000

for i in $(seq 1 $SAYI); do
    google-chrome --new-window &
done
