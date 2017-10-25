#!/bin/bash

# save my current directory
MY_CWD=$(pwd)

# creating our staging directories
mkdir ~/staging
mkdir ~/staging/exercise_1

# change to staging directory
cd ~/staging/exercise_1

#get file from data.medicare.gov
MY_URL="https://data.medicare.gov/views/bg9k-emty/files/4a66c672-a92a-4ced-82a2-033c28581a90?content_type=application%2Fzip%3B%20charset%3Dbinary&filename=Hospital_Revised_Flatfiles.zip" 
wget "$MY_URL" -O medicare_data.zip

# unzip the medicare data
unzip medicare_data.zip

# remove the first line of files and rename

OLD_FILE_ARRAY=("Hospital General Information.csv" "Timely and Effective Case - Hospital.csv" "Complications and Deaths - Hospital.csv" "Measure Dates.csv" "hvbp_hcahps_11_10_2016.csv")

NEW_FILE_ARRAY=("hospitals.csv" "effective_care.csv" "readmissions.csv" "measures.csv" "surveys_responses.csv")

for INDEX in ${!OLD_FILE_ARRAY[@]}; do
	OLD_FILE="${OLD_FILE_ARRAY[INDEX]}"
	NEW_FILE="${NEW_FILE_ARRAY[INDEX]}"
	tail -n +2 "$OLD_FILE" >"$NEW_FILE"
done

# create our hdfs directory

hdfs dfs -mkdir /user/w205/hospital_compare

# copy the field to hdfs

for INDEX in ${!NEW_FILE_ARRAY[@]}; do
	NEW_FILE="${NEW_FILE_ARRAY[INDEX]}"
	hdfs dfs -put "$NEW_FILE" /user/w205/hospital_compare
done

# change directory back to the original

cd $MY_CWD

# clean exit

exit

