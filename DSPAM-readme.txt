DSPAM
=====

DSPAM scanner/filter for QMailToaster

This installation assumes an onboard DSPAM filter with IMAP clients.
I've practically eliminated spam on my domain and 1 client's domain with this setup.

Unzip the file dspam-install-el.tar.gz in the current directory.
It will create a 'dspam' directory in the current direcotry.
Run the script dspam/dspamdb.sh. It will do the following:

1) Make sure that MySQL is installed and running; 
2) Remove any existing DSPAM database;
3) Create a new empty DSPAM database; 
4) Install epel repository;
5) Install dspam, dspam-client, and dspam-mysql from this repo;
6) Change permission on '/var/run/dspam'; 
7) Move old '/etc/dspam.conf' to '/etc/dspam.conf.bak' 
   and copy new dspam/dspam.conf to '/etc/dspam.conf';
8) Give the option to copy the old '~/mydomain.com/.qmail-default' to 
   '~/mydomain.com/.qmail-default.bak' and copy new 'dspam/.qmail-default' to
   '~/mydomain.com/.qmail-default'

I suppose I should add a call to install yum priorities in this script.

After this procedure is complete a DSPAM tag should be present in every email
header for the chosen domains. The DSPAM tags in the email header take the 
following form:

1) 'X-DSPAM-Result: Whitelisted' ;
2) 'X-DSPAM-Processed: Wed Jan 29 15:54:00 2014' ;
3) 'X-DSPAM-Confidence: 0.9979' ;
4) 'X-DSPAM-Improbability: 1 in 47847 chance of being spam' ;
5) 'X-DSPAM-Probability: 0.0000' ;
6) 'X-DSPAM-Signature: 1,52e9868836001165617631'

For training I create a '.spam' and '.notspam' directory for every IMAP user and 
train DSPAM on the email in these folders. I've never had to train any ham. DSPAM
works well for me without doing so.

The '.spam' folder is where users are to put spam marked as innocent.
The '.notspam' folder is where users are to put ham marked as spam.

I train on email by bash scripts in the following way 

1) For spam marked by DSPAM as spam, I simply delete it and don't train twice.
   The DSPAM result will be 'X-DSPAM-Result: Spam'

2) For spam marked by DSPAM as ham, I train with:
   cat $email | dspamc --user user@domain --mode=teft --class=spam --source=error
   The DSPAM result will be 'X-DSPAM-Result: Innocent'
   
3) For spam having no DSPAM tags in the email header I train with:
   cat $email | dspamc --user user@domain --mode=temp --class=spam --source=corpus
   This will occur if email has never been processed by DSPAM in .qmail-default
   
4) For ham marked by DSPAM as spam, I train with:
   cat $email | dspamc --user user@domain --mode=teft --class=innocent --source=error
   The DSPAM result will be 'X-DSPAM-Result: Spam'
   
To be continued...
