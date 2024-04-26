#!/bin/bash
size=1272
while ping -s $size -c1 -D 207.254.46.174 >&/dev/null; do 
  ((size+=4))
done
echo "Max MTU size: $((size-4+28))"
