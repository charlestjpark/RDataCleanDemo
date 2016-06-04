# Introduction

This project, in fulfilmment of a course offered by Johns Hopkins University entitled "Getting and Cleaning Data",
is a demonstration of ability to collect, work with, and clean a data set in a reproducible manner. 

The sample data is drawn from this link:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Ths data is based on data collected from the accelerometers in the Samsung Galaxy S smartphone. 

At high level, the main script run_analysis.R performs the following: 
1. Merge the training and test sets to create one data set. 
2. Extract only the measurements on the mean and standard deviation for each measurement. 
3. Use descriptive activity names to name the activities in the data set
4. Appropriately label the data set with descriptive variable names 
5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for
   each activity and each subject. 