#!/bin/bash
head -5 /usr/local/customscripts/csfallowgoogle/finalgoogleips.txt > /usr/local/customscripts/csfallowgoogle/finalgoogleips.txt.TMP

# append new data
cat /usr/local/customscripts/csfallowgoogle/port25.txt >> /usr/local/customscripts/csfallowgoogle/finalgoogleips.txt.TMP

# rename output file atomically in case of system crash
mv /usr/local/customscripts/csfallowgoogle/finalgoogleips.txt.TMP /usr/local/customscripts/csfallowgoogle/finalgoogleips.txt



# repeat the 3 above commands again
head -80 /usr/local/customscripts/csfallowgoogle/finalgoogleips.txt > /usr/local/customscripts/csfallowgoogle/finalgoogleips.txt.TMP

# append new data
cat /usr/local/customscripts/csfallowgoogle/port465.txt >> /usr/local/customscripts/csfallowgoogle/finalgoogleips.txt.TMP

# rename output file atomically in case of system crash
mv /usr/local/customscripts/csfallowgoogle/finalgoogleips.txt.TMP /usr/local/customscripts/csfallowgoogle/finalgoogleips.txt