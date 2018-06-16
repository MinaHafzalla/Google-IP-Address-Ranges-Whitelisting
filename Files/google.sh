#!/bin/bash
dig TXT +short _netblocks{,2,3}.google.com | tr ' ' '\n' | grep '^ip4:' | cut -c5-;dig TXT +short _netblocks{,2,3}.google.com | tr ' ' '\n' | grep '^ip6:' | cut -c5-