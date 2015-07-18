---
title: "Getting and Cleaning Data- Project Codebook"
---
####*Hui-yu Yang*
####*July 17 2015*

### Data: 
The data come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. Some of these measurements underwent the Fast Fourier Transform to produce the frequency domain signals. The time domain signals were captured at a constant rate of 50 Hz, and they were filtered using a median filter and a third order low pass Butterworth filter with a corner frequency of 20 Hz to remove the noise. Then these signals were separated based on body or gravity acceleration signals using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

This .txt file contains the mean of each of the 79 features per subject and activity. There are 30 subjects and 6 activities in this file, and so the dimension of the dataset is 180 by 81. The two extra columns are the identifer variables (subject ID and activity).  

### List of Variables: 
#### 1. Identifier variables 
- subject: The subject identification associated with each measurement 
- activity: The type of activities performed by the subjects, including walking, walking upstairs, walking downstairs, 
            sitting, standing, and laying. 
            
#### 2. Measurement variables

Each measurement is a feature mean. The names of these features consist of three parts, namely, description, type of function, and orientation. For descriptions, there are 16 variations as listed below. 

- tBodyAcc: for time domain body accerlation 
- tGravityAcc for time domain gravity acceleration 
- tBodyAccJerk for time domain body acceleration 
- tBodyGyro for time domain gyroscope 
- tBodyGyroJerk for time domain gyroscope jerk 
- tBodyAccMag for time domain body acceleration magnitude
- tGravityAccMag for time domain body acceleration magnitude 
- tBodyAccJerkMag for time domain body jerk magnitude
- tBodyGyroMag for time domain body gyroscope magnitude
- tBodyGyroJerkMag for time domain body gyroscope jerk magnitude
- fBodyAcc for frequency domain body acceleration
- fBodyAccJerk for frequency domain body jerk
- fBodyGyro for frequency domain gyroscope
- fBodyAccMag for frequency domain acceleration magnitude
- fBodyAccJerkMag for frequency domain jerk magnitude
- fBodyGyroMag for for frequency domain gyroscope magnitude
- fBodyGyroJerkMag for frequency domain gyroscope jerk magnitude

For type of functions, it's either the mean or the standard deviation of the feature. 
For the orientation, it's either X, Y, or Z. As an example, the variable "tBodyAcc-mean()-X" is the time domain body acceleration mean in the X direction. 

### Data processing
1. Merges the training and the test sets to create one data set. There are 2 datasets, one with the measurement values and another with the activity labels. The training and test sets were combined using *rbind()* for these two sets of datasets separately. 

2. Extracts only the measurements on the mean and standard deviation for each measurement. The list of features contain the word "mean" or "sd" were extracted from features.txt with *grep()*. Then the list of feature values associated with those features were stored in a new dataset. 

3. Uses descriptive activity names to name the activities in the data set. With the activity_labels.txt file, the activity labels were replaced by the actual activiy names. 

4. Appropriately labels the data set with descriptive variable names. The column names of the features were replaced by their own names from features.txt. The overall data was combined here with *cbind()*.   

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. With *ddply()*, the column averages were calculated for these 79 features per subject and activity. 

