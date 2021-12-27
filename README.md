*Developed by Mina Hafzalla*
# Google IP Address Ranges Whitelisting
If your server is set to use G Suite (Google Apps formerly) to handle your emails, and your server's firewall is set to block SMTP ports for public, then you will need to whitelist Google IP address ranges for outbound SMTP in order for Google to properly send emails.

This program is written in Bash and it automates the process of retrieving Google IP address ranges, updating them on daily basis and whitelisting them within the firewall configuration.

# Requirements
1.	Linux Server.
2.	SSH access with root/sudo privileges.
3.	Bash Shell.
4.	ConfigServer (CSF) Firewall.

*Note: This program has been implemented and tested on CentOS servers and ConfigServer (CSF) firewall. It should work with all other Linux distributions. However, the program is configured to work according to ConfigServer (CSF) firewall rules and it is not guaranteed to work with other firewall software.*

# How it works
The program consists of four (4) Bash scripts that run in a sequential order; it basically retrieves Google IPs, exports them to a text file, then by using Bash text manipulation techniques, it appends SMTP ports to the retrieved IP address ranges, formats them according to the firewall reading rules, then exports the final IPs to another text file which is included inside the firewall configuration file for whitelisting.

### Files
1.	*google.sh* - Retrieves Google IP address ranges and exports them to *results.txt* file.
2.	*appendport25.sh* - Gets IPs from *results.txt*, format and append port 25, then export them to *port25.txt*.
3.	*appendport465.sh* – Gets IPs from *results.txt*, format and append port 465, then export them to *port465.txt*.
4.	*tofinalgoogleips.sh* – Combines results from *port25.txt* and *port465.txt* files and export them to *finalgoogleips.txt*.

# Installation
I have included the required files in a single compressed [tar.gz](https://github.com/MinaHafzalla/Google-IP-Address-Ranges-Whitelisting/tree/master/Download) file so you can download it directly to your server. I have also included a non-compressed version [here](https://github.com/MinaHafzalla/Google-IP-Address-Ranges-Whitelisting/tree/master/Files).

### Part 1
1.	Open your SSH client and login to your server.
2.	Run the command line `mkdir -p /usr/local/customscripts/csfallowgoogle`
3.	Run `cd /usr/local/customscripts/csfallowgoogle`
4.	Run the following command to download the program to your server `wget https://github.com/MinaHafzalla/Google-IP-Address-Ranges-Whitelisting/blob/master/Download/csfallowgoogle.tar.gz`
5.	Uncompress the file by running the command `tar zfvx csfallowgoogle.tar.gz`

### Part 2
Now you need to setup cron jobs to tell the server to execute these scripts at a specific time in a sequential order and every day as we need to daily update the IP address ranges.
1.	Run the command `vi /etc/crontab`
2.	Hit the `i` key on your keyboard to start inserting.
3.	Copy and paste the following in the crontab file.
```
25 16 * * * root bin/bash /usr/local/customscripts/csfallowgoogle/google.sh > /usr/local/customscripts/csfallowgoogle/results.txt 2>&1
26 16 * * * root bin/bash /usr/local/customscripts/csfallowgoogle/appendport25.sh
27 16 * * * root bin/bash /usr/local/customscripts/csfallowgoogle/appendport465.sh
28 16 * * * root bin/bash /usr/local/customscripts/csfallowgoogle/tofinalgoogleips.sh
29 16 * * * root /usr/sbin/csf -r >/dev/null 2>&1
30 16 * * * root /usr/sbin/lfd –r
```
4.	Hit the `Esc` key on your keyboard to exit the editing environment.
5.	Type `:wq` and press `Enter` to save edits and exit the file.

Now we've configured the server to execute the program using cron jobs starting at 4:25pm every day at server's time zone. 

### Part 3
Last thing is to include the file `finalgoogleips.txt` inside the firewall configuration file so that the firewall opens SMTP communication for those listed IPs.
1.	Run the command `vi /etc/csf/csf.allow`
2.	Hit the `i` key on your keyboard to initiate the editing interface.
3.	Copy and paste the following line: `include /usr/local/customscripts/csfallowgoogle/finalgoogleips.txt`
4.	Press the `Esc` key on your keyboard.
5.	Run the command `:wq` to save and exit.
6.	Run the command `csf –r` followed by `lfd –r` to restart the firewall.

Congratulations! You are all set now and your server is set to allow Google IP address ranges for SMTP communications.

# Questions
Please leave a comment or send me an email at minahafzalla@gmail.com if you have any questions.
