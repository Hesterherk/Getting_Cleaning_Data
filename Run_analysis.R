

## the data of the UCI HAR dataset should be in a directory on your computer (some foiles are in this directory; other files
# such as the train and test fu=iles are in subdirectories as indicated in this R script.

## the original data are downloaded from: 
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# download library(reshape2) to reshape data set e.g., melt and cast (to stack data and perform functions on the data).

library(reshape2)

# Load activity labels + features
activityLabels <- read.table("~/activity_labels.txt")
activityLabels[,2] <- as.character(activityLabels[,2])
features <- read.table("~/features.txt")
features[,2] <- as.character(features[,2])

# Extract only the data on mean and standard deviation (features chosen)
Chosen_features <- grep(".*mean.*|.*std.*", features[,2])
Chosen_features_names <- features[Chosen_features,2]

# Give better labels than the ones provided in the data set
Chosen_features_names = gsub('-mean', 'Mean', Chosen_features_names)
Chosen_features_names = gsub('-std', 'Std', Chosen_features_names)
Chosen_features_names <- gsub('[-()]', '', Chosen_features_names)


# Load the datasets for training
train <- read.table("~/train/X_train.txt")[Chosen_features]
trainAct <- read.table("~/train/Y_train.txt")
trainSub <- read.table("~/train/subject_train.txt")

## combine columnwise data Subjects(30 subjects), Activities(6 activities), train dataset
train <- cbind(trainSub, trainAct, train)
#str(train)

# Load the datasets for testing
test <- read.table("~/test/X_test.txt")[Chosen_features]
testAct <- read.table("~/test/Y_test.txt")
testSub <- read.table("~/test/subject_test.txt")
# and combine them 
test <- cbind(testSub, testAct, test)

# merge datasets and add labels
Total <- rbind(train, test)
colnames(Total) <- c("subject", "activity", Chosen_features_names)

# turn activities & subjects into factors
Total$activity <- factor(Total$activity, levels = activityLabels[,1], labels = activityLabels[,2])
Total$subject <- as.factor(Total$subject)

# melt: the melt function is on "The melt function takes data in wide format and stacks all 
#  columns containing measures into a single column of data. To make use of the function we need to 
# specify a data frame, the id variables (which will be left at their settings) and 
# the measured variables (columns of data) to be stacked. The id variables identify the variabels that are not
# stacked.

Total_melt <- melt(Total, id = c("subject", "activity"))

# dcast creates a dataset in which all observations of the respective variables are summarized. 
# In this case the mean is calculated across each activity a subject has measures of. 

Total_mean <- dcast(Total_melt, subject + activity ~ variable, mean)

# writing the result of allData.mean to a .txt file.

write.table(Total_mean, "~/Move_mean.txt", row.names = FALSE, quote = FALSE)


