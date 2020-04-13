##PREREQUISITES 

#Downloading and unzipping data

#if(!file.exists("./data")){dir.create("./data")}
#Here are the data for the project:
#fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#download.file(fileUrl,destfile="./data/HAR_Dataset.zip")

# Unzip dataSet to /data directory
#unzip(zipfile="./data/HAR_Dataset.zip",exdir="./data")

# Reading files

#Reading trainings tables:

x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

# 1.1.2 Reading testing tables:
x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

# 1.1.3 Reading feature vector:
features <- read.table('./data/UCI HAR Dataset/features.txt')

# 1.1.4 Reading activity labels:
activityLabels = read.table('./data/UCI HAR Dataset/activity_labels.txt')


##STEP - 1 : Merge the test and training data sets to create one dataset

library(dplyr)

#merge respective train and test data and name the columns appropriately
x_data <- rbind(x_train, x_test)
colnames(x_data) <- features$V2

y_data <- rbind(y_train, y_test)
colnames(y_data) <- "activity_code"

subject_data <- rbind(subject_test, subject_train)
colnames(subject_data) <- "subject_id"

colnames(activityLabels) <- c("activity_code", "activity_desc")

#merge all data to one varaible

merged_Data <- cbind(subject_data, y_data, x_data )

## STEP 2 : Extracts only the measurements on the mean and standard deviation for each measurement.

#creating a logical vector to identify variables needed
colNames <- colnames(merged_Data)

#subsetting id, mean and std data from merged data using logical vector created above
mean_and_std <- (grepl("subject_id", colNames) | grepl("activity_code", colNames) | 
                     grepl("mean..", colNames) | grepl("std..", colNames) )

mean_and_std_data <- merged_Data[, mean_and_std]

## STEP 3 : Uses descriptive activity names to name the activities in the data set

#merging data using activity code to accomplish step 3
data_with_activity_names <- merge(mean_and_std_data, activityLabels, by = "activity_code", all.x = TRUE)


## STEP 4 : Appropriately labels the data set with descriptive variable names
#Already named columns with appropriate variable names in lines 38 - 45


## STEP 5 : From the data set in step 4, creates a second, independent tidy data set with
##          the average of each variable for each activity and each subject.

new_tidy_data <- data_with_activity_names %>%
                    group_by(subject_id, activity_code) %>%
                    summarise_all(mean)
