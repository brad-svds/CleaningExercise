# The purpose of this project is to demonstrate your ability to collect, work with, and clean a 
# data set. The goal is to prepare tidy data that can be used for later analysis. You will be 
# graded by your peers on a series of yes/no questions related to the project. You will be required 
# to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script 
# for performing the analysis, and 3) a code book that describes the variables, the data, and any 
# transformations or work that you performed to clean up the data called CodeBook.md. You should 
# also include a README.md in the repo with your scripts. This repo explains how all of the scripts 
# work and how they are connected.  

# You should create one R script called run_analysis.R that does the following. 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of 
# each variable for each activity and each subject.

#First, set a common working directory for downloading the information and include the appropriate packages
getwd()
setwd("~/Desktop")
getwd()

install.packages("plyr")
library(plyr)

#Download the fitness tracking data locally and unzip it. Create a table "filenames" to see the
#structure of the unzipped file
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", 
                 "fitness_tracking.zip")
unzip("fitness_tracking.zip", list = FALSE, exdir = ".")
filenames <- unzip("fitness_tracking.zip", list = TRUE)

#NOTE: Using the 'filenames' data structure, I determined the file paths I would need for the exercise.

#To remove the columns calculating mean and std values, I relabeled the columns with the inforomation
#from the 'features.txt' file. This is for the Training Set.
TrainData <- read.table("./UCI HAR Dataset/train/X_train.txt")
ColTitles <- read.table("./UCI HAR Dataset/features.txt")
ColTitlesVector <- as.vector(ColTitles[ , 2])
colnames(TrainData) = ColTitlesVector

#Remove all columns that don't focus specifically on means and standard deviations.
TrainSearch <- grepl("-mean..",ColTitlesVector) & !grepl("-meanFreq..",ColTitlesVector) & 
  !grepl("mean..-",ColTitlesVector) | grepl("-std..",ColTitlesVector) & 
  !grepl("-std()..-",ColTitlesVector)
CleanedTrainData <- TrainData[, TrainSearch == TRUE]


#To remove the columns calculating mean and std values, I relabeled the columns with the inforomation
#from the 'features.txt' file. This is for the Test Set.
TestData <- read.table("./UCI HAR Dataset/test/X_test.txt")
colnames(TestData) = ColTitlesVector

#Remove all columns that don't focus specifically on means and standard deviations.
TestSearch <- grepl("-mean..",ColTitlesVector) & !grepl("-meanFreq..",ColTitlesVector) & 
  !grepl("mean..-",ColTitlesVector) | grepl("-std..",ColTitlesVector) & 
  !grepl("-std()..-",ColTitlesVector)
CleanedTestData <- TestData[, TestSearch == TRUE]

#Merge the Cleaned Training and Test sets together.
DataFrame <- rbind(CleanedTrainData, CleanedTestData)


#Now, bind the Subject and Activity Data to have a full set.

SubjectTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")
SubjectTest <- read.table("./UCI HAR Dataset/test/subject_test.txt")
SubjectBind <- rbind(SubjectTrain, SubjectTest)
colnames(SubjectBind) <- c("subjectvalue")


ActivityTest <- read.table("./UCI HAR Dataset/test/y_test.txt")
ActivityTrain <- read.table("./UCI HAR Dataset/train/y_train.txt")
ActivityFull <- rbind(ActivityTrain, ActivityTest)
ActivityTable <- read.table("./UCI HAR Dataset/activity_labels.txt")

#This join is performed to include the full description of the activity
FullActivity <- join(ActivityFull, ActivityTable)
colnames(FullActivity) <- c("rawactivity", "subjectactivity")

FinalDataTable <- cbind(SubjectBind, FullActivity, DataFrame)


#Finally, we clean the column titles to have a better descriptive representation

names(FinalDataTable) = gsub("f", "frequencydomain", names(FinalDataTable))
names(FinalDataTable) = gsub("tB", "timedomainb", names(FinalDataTable))
names(FinalDataTable) = gsub("tG", "timedomaing", names(FinalDataTable))
names(FinalDataTable) = gsub("Acc", "accelerometer", names(FinalDataTable))
names(FinalDataTable) = gsub("Gyro", "gyroscope", names(FinalDataTable))
names(FinalDataTable) = gsub("mean()", "mean", names(FinalDataTable))
names(FinalDataTable) = gsub("std()", "std", names(FinalDataTable))
names(FinalDataTable) = gsub("-", "", names(FinalDataTable))
names(FinalDataTable) = tolower(names(FinalDataTable))
write.table(FinalDataTable, file = "tidy_data_largeset.txt")

#The second tidy dataset uses ddlpy to split the dataframe are return the mean of each level.
SeparatedData = ddply(FinalDataTable, c("subjectvalue","subjectactivity"), numcolwise(mean))
write.table(SeparatedData, file = "tidy_data.txt")
