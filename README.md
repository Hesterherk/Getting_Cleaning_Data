# Getting_Cleaning_Data
Course Project Getting and Cleaning Data

This project reads data from a zip file: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
I start with the data already on my computer; unpacking the ZIP file is not part of the script.

The data description can be found at: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data assignment consist of different files that need to be merged to obtain tidy data for 30 individuals (subjects) who performed 6 activities and were measured on features related to the activities. 

After reading, merging, stacking and summarizing data, the final data set consists of 81 variables and 180 observations. The 81 variables are: subjectnumber, activity done by the subject and 79 mean measures. 

For the R analysis the reshape2 library is required. 
