#UCI HAR Dataset data tidying and summary

##Contents
This repo contains one R script file, *run_analysis.R*.
The script produces two data frames which are placed in the Global (or parent) Environment:
- *dat* contains a tidy version of the data.
- *grouped_means* contains a summary of the data.

##Running the script
The script *run_analysis()* is automatically run when the file is sourced.

##Script description
The script performs three tasks:
- Loading data from the UCI HAR Dataset folder
- Tidying the data
- Summarising the data

##Details
###Loading data from the UCI HAR Dataset folder
1. Data from the train and test sets are merged *(X_train.txt, y_train.txt, X_test.txt, y_test.txt)*.

###Tidying the data
1. Appropriate headers are applied to the dataset (using *features.txt*)
2. Activity labels are added from *activity_labels.txt* to be used instead of the numeric identifiers.
3. Fields not pertaining to mean and std are removed from the dataset
4. The resulting *dat* dataset is placed in the Global (or parent) Environment.

###Summarising the data
1. The data is grouped by *activity* and *subject* and the mean is produced for each field in the dataset.
2. The resulting *grouped_means* dataset is placed in the Global (or parent) Environment.
