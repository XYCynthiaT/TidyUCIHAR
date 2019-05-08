
# 1. Merges the training and the test sets to create one data set.
## training 70% volunteers (21), data 30% volunteers (9)

## import 'features.txt': List of all features. 561 features/window
features <- read.table('features.txt', stringsAsFactors = FALSE)

## build a directory for 'train'
traindir <- paste0("./train/", list.files("./train")[2:4])
## [1-3]"subject_train.txt"  "X_train.txt"  "y_train.txt" 

## import training set, 561 features are denoted as 561 vars, 7352 obs intotal
trainset <- read.table(traindir[2], stringsAsFactors = FALSE)
## import training labels, 1-6 label groups (6 activities), 7352 obs in total
trainlabel <- read.table(traindir[3], stringsAsFactors = FALSE)
## import 'subject_test': 
# Each row identifies the subject who performed the activity for each window sample.
# 21 in train group
trainsubject <- read.table(traindir[1], stringsAsFactors = FALSE)

## Merge training label and training set by col, cbind
## 1 subject_id + 1 label + 561 features, 7352 obs
train <- cbind(trainsubject, trainlabel, trainset)

## add a column indication the train/test set
train <- cbind(rep("train", nrow(train)), train)

## add column names using features('features.txt')
names(train) <- c("set", "subject", "label", features$V2)



## build a directory for 'train'
testdir <- paste0("./test/", list.files("./test")[2:4])
## [1-3]"./test/subject_test.txt" "./test/X_test.txt"  "./test/y_test.txt" 

## import test set, 561 features are denoted as 561 vars, 2947 obs intotal
testset <- read.table(testdir[2], stringsAsFactors = FALSE)
## import test labels, 1-6 label groups(6 activities), 2947 obs in total
testlabel <- read.table(testdir[3], stringsAsFactors = FALSE)
## import 'subject_test': 
# Each row identifies the subject who performed the activity for each window sample.
# 9 in test group
testsubject <- read.table(testdir[1], stringsAsFactors = FALSE)

## Merge training label and training set by col, cbind
## 1 subject_id + 1 label + 561 features, 2947 obs
test <- cbind(testsubject, testlabel, testset)

## add a column indication the train/test set
test <- cbind(rep("test", nrow(test)), test)

## add column names using features('features.txt')
names(test) <- c("set", "subject", "label", features$V2)

## Merge train and test set
bothset <- rbind(train, test)

## add column names using features('features.txt')
names(test) <- c("subject", "label", features$V2)


# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## extract() is used to extract measurements
extract <- function(data = bothset) {
  vars <- names(bothset)
  measurement <- grep("mean|std", vars)
  bothset[, measurement]
}

# 3. Uses descriptive activity names to name the activities in the data set
## import 'activity_labels.txt': list all activity names(6).
activitylabels <- read.table("activity_labels.txt")
names(activitylabels) <- c("label", "activity")
bothset <- merge(bothset, activitylabels, by = "label", all = TRUE)
bothset <- bothset[, -1]

# 4. Appropriately labels the data set with descriptive variable names.
## remove "()' in the variable names
names(bothset) <- sub("\\(\\)", "", names(bothset))

# 5. From the data set in step 4, creates a second, independent tidy data 
# set with the average of each variable for each activity and each subject.
library(dplyr)
summarise <- bothset %>% 
  select(-1) %>%
  group_by(activity, subject) %>%
  summarise_all(mean)
# splitlist <- split(bothset, list(bothset$activity, bothset$subject))
# summariselist <- lapply(splitlist, function(x){colMeans(x[, -c(1, 2, 564)])})
# summarise <- matrix(nrow = length(summariselist), ncol = length(summariselist[[1]]))
# for (i in seq(nrow(summarise))) {
#   summarise[i,] <- summariselist[[i]]
# }

# ## build a directory for 'inertial signals'
# trainsignal <- paste0("./train/Inertial Signals/", list.files("./train/Inertial Signals"))
# ## [1-3]body_acc, [4-6]body_gyro, [7-9] total_acc
# 
# ## 128 vars, 2947 obs
# trnbodyaccx <- read.table(trainsignal[1], stringsAsFactors = FALSE)
# trnbodyaccy <- read.table(trainsignal[2], stringsAsFactors = FALSE)
# 
# ## build a directory for 'inertial signals'
# testsignal <- paste0("./test/Inertial Signals/", list.files("./test/Inertial Signals"))
# ## [1-3]body_acc, [4-6]body_gyro, [7-9] total_acc
# 
# ## 128 vars, 2947 obs
# tstbodyaccx <- read.table(testsignal[1], stringsAsFactors = FALSE)
# tstbodyaccy <- read.table(testsignal[2], stringsAsFactors = FALSE)
