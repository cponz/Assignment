##Download zip file

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, "./Dataset.zip",method = "curl")

##unzip files
unzip("./Dataset.zip")

##Read Data for the analysis

##Read Features and acivities lables
activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt")
featuresLabels <- read.table("./UCI HAR Dataset/features.txt")

##Read observations
##Train
trainData <- read.table("./UCI HAR Dataset/train/X_train.txt")
trainSubjects <- read.table("./UCI HAR Dataset/train/subject_train.txt")
trainActivities <- read.table("./UCI HAR Dataset/train/Y_train.txt")

##Test
testData <- read.table("./UCI HAR Dataset/test/X_test.txt")
testSubjects <- read.table("./UCI HAR Dataset/test/subject_test.txt")
testActivities <- read.table("./UCI HAR Dataset/test/Y_test.txt")

##Bind all columns for Train Observations
train <- cbind(trainSubjects,trainActivities,trainData)

##Bind all columns for Test Observations
test <- cbind(testSubjects,testActivities,testData)

##Merge test and train observations
mergeData <- rbind(train,test)

##Select only the features with mean and std meassurements

