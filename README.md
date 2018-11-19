# Course Project of Coursera Data Scientist course: Getting and Cleaning Data 
## by Alina R. Simakova


The run_analysis.R script reads data from the "Human Activity Recognition Using Smartphones Dataset" and produces a new, tidy dataset which can be used for further analysis.

The data in the "Human Activity Recognition Using Smartphones Dataset" were collected from the accelerometers from the Samsung Galaxy S smartphone. They have been taken from experiments carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing his smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz data were captured. The experiments were video-recorded to label the data manually. The obtained dataset was randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. (references to UCI Machine Learning Repository)

#####The original dataset included the following data files:

*'features.txt': List of all features.

*'activity_labels.txt': List of class labels and their activity name.

*'train/X_train.txt': Training set.

*'train/y_train.txt': Training labels.

*'train/subject_train.txt': ID's of subjects in the training data

*'test/X_test.txt': Test set.

*'test/y_test.txt': Test labels.

*'test/subject_test.txt': ID's of subjects in the training data

#####A brief description of the script:

The run_analysis.R script merges data from a number of .txt files and produces a tidy data set which may be used for further analysis.

1) First it reads all required .txt files and labels the datasets

2) Consequently the appropriate "activity_id"'s and "subject_id"'s are appended to the "test" and the "training" data, which are then combined into one single data frame

3) Using the "grep" function, all the columns with mean() and std() values are extracted and then a new data frame, including only the "activity_id", the "subject_id" and the mean() and std() columns, is created

4) Using the "merge" function, descriptive activity names are merged with the mean/std values dataset, to get one dataset with descriptive activity names

5) With the help of the "melt" and "dcast" functions of the "reshape2" package, the data is converted into a table containing mean values of all the included features, ordered by the activity name and the subject ID

6) Using regular expression, variable names are cleaned up to set appropriate label with descriptive activity names

7) Data is written to the "tidy_data.txt" file.

A description of the "tidy_data.txt" file may be found in the "CodeBook.md" file.
