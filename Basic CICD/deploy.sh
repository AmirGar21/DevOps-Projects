#!/bin/bash

scp cat/build/s21_cat amir2@192.168.56.102:/tmp/
scp grep/build/s21_grep amir2@192.168.56.102:/tmp/
ssh amir2@192.168.56.102 "echo "1" | sudo -S mv /tmp/s21_cat /tmp/s21_grep /usr/local/bin"