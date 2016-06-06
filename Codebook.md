# Codebook for final_data.txt  

The data frame stored in final_data consists of 180 rows by 81 columns. 

Each row corresponds to a single grouping of subject and activity. As there were 30 subjects and each subject undertook 6 activities, there are there 180 categories to consider for each unique subject-activity pair. 

Of the 81 columns, the first column corresponds to the subject id. As there were 30 subjects being tested, the value of the subject id ranges from 1 to 30. The second column corresponds to the Activity in which the subject was participating, which takes one of six values including "LAYING", "SITTING", "STANDING", "WALKING", "WALKING_DOWNSTAIRS", and "WALKING_UPSTAIRS". The pair {Subject, Activity} form a key for the final data set. 

The remaining 79 columns correspond to various mean measurements of the mean and standard deviations parsed from the original 561-feature set. Details on the original features are in the features.txt and features_info.txt files, found in the UCI HAR Dataset directory. The names for these columns were parsed by selecting any feature from the original set that was marked as calculating a mean or standard deviation, containing a text pattern "mean()" or "std()". The names were also cleaned to remove any instance of "-" or "()" in order to streamline aggregation in the summarise_each function later deployed. 

## List of parsed mean and standard deviation features
"tBodyAccmeanX",
"tBodyAccmeanY",
"tBodyAccmeanZ",
"tBodyAccstdX",
"tBodyAccstdY",
"tBodyAccstdZ",
"tGravityAccmeanX",
"tGravityAccmeanY",
"tGravityAccmeanZ",
"tGravityAccstdX",
"tGravityAccstdY",
"tGravityAccstdZ",
"tBodyAccJerkmeanX",
"tBodyAccJerkmeanY",
"tBodyAccJerkmeanZ",
"tBodyAccJerkstdX",
"tBodyAccJerkstdY",
"tBodyAccJerkstdZ",
"tBodyGyromeanX",
"tBodyGyromeanY",
"tBodyGyromeanZ",
"tBodyGyrostdX",
"tBodyGyrostdY",
"tBodyGyrostdZ",
"tBodyGyroJerkmeanX",
"tBodyGyroJerkmeanY",
"tBodyGyroJerkmeanZ",
"tBodyGyroJerkstdX",
"tBodyGyroJerkstdY",
"tBodyGyroJerkstdZ",
"tBodyAccMagmean",
"tBodyAccMagstd",
"tGravityAccMagmean",
"tGravityAccMagstd",
"tBodyAccJerkMagmean",
"tBodyAccJerkMagstd",
"tBodyGyroMagmean",
"tBodyGyroMagstd",
"tBodyGyroJerkMagmean",
"tBodyGyroJerkMagstd",
"fBodyAccmeanX",
"fBodyAccmeanY",
"fBodyAccmeanZ",
"fBodyAccstdX",
"fBodyAccstdY",
"fBodyAccstdZ",
"fBodyAccmeanFreqX",
"fBodyAccmeanFreqY",
"fBodyAccmeanFreqZ",
"fBodyAccJerkmeanX",
"fBodyAccJerkmeanY",
"fBodyAccJerkmeanZ",
"fBodyAccJerkstdX",
"fBodyAccJerkstdY",
"fBodyAccJerkstdZ",
"fBodyAccJerkmeanFreqX",
"fBodyAccJerkmeanFreqY",
"fBodyAccJerkmeanFreqZ",
"fBodyGyromeanX",
"fBodyGyromeanY",
"fBodyGyromeanZ",
"fBodyGyrostdX",
"fBodyGyrostdY",
"fBodyGyrostdZ",
"fBodyGyromeanFreqX",
"fBodyGyromeanFreqY",
"fBodyGyromeanFreqZ",
"fBodyAccMagmean",
"fBodyAccMagstd",
"fBodyAccMagmeanFreq",
"fBodyBodyAccJerkMagmean",
"fBodyBodyAccJerkMagstd",
"fBodyBodyAccJerkMagmeanFreq",
"fBodyBodyGyroMagmean",
"fBodyBodyGyroMagstd",
"fBodyBodyGyroMagmeanFreq",
"fBodyBodyGyroJerkMagmean",
"fBodyBodyGyroJerkMagstd",
"fBodyBodyGyroJerkMagmeanFreq"

The columns represent a numerical mean aggregate of the original mean and standard deviation measurements, grouped by Subject and Activity. For example, the first derived feature, tbodyAccmeanX, represents the mean of the original set of measurements labelled tBodyAcc-mean()-X for a particular subject and activity. These mean aggregates were derived from an original data set of 10,299 entries (accounting for both the training and test subjects). 

## High Level Description of Data Transformations
While the comments in the run_analysis.R give the description on each stage of data transformation, the steps below give a high level summary:
 1. Read all relevant data from text files into data frames. 
 2. Row-bind the training and test set data to amount to 10,299 entries and 561 features. 
 3. Parse a relevant data set by selecting the columns with names indicating the measurement to be a mean or standard deviation, and clean the column names to be absent of characters like "()" and "-": now it's 10,299 entries and 79 columns worth of numeric mean and standard deviation measurements. 
 4. Perform a row-bind operation for the training and test subject data: this is 10,299 rows by 1 column.
 5. Perform a row-bind operation for the training and test activity label data: this is 10,299 rows by 1 column of subject id numbers.  
 6. Perform a SQL left join between the list from 5 and the lookup table in activity_labels.txt to derive a column of activity names (instead of indices from 1 to 6): this is 10,299 rows by 1 column of names. 
 7. Column-bind the data frames from 4, 5, and 3 (in this order) to result in a 10,299 x 81 data frame. 
 8. Calculate the mean of all mean and standard deviation measurements by subject-activity grouping, to result in a 180 x 81 data frame. 
