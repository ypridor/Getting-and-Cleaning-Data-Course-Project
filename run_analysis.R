# This Process reads relevant files from a human activity
# study, carried out by cellular phone sensors.
# The process builds the data set from the pieces and then does some 
# actions on the data.Infor mation about the pieces in readme.txt

# Step 1: Building the combined data set from test and trial data


# read test group measurement data
xtest <- read.table(".//UCI HAR Dataset//test//x_test.txt")
# read test group activity id data
ytest <- read.table(".//UCI HAR Dataset//test//y_test.txt")
#read test group subject id data
subjecttest <- read.table(".//UCI HAR Dataset//test//subject_test.txt")
# read variable names (feature list)
features <- read.table(".//UCI HAR Dataset//features.txt")
# change variable names of test group data to the feature list
names(xtest) <- features$V2
# change name of ytest vector
names(ytest) <- "activity"
# change name of subject id vector
names(subjecttest) <- "subject"
# merge activity id column to test data creating a temp data set
datatesttemp <- cbind(ytest, xtest)
# merge subject column to temp data set
datatest <- cbind(subjecttest, datatesttemp)
# read trial group measurement data
xtrain <- read.table(".//UCI HAR Dataset//train//x_train.txt")
# read trial group activity id data
ytrain <- read.table(".//UCI HAR Dataset//train//y_train.txt")
#read trial group subject id data
subjecttrain <- read.table(".//UCI HAR Dataset//train//subject_train.txt")
# change variable names of trial group data to the feature list
names(xtrain) <- features$V2
# change name of ytrial vector
names(ytrain) <- "activity"
# change name of subject id vector
names(subjecttrain) <- "subject"
# merge trial activity id column to trial data creating a temp data set
datatraintemp <- cbind(ytrain, xtrain)
# merge trial subject column to temp data set
datatrain <- cbind(subjecttrain, datatraintemp)
# merge test data and trial data into 1 data set
merge_data <- rbind(datatest, datatrain)

# Step 2: Extracting only columns with mean or std measurements

# creating a reference to all the columns that are either
# id columns or columns that contain mean or std measurements
mean_std_col <- grep("*mean|std|subject|activity*",names(merge_data))
# creating a subset data set which includes only 
# id columns or columns that contain mean or std measurements
mean_std_data <- merge_data[,mean_std_col]

# Step 3: Transforming activity id's to activity names

#Create a column with activity names according to the activity labels
data_with_activity_labels <- merge(activity_labels, mean_std_data, by.x="activity", by.y="activity")
# rename activity column that now contains activity id's
names(data_with_activity_labels)[[1]] <- "activity_id"
# rename new column  that now contains activity names
names(data_with_activity_labels)[[2]] <- "activity_name"
# reorder columns of data set so that subject id is the first column
data_with_activity_labels <- data_with_activity_labels[,c(3,1,2,4:82)]

# Step 4: "cleaning" variable names

# deleting parentheses where they exist in variable names
names(data_with_activity_labels) <- gsub("()","",names(data_with_activity_labels),fixed = TRUE)

# writing new data set to .csv file
write.csv(data_with_activity_labels, file = "new_activity_df.csv" )

# Step 5: creating a new data set which is grouped by activity and subject
# and contains the mean value for every variable in a sub group

# grouping the data by activity and subject
groupedData <- group_by(data_with_activity_labels, activity_name, subject)
#summarising the new data set to include mean values, but not for "non variable"
# columns. columns 1:4 contain: observation #, subject id, activity id and
# activity name - these columns are not transformed to mean
mean_grouped_data <- summarise_at(groupedData,-c(1:4), mean)
# renaming column names to specify that now they contain means
names(mean_grouped_data) <- c(names(mean_grouped_data)[1:2], paste("mean", names(mean_grouped_data)[-c(1:2)]))
# write new grouped data set to .csv
write.csv(mean_grouped_data, file = "mean_grouped_data.csv" )


