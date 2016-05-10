# TidyData
##install.packages('reshape2')

library("reshape2")
##getwd()
##"D:/GettingAndCleaningData/Rassignment/CourseraTidyDataProject"
## Step 1 Read the data files
##D:\R\UCI HAR Dataset
## basedir <- "UCI HAR Dataset/"
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")

features <- read.table("UCI HAR Dataset/features.txt")
features <- features[2] 
## simplify, cut row numbers
features <- as.vector(features[,1]) 
## it works, but not pretty.

x_test <- read.table("UCI HAR Dataset/test/X_test.txt", colClasses = c("numeric"), col.names = features) 
## 2947 obs of 561 vars
y_test <- read.table("UCI HAR Dataset/test/y_test.txt") 
## 2947 obs of 1 var
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt") 
## 2947 obs of 1 v

## cut the required tables
x_test <- x_test[c(201, 202, 214, 215, 227, 228, 240, 241, 253, 254, 503, 504, 516, 517, 529, 530, 542, 543)]

x_test[,"activity"] <- y_test
x_test$activity <- as.factor(x_test$activity)
x_test[, "subject"] <- subject_test
x_test$subject <- as.factor(x_test$subject)


x_test$activity_labels <- x_test$activity
x_test$activity_labels <- factor(x_test$activity_labels, levels = c(1,2,3,4,5,6),
                                 labels = c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING"))

x_train <- read.table("UCI HAR Dataset/train/X_train.txt", colClasses = c("numeric"), col.names = features) ## 7352 of 561 v
y_train <- read.table("UCI HAR Dataset/train/y_train.txt") 
## 7352 of 1 v
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt") 
## 7352 of 1 v

x_train <- x_train[c(201, 202, 214, 215, 227, 228, 240, 241, 253, 254, 503, 504, 516, 517, 529, 530, 542, 543)]

x_train[,"activity"] <- y_train
x_train$activity <- as.factor(x_train$activity)
x_train[, "subject"] <- subject_train
x_train$subject <- as.factor(x_train$subject)

x_train$activity_labels <- x_train$activity
x_train$activity_labels <- factor(x_train$activity_labels, levels = c(1,2,3,4,5,6),labels = c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING"))

## Step 1-2: merge all data
all_data <- rbind(x_test, x_train)

#aggregation on the combined dataset
agg_all <- aggregate(all_data, by= list(all_data$activity_labels, all_data$subject), FUN = mean, na.rm = FALSE)

# output the file into tab delemited file
write.table(agg_all, file="tidy_HCI_data.txt", col.names=TRUE,sep = "\t")
