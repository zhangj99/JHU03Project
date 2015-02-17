library(plyr)
# Loading the training and test sets
trainingSet = read.table("UCI HAR Dataset/train/X_train.txt")
testSet = read.table("UCI HAR Dataset/test/X_test.txt")
traininglabel = read.table("UCI HAR Dataset/train/y_train.txt")
testlabel = read.table("UCI HAR Dataset/test/y_test.txt")
trainSubject = read.table("UCI HAR Dataset/train/subject_train.txt")
testSubject = read.table("UCI HAR Dataset/test/subject_test.txt")

# Merges the training and the test sets to create one data set.
MergedData = rbind(cbind(trainingSet,traininglabel,trainSubject), cbind(testSet,testlabel,testSubject))

# Extracts only the measurements on the mean and standard deviation for each measurement.
MeanStd = data.frame(MergedData[,562], MergedData[,563], 
                     MergedData[,1],MergedData$V2,MergedData$V3,MergedData$V4,MergedData$V5,MergedData$V6,
                     MergedData$V41,MergedData$V42,MergedData$V43,MergedData$V44,MergedData$V45,MergedData$V46,
                     MergedData$V81,MergedData$V82,MergedData$V83,MergedData$V84,MergedData$V85,MergedData$V86,
                     MergedData$V121,MergedData$V122,MergedData$V123,MergedData$V124,MergedData$V125,MergedData$V126,
                     MergedData$V161,MergedData$V162,MergedData$V163,MergedData$V164,MergedData$V165,MergedData$V166,
                     MergedData$V201,MergedData$V202,MergedData$V214,MergedData$V215,MergedData$V227,MergedData$V228,
                     MergedData$V240,MergedData$V241,MergedData$V253,MergedData$V254,
                     MergedData$V266,MergedData$V267,MergedData$V268,MergedData$V269,MergedData$V270,MergedData$V271,
                     # MergedData$V294,MergedData$V295,MergedData$V296,
                     MergedData$V345,MergedData$V346,MergedData$V347,MergedData$V348,MergedData$V349,MergedData$V350,
                     MergedData$V424,MergedData$V425,MergedData$V426,MergedData$V427,MergedData$V428,MergedData$V429,
                     # MergedData$V452,MergedData$V453,MergedData$V454,
                     MergedData$V503,MergedData$V504,
                     MergedData$V516,MergedData$V517,
                     MergedData$V529,MergedData$V530,
                     MergedData$V542,MergedData$V543)

# Uses descriptive activity names to name the activities in the data set
activityNames = read.table("UCI HAR Dataset/activity_labels.txt")
for(i in 1:6){
    MeanStd[MeanStd$MergedData...562.== i, ]$MergedData...562. <- as.character(activityNames$V2[i])
}

# Appropriately labels the data set with descriptive variable names.
features = read.table("UCI HAR Dataset/features.txt")
names = features$V2
colnames(MeanStd) = c("ActivityLabel", "Subject", as.character(names[cbind(1,2,3,4,5,6,41,42,43,44,45,46,81,82,83,84,85,86,121,122,123,124,125,126,
                                161,162,163,164,165,166,201,202,214,215,227,228,240,241,253,254,266,267,268,269,270,271,
                                345,346,347,348,349,350,424,425,426,427,428,429,503,504,516,517,529,530,542,543)]))

# From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.
library(dplyr)
TidyData <- MeanStd %>% group_by(Subject, ActivityLabel)
Result <- TidyData %>% summarise_each(c("mean", "sd"))
write.table(Result, file="./data/Project.txt", row.names=F)
