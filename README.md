# README


## Introduction
One of the most exciting areas in all of data science right now is wearable computing - see for example this [article](http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/)
 . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>

Here are the data for the project:

<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

##How to reproduce the study
This project contains 5 files


1) run_analysis.R

    Donwload this file in your R workind directory. 
    Run it from there and it will download all files from internet.
    
    Beware: it will create several file on you R working directory. 
      1) data directory (used to store dowloaded data)
      2) tidy_data_set.txt (first file of the study)
      3) std_tidy_data_set.txt (second file of the study)

2) Codebook.md

    It explains the rules and the choices that were made in order to achieve this study

3) README.md
    This file

4) tidy_data_set.txt 
    first file of the study

5) std_tidy_data_set.txt 
    second file of the study.
    same structure as tidy_data_set.txt but values aggregated by subjectID, activityID, activity

