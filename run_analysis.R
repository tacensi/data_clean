# the full data set
full_dataset = rbind(read.table(file="./test/X_test.txt"), read.table(file="./train/X_train.txt"))

# the column labels
labels <- read.table(file = './features.txt')
colnames(full_dataset) <- labels[,2]

# creating a new dataset without the columns that are not needed
clean_dataset <- cbind(full_dataset[,grep("mean()", colnames(full_dataset))],full_dataset[, grep('std()', colnames(full_dataset))])

#activities
activities <- rbind(read.table(file = './test/y_test.txt'),read.table(file='./train/y_train.txt'))

#subjects
subs <- rbind(read.table(file = './test/subject_test.txt'), read.table(file='./train/subject_train.txt'))

# joining the subjects and activities to the clean dataset naming first cols
clean_dataset <- cbind(subs,activities,clean_dataset)
colnames(clean_dataset)[1:2] <- c("Subjects", "Activities")

# putting the activities labels on the dataset
activity_labels <- read.table('activity_labels')
clean_dataset$Activities <- activity_labels[clean_dataset2$Activities,2]

# Creating the averages dataset
avgs <- ddply(clean_dataset, c("Subjects", "Activities"), numcolwise(mean, na.rm=TRUE))

write.table(avgs, '/averages.txt', row.names = FALSE)
