run_analysis <- function() {

  library(plyr)
  
  
  if(!file.exists("./project3")){dir.create("./project3")}
  fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileurl, destfile = "./project3/Dataset.zip")

  #unzip
  unzip(zipfile="./project3/Dataset.zip",exdir="./project3")

  
 
  # 1 - read and merge the data
  
  xtrain <- read.table("./project3/UCI HAR Dataset/train/X_train.txt")
  ytrain <- read.table("./project3/UCI HAR Dataset/train/Y_train.txt")
  
  xtest <- read.table("./project3/UCI HAR Dataset/test/X_test.txt")
  ytest <- read.table("./project3/UCI HAR Dataset/test/Y_test.txt")
  
  subjecttest <- read.table("./project3/UCI HAR Dataset/test/subject_test.txt")
  subjecttrain <- read.table("./project3/UCI HAR Dataset/train/subject_train.txt")
  
  X_data <- rbind(xtrain, xtest)
  Y_data <- rbind(ytrain, ytest)
  subject_data <- rbind(subjecttrain, subjecttest)
  
    
 # 2 - extract mean and STD
 
  features <- read.table("./project3/UCI HAR Dataset/features.txt")
 
  mean_std <- grep("-(mean|std)\\(\\)", features[,2])
  
  X_data <- X_data[, mean_std]
 
  names(X_data) <- features[mean_std, 2]

# 3 - descriptive names of activities

  activities <- read.table("./project3/UCI HAR Dataset/activity_labels.txt")

  Y_data[ ,1] <- activities[Y_data[ ,1], 2]

  names(Y_data) <- "activity"

# 4 - Label the dataset  with descriptive names
  
  names(subject_data) <- "subject"

  datanew <- cbind(X_data, Y_data, subject_data)

  names(datanew) <- gsub("Acc", "Acceleration", names(datanew))
  names(datanew) <- gsub("Gyrolerk", "Angular Acceleration", names(datanew))
  names(datanew) <- gsub("Gyro", "Angular Speed", names(datanew))
  names(datanew) <- gsub("Mag", "Magnitude", names(datanew))
  names(datanew) <- gsub("^t", "Time Domain", names(datanew))
  names(datanew) <- gsub("^f", "Frequency Domain", names(datanew))
  names(datanew) <- gsub("\\.mean", ".Mean", names(datanew))
  names(datanew) <- gsub("\\.std", ".StandardDeviation", names(datanew))
  names(datanew) <- gsub("Freq\\.", "Frequency.", names(datanew))
  names(datanew) <- gsub("Freq$", "Frequency", names(datanew))


  #print(dim(datanew))

 # 5 - create a secind independent tidy data set with avg

  finaldata <- ddply(datanew, .(subject, activity), function(x) colMeans(x[, 1:66]))
  
  write.table(finaldata, "finaldata.txt", row.name = F)
  
  View(finaldata)
}
