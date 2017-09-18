---
title: "CodeBook"
author: "Peter Toyinbo"
date: "September 17, 2017"
output: github_document
---



# Getting and Cleaning Data Course Project



## Raw Data Set

The Human Activity Recognition database was produced from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.

#### Source of Raw Dataset Information:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

#### Source of Raw Dataset:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 


### Study Design Used to Collect Raw Data 

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. 

Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz were captured. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. 

From each window, a vector of features was obtained by calculating variables from the time and frequency domain.


### Attribute Information:

For each record in the dataset it is provided: 

* Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration: in X, Y, and Z axes. 
    + The body acceleration signal is obtained by subtracting the gravity from the total acceleration. 
*	Triaxial Angular velocity from the gyroscope. 
*	A 561-feature vector with time and frequency domain variables. 
    + Note: All features are normalized and bounded within [-1,1].
*	Its activity labels. 
*	An identifier of the subject who carried out the experiment.


### Tidy Data Process 

The tidy data set that includes specific variables of interest was produced from the raw data sets in the following major steps:

#### Read raw data into R

1.	The training (X_train.txt file; 7352 x 561) and the test (X_test.txt file; 2947 x 561) sets were read into R and merged to create an initial 10299 x 561 data set. The columns represent the 561 feature variables in the raw data and were automatically assigned column names V1:V561.
2.	A similar step to Step 1 was carried out for the activity data: combine the training data (y_train.txt file; 7352 x 1) with the test data (y_test.txt file; 2947 x 1) to create one 6-category activity variable: a vector of activities with 10299 elements.
3.	Step 2 was repeated for the subject data: combine the training data (subject_train.txt file; 7352 x 1) with the test data (subject_test.txt file; 2947 x 1) to create a subject ID variable with 10299 rows.
4.	Read features.txt file into R as one string. Then appropriately split the string into elements in a vector to identify individual measurements by their descriptive names, this resulted in a 561-vector of names.

#### Extract only the measurements on the mean and standard deviation from the 561 feature variables in the initial data set (step 1)

5.	From the vector of 561 descriptive names of features in step 4, the names implying measurements on the mean and standard deviation were extracted. This step required the use of the R function ‘grep’ separately for “mean” and “std” key words, which resulted in a total n=86 feature names that included their serial numbers 1:561 as feature IDs. 
6.	Next, using the feature IDs in step 5 as the mapping variable/selection criteria, the corresponding feature variables from the V1:V561 variables in the raw data from step 1. This resulted in a data dimension reduction to 10299 x 86.
7.	The new data set was appropriately labeled with the descriptive variable names.
8.	Two more variables: subject ID and activity (steps 2&3) were added to yield a new 10299 x 88 data set. 
9.	Next, the descriptive activity names listed in the activity_labels.txt file were used to rename the activity categories in the data set to produce a tidy data set with dimension 10299 x 88

#### Perform summary analysis

10.	From the data set in step 9, a second, independent tidy data set with the average of each variable for each activity and each subject was created.



## Tidy Data set


### Units of Measurement: 

*	The acceleration signal from the smartphone accelerometer in each axis is measured in standard 
gravity units 'g'. 
*	The angular velocity vector measured by the gyroscope is in radians/second.
*	The angle between a pair of vectors is measured in radians


### Definition of Variables

There are 88 variables: subject, activity, plus 86 feature measurements on mean and standard deviation. 

The original names in the raw data are sufficiently self-explanatory but are long. Therefore new descriptive names were produced by abbreviating the original names and adding some keys to complete the descriptions.

#### Codes for variable names in raw and tidy data sets

*  Leading 't' = time domain
*  Leading 'f' = frequency domain
*  Leading 'A' = angle 
*  X = x-axis
*  Y = y-axis
*  Z = z-axis
*  m = mean()
*  mf = mean frequency()
*  std = standard deviation
*  s = standard deviation


#### Table of variable names in raw and tidy data sets

  |	s/n	|	Variable name: raw data	              |	Variable name: tidy data	|
  | --- | ------------------------------------- | ------------------------- |
  |	1	  |		                                    |	subject	                  |
  |	2	  |		                                    |	activity	                |
  |	3	  |	tBodyAcc-mean()-X	                    |	tBodyAcc_m_X	            |
  |	4	  |	tBodyAcc-mean()-Y	                    |	tBodyAcc_m_Y	            |
  |	5	  |	tBodyAcc-mean()-Z	                    |	tBodyAcc_m_Z	            |
  |	6	  |	tGravityAcc-mean()-X	                |	tGravityAcc_m_X	          |
  |	7	  |	tGravityAcc-mean()-Y	                |	tGravityAcc_m_Y	          |
  |	8	  |	tGravityAcc-mean()-Z	                |	tGravityAcc_m_Z	          |
  |	9	  |	tBodyAccJerk-mean()-X	                |	tBodyAccJerk_m_X	        |
  |	10	|	tBodyAccJerk-mean()-Y	                |	tBodyAccJerk_m_Y	        |
  |	11	|	tBodyAccJerk-mean()-Z	                |	tBodyAccJerk_m_Z	        |
  |	12	|	tBodyGyro-mean()-X	                  |	tBodyGyro_m_X	            |
  |	13	|	tBodyGyro-mean()-Y	                  |	tBodyGyro_m_Y	            |
  |	14	|	tBodyGyro-mean()-Z	                  |	tBodyGyro_m_Z	            |
  |	15	|	tBodyGyroJerk-mean()-X	              |	tBodyGyroJerk_m_X	        |
  |	16	|	tBodyGyroJerk-mean()-Y	              |	tBodyGyroJerk_m_Y	        |
  |	17	|	tBodyGyroJerk-mean()-Z	              |	tBodyGyroJerk_m_Z	        |
  |	18	|	tBodyAccMag-mean()	                  |	tBodyAccMag_m_	          |
  |	19	|	tGravityAccMag-mean()	                |	tGravityAccMag_m_	        |
  |	20	|	tBodyAccJerkMag-mean ()	              |	tBodyAccJerkMag_m_	      |
  |	21	|	tBodyGyroMag-mean()	                  |	tBodyGyroMag_m_	          |
  |	22	|	tBodyGyroJerkMag-mean()	              |	tBodyGyroJerkMag_m_	      |
  |	23	|	fBodyAcc-mean()-X	                    |	fBodyAcc_m_X	            |
  |	24	|	fBodyAcc-mean()-Y	                    |	fBodyAcc_m_Y	            |
  |	25	|	fBodyAcc-mean()-Z	                    |	fBodyAcc_m_Z	            |
  |	26	|	fBodyAcc-meanFreq()-X	                |	fBodyAcc_mf_X	            |
  |	27	|	fBodyAcc-meanFreq()-Y	                |	fBodyAcc_mf_Y	            |
  |	28	|	fBodyAcc-meanFreq()-Z	                |	fBodyAcc_mf_Z	            |
  |	29	|	fBodyAccJerk-mean()-X	                |	fBodyAccJerk_m_X	        |
  |	30	|	fBodyAccJerk-mean()-Y	                |	fBodyAccJerk_m_Y	        |
  |	31	|	fBodyAccJerk-mean()-Z	                |	fBodyAccJerk_m_Z	        |
  |	32	|	fBodyAccJerk-meanFreq()-X	            |	fBodyAccJerk_mf_X	        |
  |	33	|	fBodyAccJerk-meanFreq()-Y	            |	fBodyAccJerk_mf_Y	        |
  |	34	|	fBodyAccJerk-meanFreq()-Z	            |	fBodyAccJerk_mf_Z	        |
  |	35	|	fBodyGyro-mean()-X	                  |	fBodyGyro_m_X	            |
  |	36	|	fBodyGyro-mean()-Y	                  |	fBodyGyro_m_Y	            |
  |	37	|	fBodyGyro-mean()-Z	                  |	fBodyGyro_m_Z	            |
  |	38	|	fBodyGyro-meanFreq()-X	              |	fBodyGyro_mf_X	          |
  |	39	|	fBodyGyro-meanFreq()-Y	              |	fBodyGyro_mf_Y	          |
  |	40	|	fBodyGyro-meanFreq()-Z	              |	fBodyGyro_mf_Z	          |
  |	41	|	fBodyAccMag-mean()	                  |	fBodyAccMag_m_	          |
  |	42	|	fBodyAccMag-meanFreq()	              |	fBodyAccMag_mf_	          |
  |	43	|	fBodyBodyAccJerkMag-mean()	          |	fBodyBodyAccJerkMag_m_	  |
  |	44	|	fBodyBodyAccJerkMag-meanFreq()	      |	fBodyBodyAccJerkMag_mf_	  |
  |	45	|	fBodyBodyGyroMag-mean()	              |	fBodyBodyGyroMag_m_	      |
  |	46	|	fBodyBodyGyroMag-meanFreq()	          |	fBodyBodyGyroMag_mf_	    |
  |	47	|	fBodyBodyGyroJerkMag-mean()	          |	fBodyBodyGyroJerkMag_m_	  |
  |	48	|	fBodyBodyGyroJerkMag-meanFreq()	      |	fBodyBodyGyroJerkMag_mf_	|
  |	49	|	angle(tBodyAccMean,gravity)	          |	A_tBodyAccM_gravity	      |
  |	50	|	angle(tBodyAccJerkMean),gravityMean)	|	A_tBodyAccJerkM_gravityM	|
  |	51	|	angle(tBodyGyroMean,gravityMean)	    |	A_tBodyGyroM_gravityM	    |
  |	52	|	angle(tBodyGyroJerkMean,gravityMean)	|	A_tBodyGyroJerkM_gravityM	|
  |	53	|	angle(X,gravityMean)	                |	A_X_gravityM	            |
  |	54	|	angle(Y,gravityMean)	                |	A_Y_gravityM	            |
  |	55	|	angle(Z,gravityMean)	                |	A_Z_gravityM	            |
  |	56	|	tBodyAcc-std()-X	                    |	tBodyAcc_s_X	            |
  |	57	|	tBodyAcc-std()-Y	                    |	tBodyAcc_s_Y	            |
  |	58	|	tBodyAcc-std()-Z	                    |	tBodyAcc_s_Z	            |
  |	59	|	tGravityAcc-std()-X	                  |	tGravityAcc_s_X	          |
  |	60	|	tGravityAcc-std()-Y	                  |	tGravityAcc_s_Y	          |
  |	61	|	tGravityAcc-std()-Z	                  |	tGravityAcc_s_Z	          |
  |	62	|	tBodyAccJerk-std()-X	                |	tBodyAccJerk_s_X	        |
  |	63	|	tBodyAccJerk-std()-Y	                |	tBodyAccJerk_s_Y	        |
  |	64	|	tBodyAccJerk-std()-Z	                |	tBodyAccJerk_s_Z	        |
  |	65	|	tBodyGyro-std()-X	                    |	tBodyGyro_s_X	            |
  |	66	|	tBodyGyro-std()-Y	                    |	tBodyGyro_s_Y	            |
  |	67	|	tBodyGyro-std()-Z	                    |	tBodyGyro_s_Z	            |
  |	68	|	tBodyGyroJerk-std()-X	                |	tBodyGyroJerk_s_X	        |
  |	69	|	tBodyGyroJerk-std()-Y	                |	tBodyGyroJerk_s_Y	        |
  |	70	|	tBodyGyroJerk-std()-Z	                |	tBodyGyroJerk_s_Z	        |
  |	71	|	tBodyAccMag-std()	                    |	tBodyAccMag_s_	          |
  |	72	|	tGravityAccMag-std()	                |	tGravityAccMag_s_	        |
  |	73	|	tBodyAccJerkMag-std()	                |	tBodyAccJerkMag_s_	      |
  |	74	|	tBodyGyroMag-std()	                  |	tBodyGyroMag_s_	          |
  |	75	|	tBodyGyroJerkMag-std()	              |	tBodyGyroJerkMag_s_	      |
  |	76	|	fBodyAcc-std()-X	                    |	fBodyAcc_s_X	            |
  |	77	|	fBodyAcc-std()-Y	                    |	fBodyAcc_s_Y	            |
  |	78	|	fBodyAcc-std()-Z	                    |	fBodyAcc_s_Z	            |
  |	79	|	fBodyAccJerk-std()-X	                |	fBodyAccJerk_s_X	        |
  |	80	|	fBodyAccJerk-std()-Y	                |	fBodyAccJerk_s_Y	        |
  |	81	|	fBodyAccJerk-std()-Z	                |	fBodyAccJerk_s_Z	        |
  |	82	|	fBodyGyro-std()-X	                    |	fBodyGyro_s_X	            |
  |	83	|	fBodyGyro-std()-Y	                    |	fBodyGyro_s_Y	            |
  |	84	|	fBodyGyro-std()-Z	                    |	fBodyGyro_s_Z	            |
  |	85	|	fBodyAccMag-std()	                    |	fBodyAccMag_s_	          |
  |	86	|	fBodyBodyAccJerkMag-std()	            |	fBodyBodyAccJerkMag_s_	  |
  |	87	|	fBodyBodyGyroMag-std()	              |	fBodyBodyGyroMag_s_	      |
  |	88	|	fBodyBodyGyroJerkMag-std()	          |	fBodyBodyGyroJerkMag_s_	  |
  
  
  