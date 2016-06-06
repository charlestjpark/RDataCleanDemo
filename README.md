# A Demonstration on Data Wrangling in R 

This project, in fulfillment of a course offered by Johns Hopkins University entitled "Getting and Cleaning Data",is a demonstration of collecting, working with, and cleaning a data set in a reproducible manner. 

The sample data is drawn from this link:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Ths data is based on user motion as measured by the accelerometers in the Samsung Galaxy S smartphone. 

## Description of Functionality
At high level, the main script run_analysis.R performs the following: 
 1. Merge the training and test sets to create one data set. 
 2. Extract only the measurements on the mean and standard deviation for each measurement through  text parsing. 
 3. Use descriptive activity names to name the activities in the data set using table joins. 
 4. Appropriately label the data set with descriptive variable names sourced from pre-existing files.  
 5. From the data set in step 4, create a second, independent tidy data set summarising the 
 average of each variable for each activity and each subject. 

## Expected Behavior
By running run_analysis.R, it will create a local directory called RDataCleanDemoData in your current working directory, into which the script downloads the zip folder and extracts its contents. This results in another sub-directory called UCI HAR Dataset. Within UCI HAR Dataset, there is relevant information stored in text files on the activity labels, a list of features, feature descriptions to inform which should be parsed and how they should be re-named, and a profile of the training and test subjects and measurements. The final data frame that's computed is called final_data, which is exported to an output text file called final_data.txt within your working directory. The specifics of what the code is doing line-by-line is detailed by comments within the run_analysis.R scripts. 