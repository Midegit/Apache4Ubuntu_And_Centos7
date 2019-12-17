# Apache4Ubuntu_And_Centos7
Hello, this is my first GitHub repo and It is currently a mess.
Any feedback is more than welcome as I'm trying to learn more about SaltStack and posting to GitHub
This project is for learning SaltStack and all of this should be done as saltmaster.
NOTE: If you have no clue about SaltStack (master-slave architecture) visit the link below this line.
https://docs.saltstack.com/en/latest/

This shitshow works with following distros:
* Ubuntu 18.04.3 LTS
* CentOS Linux release 7.7.1908 (core)

STATES

#apache4both.sls
Downloads and manages Apache's webserver packages.
Allows you to manage virtualhosting easily as a saltmaster. (Uses pillardata)

#top.sls
#ptop.sls
Top files of /srv/salt & /srv/pillar
ptop.sls belongs to your pillar directory. Remember to rename ptop.sls to top.sls!
top.sls is your "base" top file what needs to be run as : "state.apply or state.highstate"

#apache.sls
This belongs to your pillar directory.
Includes domainname.
