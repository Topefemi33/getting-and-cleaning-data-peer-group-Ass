library(plyr)

my_dir <- "/Users/Hp/Downloads"

zip_file <- list.files(path = my_dir, pattern = "*.zip",
                       full.names = TRUE)
ldply(.data = zip_file, .fun = unzip, exdir = my_dir)

(!file.exists("UCI HAR Dataset"))
  
library(readr)
view(y_test)
x_test <- read.csv("test/x_test.txt")
View(x_test)
y_test <- read.csv("test/y_test.txt")
subject_test <- read.csv("test/subject_test.txt")
X_train <- read.csv("train/X_train.txt")
y_train <- read.csv("train/y_train.txt")
subject_train <- read.csv("train/subject_train.txt")
library(readr)
activity_labels <- read.csv("activity_labels.txt")
features <- read.csv("features.txt")

#Create Sanity and column values to the train data
colnames(x_train) = features[,2]
colnames(y_train) = "activityId"
colnames(subject_train) = "subjectId"
#Create Sanity and column values to the test data
colnames(x_test) = features[,2]
colnames(y_test) = "activityId"
colnames(subject_test) = "subjectId"
#Create sanity check for the activity labels value
colnames(activity_labels) <- 'activityId'

#merge the training and test set

??bind_rows
?rbind.fill
X <- rbind.fill(X_train, x_test)

Y <- rbind.fill(y_train, y_test)

SUBJECT <- rbind.fill(subject_train, subject_test)

Merged_data <- cbind(SUBJECT, X, Y)

##Extract only the measurements on the mean and std

colnames(Merged_data)
colNames <- colnames(Merged_data)

mean_and_std <- (grepl("activityId" , colNames) | grepl("subjectId" 
              , colNames) | grepl("mean.." , colNames) | grepl("std.." 
                  , colNames))
setForMeanAndStd <- Merged_data[ , mean_and_std == TRUE]

#Using descriptive activity names to name activity in the data set

setWithActivityNames <- merge(setForMeanAndStd, activity_labels, 
                             by='activityId', all.x=TRUE)

#Label the data set with descriptive variable names

names(setForMeanAndStd) <- "activity"

setWithActivityNames

#Independent tidy set

?aggregate.data.frame
secTidySet <- aggregate(setWithActivityNames, by("activityId", "subjectId"),mean)
secTidySet <- secTidySet[order(secTidySet$subjectId, secTidySet$activityId),]
write.table(secTidySet, "secTidySet.txt", row.name=FALSE)
  