The system perform the tasks suggested in the project in five steps:

step 1: read and merge the data. The system reads X_train.txt to xtrain, Y_train.txt to ytrain, X_test.txt to xtest, Y_test.txt to ytest, subject_test.txt to subjecttest and subject.train.txt to subjecttrain. Merge xtrain and ytrain into X_data, xtest and y test into Y_data and subjecttrain and subjecttesa into subject_data with rbind function.

step 2: extract mean and std of the features.txt file with the grep function.

step 3: change the names in dataset to descriptive names. Read the file activity_labels.txt to activities and use the activity names in the activity_labels.txt file to rename Y_data.

step 4: Label the dataset with descriptive names. First merge X_data, Y_data and subject_data into datanew, after that change all names() for datanew using gsub function.

step 5: create a second independent tidy data set with avg using ddply and colMeans, creating a file called finaldata. Write finaldata as a text file with the write.table function. 
