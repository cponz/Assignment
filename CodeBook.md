Getting and Cleaning Data Assignment
------------------------------------

Data source
===========

The data has been data collected from the accelerometers from the
Samsung Galaxy S smartphone. It represents the values of 561 variables
on 6 activities done by 30 individuals.

The data is originally stored in the site
"<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>".

Downloading the data and load it into dataframes
================================================

First step is to download the data into the project and unzip the file.
The relevant files are:

activity\_labels.txt : names of the activities performed by the subjets
features.txt : names of the variables measured

The observations were divided between train and test data, which were
stored in the following files: X\_train.txt X\_test.txt

For each of these dataset there are two files giving the activities and
subjects for each observation: Y\_train subject\_train.txt Y\_test
subject\_test.txt

All of these files are read into dataframes

Rename the columns
==================

In order to make it clearer, it is better to rename the columns with
descriptive names. Therefore the variables names are replaced with the
descriptive names:

Activity\_ID for the activities id list Subject\_ID for the subjects id
list Name of each feature for the variable columns in the observation
data sets

Select wanted data
==================

Only some of the features, the ones refering to the mean and the
standard deviation are wanted for the analysis. At this point, there is
a selection over the features data set of those variables - selectVector
With the resulting vector both the train and test observations are
filtered to obtain only the data regarding the wanted features -
trainData and testData

Merge data
==========

As the analysis is to be performed over the whole set, train and test
data, it is necessary to merge them into one data set. The first step is
to merge the observations with the activities and subjects for each data
set - train, test. Then merge the resulting data set into one, which
will be the one used for the analysis - mergeData.

The Activity\_ID column does not provide the description of the
activity, the solution is to merge the dataset with the activityLabels
and keep only the activity name. Also rename this column to
"activityName" to make it more descriptive.

Once the data is clean we can proceed with the analysis
-------------------------------------------------------

Calculations
============

The objective is to calculate the average of each measure by activity
and subject. For the calculations we need the melt and dcast functions,
so we need to upload the reshape2 library.

First step is to melt the data over activityName and Subject\_ID for all
measures - meltData Second step is to dcast the melted data over
activityName and Subject\_ID for all measures using the mean function -
finalData

Clean names
===========

Some of the variable names are not very clear, e.g. they contain "-" and
"()". In this section we have tidy the names to make them more
descriptive and readible.

Print out results
=================

The results of the analysis are then printed into a txt file - tidy.txt
