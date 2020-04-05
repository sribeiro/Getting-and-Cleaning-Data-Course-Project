library(data.table)
library(dplyr)

# the UCI HAR Dataset folder was downloaded and unziped into R's default working directory


#reading training data using fread because it performs better than read.table from base R
X_train <- fread("./UCI HAR Dataset/train/X_train.txt")
Y_train <- fread("./UCI HAR Dataset/train/Y_train.txt")
Subjects_train <- fread("./UCI HAR Dataset/train/subject_train.txt")

#reading test data
X_test <- fread("./UCI HAR Dataset/test/X_test.txt")
Y_test <- fread("./UCI HAR Dataset/test/Y_test.txt")
Subjects_test <- fread("./UCI HAR Dataset/test/subject_test.txt")

#read list of features
features <- fread("./UCI HAR Dataset/features.txt")

#read activity labels
activity_labels <- fread("./UCI HAR Dataset/activity_labels.txt")

#Merge the training and the test sets to create one data set.
merged_x <- rbind(X_train, X_test)
merged_y <- rbind(Y_train, Y_test)
merged_subjects <- rbind(Subjects_train, Subjects_test)


# Extract only the measurements on the mean and standard deviation for each measurement.
# regular expression logic: match any number of characters followed by either -mean() or -std()
# note: the expression needs to be escaped twice, one due to R syntax to handle special characters
#       and a second time to respect regular expressions syxtax for special characters
sel_features <- features[grep(".*(-mean\\(\\)|-std\\(\\))", features[,V2])]

#select filtered columns into the final data table
final_set <- merged_x[ , sel_features[, V1], with = F]

#Appropriately labels the data set with descriptive variable names.
names(final_set) <- sel_features[ , V2]

#adding the subject and activity identification columns as per data.frame syntax ":="
final_set[ , subject := merged_subjects$V1]
final_set[ , activity := merged_y$V1]

#Use descriptive activity names to name the activities in the data set
final_set <- merge(final_set, activity_labels, by.x = "activity", by.y = "V1", all.x = TRUE)
final_set[ , activity := V2]

#removing column V2 to avoid ambiguity
final_set[, V2 := NULL]

#From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.
#Group the data table by subject and activity and apply mean() to all columns except the ones used for grouping
tidy_averages <- final_set[ , lapply(.SD, mean), by = .(subject, activity)]

#alternativly using dplyr syntax we could do something like this
# average_dt <- final_set %>% group_by(activity, subject) %>% summarize_all(mean)


write.table(tidy_averages, file = "./UCI HAR Dataset/tidydataset.txt", row.names = FALSE)
