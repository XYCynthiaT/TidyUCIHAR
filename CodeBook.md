## 1 Variables

- 'activity': lists 6 activity names

- 'set': indicates which dataset was partitioned into.
It can be either training set or test set.
Here, 70% of the volunteers was selected for generating the training data and 30% the test data

- 'subject': lists the subject id of 30 volunteers. 
Its range is from 1 to 30

- The rest varibles indicated features that obtained by 
calculating variables from the time and frequency domain and  are
on the mean and standard deviation. 

    - 'time' indicates the time domain signals derived in time
    - 'frequency' indicates the frequency domain signals transformed with a Fast Fourier Transform (FFT)
    - 'BodyAcc' stands for body linear acceleration 
    - 'GravityAcc' stands for gravity linear acceleration
    - 'BodyGyro' stands for angular velocity
    - 'Jerk' stands for Jerk signals
    - 'Mag' stands for the magnitude of these three-dimensional signals
    - 'XYZ' stands for 3 dimensions
    - 'mean' indicates that the variables were estimated from mean values of the signals
    - 'std' indicates that the variables were estimated from standard deviation of the signals
See './UCI HAR Dataset/features_info.txt' for more details.

Note: Variables of features are normalized and bounded within [-1,1].

## 2 Transformations

### 2.1: Merges the training and the test sets to create one data set.

- 2.1.1 Import 'features.txt' and store the list of all 561 features in an object
called 'features'

- 2.1.2 Import all files under 'train' directory, including: 
"subject_train.txt", "X_train.txt","y_train.txt" with 'read.table' function, 
label 'StringAsFactor = FALSE', and stored them in objects
called 'trainsubject', 'trainset', 'trainlabel' respectively

- 2.1.3 Merge training label ('trainlabel') and training set ('trainset') into 
a big dataset called 'train' by col,using 'cbind()'. 
Also, adding a column 'set' indicated the train set

- 2.1.4 Edit the column names of 'train' with "set", "label", "subject", 
and features names('features')

- 2.1.5 repeat 2.1.2 - 2.1.4 under the 'test' directory and get a big dataset
called 'test'

- 2.1.6 Merge 'train' and 'test' dataset into a complete dataset called 'bothset'
with 'rbind' function

### 2.2 Extracts only the measurements on the mean and standard deviation for each measurement.

- 2.2.1 Extract the column names of 'bothset' and store 'vars'. 

- 2.2.2 Get the index of variables that contains "mean" or "sd" with 'grep()' function

- 2.2.2 subset 'bothset' with the index and stores in an object 'selectddata'.

### 2.3 Uses descriptive activity names to name the activities in the data set

- 2.3.1 import 'activity_labels.txt' and stored in 'activitylabels'.

- 2.3.2 Rename the column names of 'activitylabels' as "label", "activity"

- 2.3.3 Merge 'activitylabels' and 'selectdata' into 'finaldata'

- 2.3.4 Remove the 'label' column

### 2.4 Appropriately labels the data set with descriptive variable names.

- 2.4.1 Remove '()' in variable names

- 2.4.2 Replace "t" with "time" (varibles begin with "t",stands for "time".)

- 2.4.3 Replace "f" with "frequency" (varibles begin with "f",stands for "frequency".)

### 2.5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

- 2.5.1 load 'dplyr' package

- 2.5.2 exclude 'set' column

- 2.5.3 group rows by "activity" and "subject" levels

- 2.5.4 calculate the means of all rest columns, stored in 'summarisedata'

### 2.6 export the final data set 'summarisedata' with 'write.table()'

## 3 Data

- 'summarisedata': a independent tidy data set with the average of each variable for each activity and each subject.
