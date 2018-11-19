# Course Project Getting And Cleaning Data
## Description of files in repo

1. CodeBook.md - description of data, variables, files, prosedure of getting and cleaning dataset 
2. tidy_data.txt - finale dataset file in .txt format
3. r_analysis.r - an R script file with the code of prosedure

## A brief description of the script (of run_analysis.r)
The run_analysis.R script merges data from a number of .txt files and produces a tidy data set which may be used for further analysis.

First it reads all required .txt files and labels the datasets

Consequently the appropriate "activity_id"'s and "subject_id"'s are appended to the "test" and the "training" data, which are then combined into one single data frame

Using the "grep" function, all the columns with mean() and std() values are extracted and then a new data frame, including only the "activity_id", the "subject_id" and the mean() and std() columns, is created

Using the "merge" function, descriptive activity names are merged with the mean/std values dataset, to get one dataset with descriptive activity names

With the help of the "melt" and "dcast" functions of the "reshape2" package, the data is converted into a table containing mean values of all the included features, ordered by the activity name and the subject ID

Using regular expression, variable names are cleaned up to set appropriate label with descriptive activity names

Data is written to the "tidy_data.txt" file.
