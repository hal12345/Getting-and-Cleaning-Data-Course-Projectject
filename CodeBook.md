# Getting and Cleaning Data Course Project



## Synopsis
One of the most exciting areas in all of data science right now is wearable computing - see for example this [article](http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/)
 . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>

Here are the data for the project:

<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>


##Data
There are 3 sets of data

1. Definition set

2. Training set

3. Test set

### Defitintion set
This set has 3 files but only 2 will be used for this assignment

####1) activity_labels.txt (6 rows) contains the activity definitions

    1 WALKING
    2 WALKING_UPSTAIRS
    3 WALKING_DOWNSTAIRS
    4 SITTING
    5 STANDING
    6 LAYING

####2) features.txt (561 rows) contains the measures

    1 tBodyAcc-mean()-X
    2 tBodyAcc-mean()-Y
    3 tBodyAcc-mean()-Z
    4 tBodyAcc-std()-X
    ...
    557 angle(tBodyGyroMean,gravityMean)  
    558 angle(tBodyGyroJerkMean,gravityMean)
    559 angle(X,gravityMean)
    560 angle(Y,gravityMean)
    561 angle(Z,gravityMean)

### Training set

####1) subject_train.txt (7352 rows x 1 cols) this file contains the link between the subject and the measures

    1
    1
    1
    1
    ...

####2) X_train.txt (7352 rows x 561 cols) this file contains the measure

      2.8858451e-001 -2.0294171e-002 -1.3290514e-001 -9.9527860e-001 -9.8311061e-001 -9.1352645e-001 -9.9511208e-001 -9.8318457e-001       -9.2352702e-001 -9.3472378e-001 -5.6737807e-001 -7.4441253e-001  8.5294738e-001  6.8584458e-001  8.1426278e-001 ...
    ...

####3) Y_train.txt (7352 rows x 1 cols) this file contains the link between the activities ant the measures
    5
    5
    5
    5
    ...

### Test set
####1) subject_test.txt (2947 rows x 1 cols) this file contains the link between the subject and the measures

    2
    2
    2
    2
    ...

####2) X_test.txt (2947 rows x 561 cols) this file contains the measure

      2.5717778e-001 -2.3285230e-002 -1.4653762e-002 -9.3840400e-001 -9.2009078e-001 -6.6768331e-001 -9.5250112e-001 -9.2524867e-001 -6.7430222e-001 -8.9408755e-001 ...
    ...

####3) Y_test.txt (2947 rows x 1 cols) this file contains the link between the activities ant the measures

    5
    5
    5
    5
    ...

###Reducing the column scope
According to the study, we are now going to reduce the scope of features to only the ones that contains std and mean.
The study won't apply any changes in the naming of the feature.

The number of features shrinks to 86 (not clear here because the feature ID is kept)

    featureID           feature
         1  tBodyAcc-mean()-X
         2  tBodyAcc-mean()-Y
         3  tBodyAcc-mean()-Z
         4  tBodyAcc-std()-X
         5  tBodyAcc-std()-Y
         6  tBodyAcc-std()-Z
         ...
       556  angle(tBodyAccJerkMean),gravityMean)
       557  angle(tBodyGyroMean,gravityMean)
       558  angle(tBodyGyroJerkMean,gravityMean)
       559  angle(X,gravityMean)
       560  angle(Y,gravityMean)
       561  angle(Z,gravityMean)
       


### Merging the sets

#### Adding the activity labels to the Y files
By joing the Y data sets to the activity labels we are getting:

    activityID activity
           5 STANDING
           5 STANDING
           5 STANDING
           5 STANDING
           5 STANDING
           5 STANDING


#### Joining all the sets together
1. we can merge se training sets together by joining them row by row (7352 rows and 88 cols)
2. we can merge se test sets together by joining them row by row ((2947 rows and 88 cols)
3. newly created training set and test set can be join column wise

New tidy file (10299 rows x 89 columns)

    subjectID activityID  activity  tBodyAcc-mean()-X tBodyAcc-mean()-Y tBodyAcc-mean()-Z tBodyAcc-std()-X ...
    2                 5   STANDING  0.2571778       -0.02328523         -0.01465376        -0.9384040
    2                 5   STANDING  0.2860267       -0.01316336         -0.11908252        -0.9754147
    2                 5   STANDING  0.2754848       -0.02605042         -0.11815167        -0.9938190
    ...

#### Applying mean transformation
The best was to achieve this is to apply the Standard Deviation function on each column and grouping them by subjectID, ativitiID and activity. This reduce the number of rows from 10299 to 180.
Please notice that the column names are unchanged

New std tidy file (180 rows x 89 colums)

    subjectID activityID  activity          tBodyAcc-mean()-X tBodyAcc-mean()-Y tBodyAcc-mean()-Z tBodyAcc-std()-X ...
    1                 1   WALKING             0.046391727        0.01818668        0.04083699      0.067978133
    1                 2   WALKING_UPSTAIRS    0.049961910        0.02174789        0.03445586      0.053547966
    1                 3   WALKING_DOWNSTAIRS  0.084156488        0.02582222        0.05693323      0.093206441
    ...



