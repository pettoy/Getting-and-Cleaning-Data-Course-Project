#############################################################################
#                                                                           #
#           Getting and Cleaning Data Course Project                        #
#                                                                           #
#############################################################################

# One of the most exciting areas in all of data science right now is wearable computing - 
#   see for example this article . Companies like Fitbit, Nike, and Jawbone Up are 
# racing to develop the most advanced algorithms to attract new users. 
# The data linked to from the course website represent data collected from the 
# accelerometers from the Samsung Galaxy S smartphone. A full description is available 
# at the site where the data was obtained:
#    http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

# Here are the data for the project:
#     https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


# You should create one R script called run_analysis.R that does the following.
#1.	Merges the training and the test sets to create one data set.
#2.	Extracts only the measurements on the mean and standard deviation for each measurement.
#3.	Uses descriptive activity names to name the activities in the data set
#4.	Appropriately labels the data set with descriptive variable names.
#5.	From the data set in step 4, creates a second, independent tidy data set with 
#       the average of each variable for each activity and each subject.

  
#----------------
# Download files
#----------------
  
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
fileDest <- "C:/Users/Peter/DataScience/Getting-and-Cleaning-Data-Course/HumanActivityData.zip"
download.file(fileUrl, destfile = fileDest)

list.files() # in working directory

#-------------------------
# read in tabular data 
#------------------------

library(data.table)

# read measurement values

d1 <- fread("X_train.txt")
dim(d1)
d1[1:10, 1:6]

d2 <- fread("X_test.txt")
dim(d2)
d2[1:10, 1:6]


# read activities data

d1b <- fread("y_train.txt")
dim(d1b)
d1b[1:10]
table(d1b)

d2b <- fread("y_test.txt")
dim(d2b)
d2b[1:10]
table(d2b)

# read subjects data

d1c <- fread("subject_train.txt")
dim(d1c)
d1c[1:10]
table(d1c)

d2c <- fread("subject_test.txt")
dim(d2c)
d2c[1:10]
table(d2c)

# Merge the training and the test data sets to create one data set

d <- rbind(d1, d2)
dim(d)

activity <- rbind(d1b, d2b)
dim(activity)

subject <- rbind(d1c, d2c)
dim(subject)



#---------------------------
# read non-tabular data
#---------------------------

library(readr)

# Read features.txt file into R to identify individual mearsuremnts:

feat <- read_file("features.txt") # Note: the 561-feature vector is read into a single string in 'feat'. 

#-------------------------------------------------------------------------------
# The feature string 'feat' contains variables with multiple delimited symbols, 
# Wish to separate the feature values and place each one in its own row; 
# i.e. form a vector of features
#-------------------------------------------------------------------------------

library(tidyr)  

class(feat)
length(feat)

# first convert the character string to dataframe class: acceptable input to the 
#   "separate_rows" function

feat.d <- as.data.frame(feat)
dim(feat.d)
names(feat.d)

# Separate the single cell (long string) at '\n' to make several rows 
#   i.e. form a vector of features.

feat.v <- separate_rows(feat.d, feat, sep = "\n")
feat.v
dim(feat.v) # 562 x 1; last row 562 is blank
# 561 agrees with the expected number of elements in the features vector

feat.v <- feat.v[1:561, ]  

#-------------------------------------------------------------------------
# Each of the 561 features is a variable observed on a subject and belongs
#   to one of 6 activity categories.

# Extract the features measured only on the mean and rename each feature
#-------------------------------------------------------------------------

mean.var <- grep("[Mm]ean", feat.v, value = TRUE)
length(mean.var)   # There are N = 53 features measured on the mean
mean.var 

x1 <- as.data.frame(mean.var)
names(x1) <- "original"

# By default the "separate" function interpretes character as a regular 
#   expression and uses any sequence of non-alphanumeric values as the 
#   separator between columns: "space" in this case, between leading
#   serial number and feature name

mean1 <- separate(x1, 1, into = c("varId","varName0"), remove = FALSE)
mean1

codebk1 <- data.frame(varCoreName = unique(mean1$varName0) )

# Next, refine each feature name by separating into columns of core names
# and regular redundant phrases, for rows 1:46

mean2 <- separate(mean1[1:46,], original, into = c("part1","part2","part3"), 
                  sep = c("-","-"), remove = TRUE,
                  convert = FALSE, extra = "warn", fill = "warn")
mean2

# replace "NA" in patr3 column with blanks

mean2$part3 <- ifelse(is.na(mean2$part3), "", mean2$part3)


# create a new column for abbreviations of part2 values: 
#   mean() = m; meanFreq() = mf 

mean2$part4 <- ifelse(mean2$part2 == "mean()", "m", "mf")
mean2

# append abbrev (in part 4 column) to varName1 as appropriate

mean3 <- unite_(mean2, "varName1", c("varName0","part4"), sep="_")
mean3

# append X/Y/Z (in part 3 column) to varName1 as appropriate

mean4 <- unite_(mean3, "varName1", c("varName1","part3"), sep="_")
mean4

# rename the remainder of fearures that don't have regular redundant phrases

x2 <- mean1[47:53,2:1]
x2
x2$varName1 <- c("A_tBodyAccM_gravity", "A_tBodyAccJerkM_gravityM",
                 "A_tBodyGyroM_gravityM", "A_tBodyGyroJerkM_gravityM",
                 "A_X_gravityM", "A_Y_gravityM","A_Z_gravityM")
x3 <- x2[, c(1,3)]
x3

# combine all feature names

mean5 <- bind_rows(mean4[,c(4,3)], x3)
mean5



#-----------------------------------------------------------------------------
# Perform similar steps done for features measured on the mean: 
# extract the features measured on the standard deviation and rename features
#-----------------------------------------------------------------------------


std.var <- grep("[Ss]td", feat.v, value = TRUE)
length(std.var)   # There are N = 33 features measured on standard deviation
std.var


x1 <- as.data.frame(std.var)
names(x1) <- "original"
std1 <- separate(x1, 1, into = c("varId","varName0"), remove = FALSE)
std1


std2 <- separate(std1, original, into = c("part1","part2","part3"), 
                  sep = c("-","-"), remove = TRUE,
                  convert = FALSE, extra = "warn", fill = "warn")
std2

std2$part3 <- ifelse(is.na(std2$part3), "", std2$part3)




std2$part4 <- rep("s", nrow(std2)) 
std2

std3 <- unite_(std2, "varName1", c("varName0","part4"), sep="_")
std3

std4 <- unite_(std3, "varName1", c("varName1","part3"), sep="_")
std4

std5 <- std4[,c(4,3)]
std5


# combine features names (mean and std); sort by varId

features <- as_tibble(rbind(mean5,std5))   
dim(features)  # there are 86 features meansured on mean and std

features$varId <- as.integer(features$varId)
features <- arrange(features, varId)
# features
tail(features)


# Use the varId to extract the corresponding 86 feature variables (columns of 
#   values) from dataset d

dim(d)
dd <- as.tbl(d)
# head(dd[1:10,1:5])

id <- as.integer(features$varId)

dat <- select(dd, num_range("V", id))
dim(dat)
# head(dat[1:3,1:10])


# Appropriately label the data set with descriptive variable names
#   names(dat)
#   features$varId


names(dat) <- features$varName1

# add variables 'subject' and 'activity' to feature variables

dat1 <- cbind(subject,activity,dat)
names(dat1)[1:2] <- c("subject","activity")
dim(dat1)
dat1[20:50, 1:5]

# Rename activities in the "activity" variable with descriptive activity names
#   as follows:
# 1 WALKING
# 2 WALKING_UPSTAIRS
# 3 WALKING_DOWNSTAIRS
# 4 SITTING
# 5 STANDING
# 6 LAYING
dat1$activity <- ifelse(dat1$activity==1,"WALKING",
                        ifelse(dat1$activity==2,"WALKING_UPSTAIRS",
                               ifelse(dat1$activity==3,"WALKING_DOWNSTAIRS",
                                      ifelse(dat1$activity==4,"SITTING",
                                             ifelse(dat1$activity==5,"STANDING", "LAYING")))))

head(dat1[, 1:10])
tail(dat1[, 1:10])


# From the 1st data set dat1, create a second, independent tidy data set with 
#       the average of each variable for each activity and each subject.

dat2 <- dat1 %>%  group_by(subject, activity) %>%   summarise_all(mean)


# save tidy data sets

write.table(dat2, file = "C:/Users/Peter/DataScience/Getting-and-Cleaning-Data-Course/HumanActivity_TidyData.txt", 
          row.names = FALSE)









