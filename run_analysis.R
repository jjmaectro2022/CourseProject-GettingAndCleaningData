# Reading table of lables, all activities and their names 

activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt",col.names=c("activity_id","activity_name"))

#Reading the dataset's column names 

features <- read.table("./UCI HAR Dataset/features.txt")
feature_names <-  features[,2]

# Reading the test data and label the dataset's columns

test_data <- read.table("./UCI HAR Dataset/test/X_test.txt")
colnames(test_data) <- feature_names

# Reading the training data and label the dataset's columns

train_data <- read.table("./UCI HAR Dataset/train/X_train.txt")
colnames(train_data) <- feature_names

# Reading the IDs of  test subjects and label the the dataset's columns

test_subject_id <- read.table("./UCI HAR Dataset/test/subject_test.txt")
colnames(test_subject_id) <- "subject_id"

# Reading the activity ID's of the test data and label the the dataset's columns

test_activity_id <- read.table("./UCI HAR Dataset/test/y_test.txt")
colnames(test_activity_id) <- "activity_id"

# Reading the IDs of the test subjects and label the the dataset's columns

train_subject_id <- read.table("./UCI HAR Dataset/train/subject_train.txt")
colnames(train_subject_id) <- "subject_id"

# Reading the activity ID's of the training data and label the dataset's columns

train_activity_id <- read.table("./UCI HAR Dataset/train/y_train.txt")
colnames(train_activity_id) <- "activity_id"

# Combine the test subject ID's, the test activity ID's and the test data into one dataset

test_data1 <- cbind(test_subject_id , test_activity_id , test_data)

# Combine the test subject id's, the train activity id's and the train data into one dataset

train_data1 <- cbind(train_subject_id , train_activity_id , train_data)

# Combine the test data and the train data into one dataset

all_data <- rbind(train_data1,test_data1)

# Keep only columns refering to mean() or std() values

mean_col_idx <- grep("mean",names(all_data),ignore.case=TRUE)
mean_col_names <- names(all_data)[mean_col_idx]

std_col_idx <- grep("std",names(all_data),ignore.case=TRUE)
std_col_names <- names(all_data)[std_col_idx]

meanstddata <-all_data[,c("subject_id","activity_id",mean_col_names,std_col_names)]

# Merging the activities dataset with the mean/std values dataset to get one dataset with descriptive activity names

descrnames <- merge(activity_labels,meanstddata,by.x="activity_id",by.y="activity_id",all=TRUE)

# Melt the dataset with the descriptive activity names for better handling

data_melt <- data.table::melt(descrnames,id=c("activity_id","activity_name","subject_id"))

# Cast the melted dataset according to the average of each variable for each activity and each subject
mean_data <- data.table::dcast(data_melt,activity_id + activity_name + subject_id ~ variable,mean)

# Cleaning up the variable names to set appropriate label with descriptive activity names
col_names  = colnames(mean_data)

for (i in 1:length(col_names)){
    col_names[i] = gsub("\\()","",col_names[i])
    col_names[i] = gsub("-std$","StdDev",col_names[i])
    col_names[i] = gsub("-mean","Mean",col_names[i])
    col_names[i] = gsub("^(t)","time",col_names[i])
    col_names[i] = gsub("^(f)","freq",col_names[i])
    col_names[i] = gsub("([Gg]ravity)","Gravity",col_names[i])
    col_names[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",col_names[i])
    col_names[i] = gsub("[Gg]yro","Gyro",col_names[i])
    col_names[i] = gsub("AccMag","AccMagnitude",col_names[i])
    col_names[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",col_names[i])
    col_names[i] = gsub("JerkMag","JerkMagnitude",col_names[i])
    col_names[i] = gsub("GyroMag","GyroMagnitude",col_names[i])
}

colnames(mean_data) = col_names

# Uploading the file with the new tidy dataset
write.table(mean_data,"./tidy_data.txt", row.name=FALSE)