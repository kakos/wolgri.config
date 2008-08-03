#!/bin/sh
cat /proc/cpuinfo|grep MHz|uniq|awk '{print ($4)/1000}'
