#! /bin/sh

env LC_ALL=C tr -c -d '01'< /dev/random | head -c 1
