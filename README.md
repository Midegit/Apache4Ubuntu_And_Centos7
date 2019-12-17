SaltStack

Hello, this is my first GitHub repo and It is currently a mess.
Any feedback is more than welcome as I'm trying to learn more about SaltStack and posting to GitHub.

Requisities:
* Working master-slave architecture
* Already configured file_roots:
(Master config)

This "project" is for learning SaltStack and all of this should be done as saltmaster.
I used Ubuntu 18.04.3 LTS as my saltmaster's distro, and saltstack version of 2019.2.2.
NOTE: If you have no clue about SaltStack (master-slave architecture) visit here: https://docs.saltstack.com/en/latest/

Works with following distros:
* Ubuntu 18.04.3 LTS
* CentOS Linux release 7.7.1908 (core)

STATES

#apache4both.sls: 
Downloads and manages Apache's webserver packages.
Allows you to manage virtualhosting easily as a saltmaster. (Uses pillardata)

#top.sls and ptop.sls: 
Top files of "base" and "pillar"

ptop.sls belongs to your pillar directory.
REMEMBER TO RENAME ptop.sls to top.sls in order to make this work!

top.sls is your "base" top file what needs to be run as : "state.apply or state.highstate"

#apache.sls:
 This belongs to your pillar directory and it's for configuring domainname.
