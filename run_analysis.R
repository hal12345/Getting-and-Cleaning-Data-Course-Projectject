##Setting up the environment
rm(list = ls())
library(dplyr)
library(plyr)

##file and folder variables
dataDir<-file.path(getwd(), "data")
zipFile<-file.path(dataDir, "/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
unzipDir<-file.path(dataDir,"unzip")

mainDir<-file.path(unzipDir,"UCI HAR Dataset")
fn_activity_labels<-file.path(mainDir,"activity_labels.txt")
fn_features<-file.path(mainDir,"features.txt")

trainDir<-file.path(mainDir,"train")
fn_subject_train<-file.path(trainDir,"subject_train.txt")
fn_X_train<-file.path(trainDir,"X_train.txt")
fn_Y_train<-file.path(trainDir,"Y_train.txt")

testDir<-file.path(mainDir,"test")
fn_subject_test<-file.path(testDir,"subject_test.txt")
fn_X_test<-file.path(testDir,"X_test.txt")
fn_Y_test<-file.path(testDir,"Y_test.txt")

fn_tidy_data_set<-file.path(getwd(),"tidy_data_set.txt")
fn_std_tidy_data_set<-file.path(getwd(),"std_tidy_data_set.txt")


## download and unzip files
if (!file.exists(dataDir)){
  dir.create(dataDir)
}

if (!file.exists(unzipDir)){
  dir.create(unzipDir)
}

if (!file.exists(zipFile)){
  download.file(url=fileUrl, destfile = zipFile, method="curl")
}

unzip(zipfile=zipFile,exdir=unzipDir)


##load files into dataframes
df_activity_labels<-read.table(fn_activity_labels, header=FALSE, sep="", nrows=-1)
df_features<-read.table(fn_features, header=FALSE, sep="", nrows=-1)
colnames(df_features)<-c("featureID", "feature")

df_X_train<-read.table(fn_X_train, header=FALSE, sep="", nrows=-1)
df_Y_train<-read.table(fn_Y_train, header=FALSE, sep="", nrows=-1)
df_subject_train<-read.table(fn_subject_train, header=FALSE, sep="", nrows=-1)

df_X_test<-read.table(fn_X_test, header=FALSE, sep="", nrows=-1)
df_Y_test<-read.table(fn_Y_test, header=FALSE, sep="", nrows=-1)
df_subject_test<-read.table(fn_subject_test, header=FALSE, sep="", nrows=-1)

#dimentions to see how to join the df
dim(df_X_train)
dim(df_Y_train)
dim(df_subject_train)

dim(df_X_test)
dim(df_Y_test)
dim(df_subject_test)

#select ending Mean and Std named columns only. Could be easily extended to other Mean or Std columns by changing the regexp expression.
good_column<-df_features[grep('MEAN()|STD()',toupper(df_features$feature)),]

#get rid of useless features in data sets
df_features<-df_features[good_column$featureID,]
df_X_train<-df_X_train[,good_column$featureID]
df_X_test<-df_X_test[,good_column$featureID]

dim(df_features)

#name the colums so that we get rid of the V1, V2,... default names given by read.table and since not embeded in the file

colnames(df_X_train)<-df_features$feature
colnames(df_X_test)<-df_features$feature

#Manually naming the columns
colnames(df_activity_labels)<-c("activityID", "activity")
colnames(df_Y_train)<-"activityID"
colnames(df_Y_test)<-"activityID"
colnames(df_subject_train)<-c("subjectID")
colnames(df_subject_test)<-c("subjectID")


## join (keep the right order of the dataframes) activity labels and actifity by subjects
df_Y_train <- left_join(df_Y_train,df_activity_labels, by = c("activityID","activityID"))
df_Y_test <- left_join(df_Y_test,df_activity_labels, by = c("activityID","activityID"))

##join data frames "horizontally"
df_train <- cbind(df_subject_train, df_Y_train, df_X_train )
df_test  <- cbind(df_subject_test, df_Y_test, df_X_test)

##creating the tidy data set 
df_tidy_data_set <- rbind(df_test, df_train )

##creating the std tidy data set
df_std_tidy_data_set <-ddply(df_tidy_data_set, .(subjectID, activityID, activity), colwise(sd))

##dumping the dataframe into expected files
write.table(df_tidy_data_set, fn_tidy_data_set, row.names = FALSE, sep=" ")
write.table(df_std_tidy_data_set, fn_std_tidy_data_set, row.names = FALSE, sep=" ")
