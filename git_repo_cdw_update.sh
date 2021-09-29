#!/bin/bash
d=`date`
git add *
git commit -m "Last update $d"
git fetch origin
git push origin main

