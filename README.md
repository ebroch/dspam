dspam
=====

dspam scanner/filter for QMailToaster

Unzip the file dspam-install-el.tar.gz in the current directory.
It will create a 'dspam' directory in the current direcotry.
Run the script dspam/dspamdb.sh. It will do the following:

1) Make sure that MySQL is installed and running; 
2) Remove any existing dspam database;
3) Create a new empty dspam database; 
4) Install epel repository;
5) Install dspam, dspam-client, and dspam-mysql from this repo;
6) Change permission on '/var/run/dspam'; 
7) Move old '/etc/dspam.conf' to '/etc/dspam.conf.bak' 
   and copy new dspam/dspam.conf to '/etc/dspam.conf';
8) Give the option to copy the old '~/mydomain.com/.qmail-default' to 
   '~/mydomain.com/.qmail-default.bak' and copy new 'dspam/.qmail-default' to
   '~/mydomain.com/.qmail-default'

After this procedure is complete a dspam tag should be present in every email
header for the chosen domains.

I suppose I should add a call to install yum priorities in this script.

For training I create a '.spam' and '.ham' directory for every IMAP user and 
train dspam on the email in these folders. I've never had to train any ham. Dspam
works so well for me without doing so. I just don't train ham. 

I train on email in the following way:

For email with dspam tag (X-DSPAM-Result: Spam) issue the following command:

cat $email | dspamc --user user@domain --mode=teft --class=spam --source=error

For email with no dspam header tag (For spam prior to implementing dspam): 

cat $email | dspamc --user user@domain --mode=temp --class=spam --source=corpus

For ham marked as spam:

cat $email | dspamc --user user@domain --mode=teft --class=innocent --source=error

To be continued...
