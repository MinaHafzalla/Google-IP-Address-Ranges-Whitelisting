#!/bin/bash
sed -e 's/^/tcp|in|d=465|s=/' /usr/local/customscripts/csfallowgoogle/results.txt > /usr/local/customscripts/csfallowgoogle/port465.txt

