==================================================================
Code book for week 4 assignment: Tidy data set based on 
data from Human Activity Recognition Using Smartphones Dataset Version 1.0
==================================================================

step 1. Building the merged data set:
=====================================
The files from the original data set which are part of the merged data set for step 1 of this assignment are:

a. xtest.csv: 2947 observations of 561 variables (The test group measurements)
b. xtrain.csv: 7352 observations of 561 variables (The train group measurements)
c. ytest.csv: 2947 activity id's for test observations 
d. ytrain.csv: 7352 activity id's for trial observations
e. features.csv 561 variable names 
f. subjecttest.csv 2947 subject id's for test observations
f. subjecttrain.csv 2947 subject id's for train observations

The merged data set is structured as follows:
- test data set: includes:
    - features (561 var names) in first row (columns 3:563)
    - subjecttest (test subject id's) in first column
    - ytest (activity id's) in second column
    - xtest (measurements) in rows 2:2948 , columns 3:563
- train data set: includes:
    - features (561 var names) in first row (columns 3:563)
    - subjecttrain (test subject id's) in first column
    - ytrain (activity id's) in second column
    - xtrain (measurements) in rows 2:7353 , columns 3:563
- merge test data set with train data set (cbind)to create a table of dim           10,299:563 

step 2. Extracting only mean and std variables:
===============================================
For this step, mean and std variables were defined as variables who's name includes either "mean" or "std".
This subset from the merged data set is of dim: 10,299:81 (79 mean or std variables)

step 3. adding activity names (labels):
=======================================
For this step, 2 additional columns were added to the data table from the previous step, as columns 1 and 2 of the new data table. 
The first column is an observation numerator column 1:10,299 
The second column included activity names for the activity in each observation.
The match between the id and the name was done using activity_labels.csv.
The names of the second and third columns were changed to "activity_name" and 
"activity id", respectively.
This step resulted in a data table dim 10,299:83

step 4. "Cleaning" variable names :
===================================
In this step, in order to make variable names clearer, all parentheses "()" in var names, were deleted.
The data table remained of dim 10,299:83
This final data table was written to .csv.
Included in this data set as "new_activity_df.csv"

step 5. Creating a second dataset :
===================================
In this step, From the data set in step 4, we create a second, independent tidy data set with the average of each variable for each activity and each subject.
The new data table is grouped by "activity_name" and then by "subject". The measurements in this set are the means of each variable, in each group.
This results in a grouped data table of dim 180:78
This final data table was written to .csv.
Included in this data set as "mean_grouped_data.csv"
    
    