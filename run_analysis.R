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

##Rename columns for train set
colnames(trainData) = featuresLabels[,2]
colnames(trainSubjects) = "Subject_ID"
colnames(trainActivities) = "Activity_ID"

##Test
testData <- read.table("./UCI HAR Dataset/test/X_test.txt")
testSubjects <- read.table("./UCI HAR Dataset/test/subject_test.txt")
testActivities <- read.table("./UCI HAR Dataset/test/Y_test.txt")

##Rename columns for train set
colnames(testData) = featuresLabels[,2]
colnames(testSubjects) = "Subject_ID"
colnames(testActivities) = "Activity_ID"

##Select only the features with measurement mean and std
selectVector <- intersect(grep("mean|std",featuresLabels$V2,value=TRUE),grep("Freq",featuresLabels$V2,invert=TRUE,value = TRUE))
trainData <- trainData[,which(names(trainData) %in% selectVector)]
testData <- testData[,which(names(testData) %in% selectVector)]

##Bind all columns for Train Observations
train <- cbind(trainSubjects,trainActivities,trainData)

##Bind all columns for Test Observations
test <- cbind(testSubjects,testActivities,testData)

##Merge test and train observations
mergeData <- rbind(train,test)

##Merge with activityLabels to bring the activity description
mergeData <- merge(activityLabels,mergeData,by.x="V1",by.y="Activity_ID")

##Eliminate the Activity ID column
mergeData <- mergeData[,2:69]

##Change name of activity column to "activityName"
colnames(mergeData)[1] <- "activityName"

##Upload library reshape2
library(reshape2)

##Melt Data on all variables measured
meltData <- melt(mergeData, id = c("activityName", "Subject_ID"), measure.vars = selectVector)

##Calculate the average of each measure by activity and individual
finalData <- dcast(meltData,activityName + Subject_ID ~ variable, mean)

##Print in txt file: tidy.txt
write.table(finalData, "./tidy.txt")