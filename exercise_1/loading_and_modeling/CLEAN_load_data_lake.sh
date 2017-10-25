#!/bin/bash

# save my current directory
MY_CWD=$(pwd)

# empty and remove our staging directories
rm ~/staging/exercise_1/*
rmdir ~/staging/exercise_1/
rmdir ~/staging

#remove hospital_compare parent directory and subfiles and folders recursively from hdfs

hdfs dfs -rm -r /user/w205/hospital_compare

# change directory back to the original

cd $MY_CWD

# clean exit

exit
