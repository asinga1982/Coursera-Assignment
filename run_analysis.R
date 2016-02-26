run_analysis <- function() {

## Read files 
train <- read.table("~/UCI HAR Dataset/train/X_train.txt", header = FALSE, sep = "", colClasses = "numeric")
test <- read.table("~/UCI HAR Dataset/test/X_test.txt", header = FALSE, sep = "", colClasses = "numeric")
heads <- read.table("~/UCI HAR Dataset/features.txt", header = FALSE, stringsAsFactors=FALSE)
Activity_train <- read.table("~/UCI HAR Dataset/train/y_train.txt", header = FALSE, colClasses = "character")
Activity_test <- read.table("~/UCI HAR Dataset/test/y_test.txt", header = FALSE, colClasses = "character")
##Activity_desc <- read.table("~/UCI HAR Dataset/activity_labels.txt", header = FALSE, colClasses = "character")

## Take only 2nd column of the heading data 
Heading <- as.character(heads[,2])

# Add Header for Activity
Heading[562] <- as.character("Activity")
names(Activity_test) <- "Act"
names(Activity_train) <- "Act"

##Convert activity codes into activity names
Activity_train <- as.data.frame(lapply(Activity_train, FUN = function(x) gsub("1", "WALKING", x)))
Activity_train <- as.data.frame(lapply(Activity_train, FUN = function(x) gsub("2", "WALKING_UPSTAIRS", x)))
Activity_train <- as.data.frame(lapply(Activity_train, FUN = function(x) gsub("3", "WALKING_DOWNSTAIRS", x)))
Activity_train <- as.data.frame(lapply(Activity_train, FUN = function(x) gsub("4", "SITTING", x)))
Activity_train <- as.data.frame(lapply(Activity_train, FUN = function(x) gsub("5", "STANDING", x)))
Activity_train <- as.data.frame(lapply(Activity_train, FUN = function(x) gsub("6", "LAYING", x)))

Activity_test <- as.data.frame(lapply(Activity_test, FUN = function(x) gsub("1", "WALKING", x)))
Activity_test <- as.data.frame(lapply(Activity_test, FUN = function(x) gsub("2", "WALKING_UPSTAIRS", x)))
Activity_test <- as.data.frame(lapply(Activity_test, FUN = function(x) gsub("3", "WALKING_DOWNSTAIRS", x)))
Activity_test <- as.data.frame(lapply(Activity_test, FUN = function(x) gsub("4", "SITTING", x)))
Activity_test <- as.data.frame(lapply(Activity_test, FUN = function(x) gsub("5", "STANDING", x)))
Activity_test <- as.data.frame(lapply(Activity_test, FUN = function(x) gsub("6", "LAYING", x)))

## Combine Activities with train and test data
train_act <- cbind(train, Activity_train)
test_act <- cbind(test, Activity_test)

## Remove unsed varibales to save memory
rm(test, train)

## Combine train, test and headings
Combined <- data.frame(matrix(Heading, nrow = 1))
names(Combined) <- names(train_act)
Combined <- rbind(Combined, train_act, test_act)

## Combine Data by filtering mean and std columns
Mean_Std_Data <- select(Combined, grep("\\bmean()\\b|\\bstd()\\b|Activity", Combined[1,]))

## Set the headings as names in row 1
names(Mean_Std_Data) <- Mean_Std_Data[1,]

Mean_Std_Data <- Mean_Std_Data[-1,]
## Write output 4 by supressing row names. This is the expedted output for step 4 in assignment
write.csv(Mean_Std_Data, "~/UCI HAR Dataset/DataSet1.csv", row.names = FALSE)

## Remove unsed varibales to save memory
rm(test_act, train_act, Combined)

## Read Subject Data
Subject_train <- read.table("~/UCI HAR Dataset/train/subject_train.txt", header = FALSE, colClasses = "numeric")
Subject_test <- read.table("~/UCI HAR Dataset/test/subject_test.txt", header = FALSE, colClasses = "numeric")

## Add subject data to the Data frame
Temp_sub <- rbind(Subject_train, Subject_test)
names(Temp_sub) <- "Subject"
Final_data <- cbind(Mean_Std_Data, Temp_sub)

rm(Temp_sub, Subject_train, Subject_test,Mean_Std_Data)

## convert measurements to numeric
Final_data1 <- data.frame(sapply(Final_data[,1:66], as.numeric))
Final_data <- cbind(Final_data1, Final_data[,67:68])

rm(Final_data1)

## Group by Activity and Subject and take mean on rest of the columns with summarise_each fn
Sum_Data <- Final_data %>% group_by(Activity, Subject) %>% summarise_each(funs(mean))

rm(Final_data)
##Sum_data <- summarise_each(Final_data, funs(mean))

# Write output 4 by supressing row names. This is the expedted output for step 5 in assignment
write.csv(Sum_Data, "~/UCI HAR Dataset/DataSet2.csv", row.names = FALSE)

}