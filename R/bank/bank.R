# Perform the following operations using R/Python on the Bank Dataset
# Create data subsets
# Merge Data
# Sort Data
# Transposing Data
# Melting Data to long format
# Casting data to wide format

# load library reshape2
library(reshape2)   

# get working directory
getwd()

# importing the facebook metrics dataset without first line as header
df <- read.csv("/home/tanmay/Downloads/bank.csv", header=TRUE, sep=";")

# print dataframe dimensions
print(dim(df))     

# print column names
print(names(df))    

# print column names
print(names(df))    

# Create data subsets
subset1 <- df[c("age", "job", "marital", "education", "contact")]
head(subset1)
dim(subset1)

subset2 <- df[c("age", "job", "balance", "housing", "loan")]
head(subset2)
dim(subset2)

# Merging dataframe
merged <- merge(subset1, subset2, by="age")
head(merged)
dim(merged)

# Sort dataframe
sortdf <- df[order(df$age, df$balance),]
head(sortdf)
dim(sortdf)

# Transpose of dataframe
transposedf = t(df)
head(transposedf)
dim(transposedf)

# Melt dataframe
meltdf <- melt(data=df, id=c("age", "balance"))
head(meltdf)
dim(meltdf)

# Cast dataframe

castdf <- dcast(df, age~job, value.var="balance", fun.aggregate="sum")
head(castdf)
dim(castdf)