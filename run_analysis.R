## Source: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

## set working directory and load data
setwd("C:/Users/Moo/Documents/Coursera/Data Science Specialization/3. Getting and Cleaning Data/project1")

# load libraries
library(dplyr)
library(plyr)

# Download the zip file and unzip it 
if(!file.exists("./data")){dir.create("./data")}
fileUrl1 = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl1,destfile="./data/project1.zip")
unzip("./data/project1.zip")

# Get the two .csv files
list.files()
list.files("./UCI HAR Dataset")
list.files("./UCI HAR Dataset/test")
list.files("./UCI HAR Dataset/train")

# 1. Merges the training and the test sets to create one data set.
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
Y_train <- read.table("./UCI HAR Dataset/train/Y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
Y_test <- read.table("./UCI HAR Dataset/test/Y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

# combine the test and training sets with the corresponding labels and subject
colnames(Y_test) <- "label"; colnames(Y_train) <- "label";
colnames(subject_train) <- "subject"; colnames(subject_test) <- "subject";
colnames(activity_labels) <- c("label", "activity") 

## Merges the training and the test sets to create one data set
data.values <- rbind(X_train, X_test)
data.labels <- rbind(Y_train, Y_test)
data.subjects <- rbind(subject_train, subject_test) 

## 2. Extracts only the measurements on the mean and standard deviation for each measurement
featureNames <- read.table("./UCI HAR Dataset/features.txt")[,2]

# get columns with mean() or std() in their names. Since the features were
# sorted numerically, we can use them as index to get the variables
mean.sd.features <- grep("mean|std", featureNames)
data.values.mean.sd <- data.values[,mean.sd.features]
colnames(data.values.mean.sd) <- features[mean.sd.features,2]


## 3. Uses descriptive activity names to name the activities in the data set
data.labels <- activity_labels[data.labels$label,]


## 4. Appropriately labels the data set with descriptive variable names. 
data <- cbind(data.subjects, data.labels, data.values.mean.sd)
data <- data[,-2]


## 5. From the data set in step 4, creates a second, independent tidy data set 
## with the average of each variable for each activity and each subject.

final <- ddply(data, .(subject, activity), function(x) colMeans(x[,3:81]))
final <- arrange(final, subject)

write.table(final, "tidydata.txt", row.name=F)


