#!/bin/bash


# install necessary packages

pip install psycopg2==2.6.2

pip install tweepy

### set up  with the twitter credentials 

python Twittercredentials.py

### needs to check if the database has been set and ask if you want to clear the data base

python db_create.py


# clean exit

exit
