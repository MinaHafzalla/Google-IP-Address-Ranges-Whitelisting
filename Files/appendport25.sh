#!/bin/bash
sed -e 's/^/tcp|in|d=25|s=/' /usr/local/customscripts/csfallowgoogle/results.txt > /usr/local/customscripts/csfallowgoogle/port25.txt

