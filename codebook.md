# Getting and Cleaning Data - peer assessment project

The run_analysis.R script performs the data preparation and then followed by the 5 steps required as described in the course project’s definition.

1. Download the dataset
- Dataset downloaded and extracted under the folder called UCI HAR Dataset

2. Assign each data to variables
- ```features``` <- ```features.txt``` : 561 rows, 2 columns
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.
- activityLabels <- activity_labels.txt : 6 rows, 2 columns
List of activities performed when the corresponding measurements were taken and its codes (labels)
- subject_test <- test/subject_test.txt : 2947 rows, 1 column
contains test data of 9/30 volunteer test subjects being observed
- x_test <- test/X_test.txt : 2947 rows, 561 columns
contains recorded features test data
- y_test <- test/y_test.txt : 2947 rows, 1 columns
contains test data of activities’code labels
- subject_train <- test/subject_train.txt : 7352 rows, 1 column
contains train data of 21/30 volunteer subjects being observed
- x_train <- test/X_train.txt : 7352 rows, 561 columns
contains recorded features train data
- y_train <- test/y_train.txt : 7352 rows, 1 columns
contains train data of activities’code labels

3. Merges the training and the test sets to create one data set
- x_data (10299 rows, 561 columns) is created by merging x_train and x_test using rbind() function
- y_data (10299 rows, 1 column) is created by merging y_train and y_test using rbind() function
- subject-data (10299 rows, 1 column) is created by merging subject_train and subject_test using rbind() function
- merged_Data (10299 rows, 563 column) is created by merging Subject, Y and X using cbind() function

4. Extracts only the measurements on the mean and standard deviation for each measurement
- mean_and_std_data (10299 rows, 81 columns) is created by subsetting merged_Data, selecting only columns: subject, code and the measurements on the mean and standard deviation (std) for each measurement

5. Uses descriptive activity names to name the activities in the data set
- Merged mean_and_std_data and activityLables by activity_code field

6. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
- new_tidy_data (180 rows, 82 columns) is created by grouping dataset by subject_id and activity_code and then summarising it by all variables
- Export new_tidy_data into new_tidy_data.txt file.
