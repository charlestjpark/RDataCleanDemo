## Load 3 relevant libraries and install them if library is not found. 
if(!require("downloader")){
    install.packages("downloader")
}
library(downloader)
if(!require("dplyr")){
    install.packages("dplyr")
}
library(dplyr)
if(!require("sqldf")){
  install.packages("sqldf")
}
library(sqldf)

## Download the zip folder into a new directory to be formed called RDataCleanDemoData, then
## unzip all its contents into that directory. 
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if(!file.exists("./RDataCleanDemoData")){dir.create("./RDataCleanDemoData")}
download(url, dest="./RDataCleanDemoData/dataset.zip", mode = "wb")
unzip(zipfile = "./RDataCleanDemoData/dataset.zip", exdir = "./RDataCleanDemoData")

## Store the training and test sets as data frames, then merge them  into one larger data set
train <- read.table("./RDataCleanDemoData/UCI HAR Dataset/train/X_train.txt")
test <- read.table("./RDataCleanDemoData/UCI HAR Dataset/test/X_test.txt")
alldata <- rbind(train, test)

## Extract only the mean and standard deviation attributes for each measurement (e.g. 
## fBodyGyro-mean(), etc.). First obtain vector of attribute names,then get index for attributes
## that are means or standard deviations.Then, use index of relevant attributes to parse the 
## relevant columns into reldata as well as rename them by reading the names from text file.
## Clean out the label names by removing all instances of "-" and "()" from the name using gsub()
## and principles from Regular Expressions parsing. 
attr <- read.table("./RDataCleanDemoData/UCI HAR Dataset/features.txt")
attr_index_mean <- grep("mean()", attr[,2])
attr_index_std <- grep("std()", attr[,2])
attr_index <- sort(c(attr_index_mean, attr_index_std))
reldata <- alldata[, attr_index]
attr_name <- attr$V2[attr_index] 
attr_name <- gsub("-", "", attr_name)
attr_name <-gsub("\\()", "", attr_name)
names(reldata) <- attr_name 

## Need to find the subject id and add them as another feature column 
subject_train <- read.table("./RDataCleanDemoData/UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("./RDataCleanDemoData/UcI HAR Dataset/test/subject_test.txt")
all_subject <- rbind(subject_train, subject_test)
names(all_subject) <- "Subject"

## Label each row activity using the training and test labels, then encode labels as activities.
## Perform a left join between the list of activity labels and the look up table given from 
## activity_labels.txt to match to the corresponding activity name. 
activity_label <- read.table("./RDataCleanDemoData/UCI HAR Dataset/activity_labels.txt")
train_label <- read.table("./RDataCleanDemoData/UCI HAR Dataset/train/y_train.txt") 
test_label <- read.table("./RDataCleanDemoData/UCI HAR Dataset/test/y_test.txt") 
all_label <- rbind(train_label, test_label)
## Alternative is to use left_join command from dplyr
all_label <- sqldf('SELECT activity_label.V2 as Activity 
                    FROM all_label LEFT JOIN activity_label
                    ON all_label.V1 = activity_label.V1') 
names(all_label) <- "Activity"

## Set up a prepared data set profiling the test subjects, their activities, and related mean 
## and standard deviation measurements. These measurements are to be grouped as the average of
## each group and each subject. For n participants, assuming each participant undertook m
## activities, there would be m*n different categories to report the mean of the mean and 
## standard deviation for all other measurements that are ungrouped. 
prepared_data <- cbind(all_subject, all_label, reldata)
final_data <- prepared_data %>%
              group_by(Subject, Activity) %>%
              summarise_each(funs(mean), tBodyAccmeanX:fBodyBodyGyroJerkMagmeanFreq)

## Export the final data to a text file called final_data.txt in the working directory.
## Each entry between columns (both column names and measurements) are single space delimited. 
write.table(final_data, "final_data.txt", row.name = FALSE)

