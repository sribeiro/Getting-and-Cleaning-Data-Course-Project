# Getting-and-Cleaning-Data-Course-Project
The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

**Note** data.table structure from **data.table package** was used for this project along with its specific functions and syntax:
- **fread()** to load the original datasets (instead of read.table)
- **data.table::merge()** to get the associated label for each activity ID (an alternative would be converting to factor and assign the activity labels)
- summarization was done using data.table specific syntax by setting **j** = lapply(.SD, mean) and **by** = .(subject, activity). **.SD** contains the subset of data resulting from each grouping step minus the grouping columns/variables.

### Data description
The variables in the data X are sensor signals measured with waist-mounted smartphone from 30 subjects. The variable in the data Y indicates the activity type the subjects were engaging while recording.

### Code explaination
1. Load all files containing recordings, feature names and activity labels.
2. Combine trainig and test datasets into a single one
3. Use a regular experession to select all columns containing measures of averages and standard deviation
4. Replace activity IDs by its labels
5. Calculate a seperate dataset with the average of all measures grouped by subject and activity type

### New dataset
The new generated dataset contained variables calculated based on the mean and standard deviation. Each row of the dataset is an average of each activity type for all subjects.

### Instructions given to calculate the final tidy dataset

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
