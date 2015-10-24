# The 'run_analysis' function loads data from the UCI HAR Dataset
# and returns two data frames to the Global (or parent) environment, 'dat' and 'grouped_means'.
# 'dat' contains all 'mean' and 'std' variables as well as subject and activity.#
# 'grouped_means' contains the means of the dat dataset grouped by activity and subject.

# Set the working directory to the folder containing the UCI HAR Dataset folder.
setwd("~/Projects/CDS/Course3/Assignment/")

run_analysis <- function() {
    
    # Load all data and place them in a single data frame, 'dat'.
    features <- read.table("./UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)
    train_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt")
    train_x <- read.table("./UCI HAR Dataset/train/X_train.txt")
    train_y <- read.table("./UCI HAR Dataset/train/y_train.txt")
    
    test_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt")
    test_x <- read.table("./UCI HAR Dataset/test/X_test.txt")
    test_y <- read.table("./UCI HAR Dataset/test/y_test.txt")
    
    all_subjects <- rbind(train_subject, test_subject)
    all_x <- rbind(train_x, test_x)
    all_y <- rbind(train_y, test_y)
    
    # Insert proper column names for subject and x-features
    names(all_subjects) <- "subject"
    names(all_x) <- features$V2
    
    # Add descriptive identifier as factor to all_y 
    activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
    all_y <- merge(all_y, activity_labels, by="V1")
    names(all_y) <- c("activity_id", "activity")
    
    # Bind all the data together into one data frame
    dat <- cbind(all_subjects, all_y, all_x)
    
    # Keep only subject, activity and columns that contain mean or std
    # Place the final dataset ('dat') in the Global Environment
    require(dplyr)
    dat <- dat[ , !duplicated(colnames(dat))] #clean up duplicate columns
    dat <- select(dat, subject, activity, contains("mean()"), contains("std()"))
    dat <<- dat
    
    # Create a second, independent tidy data set ('grouped_means')
    # with the average of each variable for each activity and each subject.
    # Place it in the Global Environment
    grouped_means <<- dat %>% 
        group_by(activity, subject) %>% 
        summarise_each(funs(mean))
    
    write.table(grouped_means, file = "grouped_means.txt", row.names = FALSE)
}

run_analysis()

