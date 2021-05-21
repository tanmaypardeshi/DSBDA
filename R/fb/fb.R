# Perform the following operations using R/Python on the Facebook Metrics Dataset
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
df <- read.csv("/home/tanmay/Downloads/fb.csv", header=TRUE, sep=";")

# print dataframe dimensions
print(dim(df))     

# print column names
print(names(df))    

# Create data subsets
subset1 <- df[c("Page.total.likes", "Type", "Category", "Post.Month", 
               "Post.Weekday" ,"Post.Hour", "Paid")]
head(subset1)
dim(subset1)

subset2 <- df[c("Page.total.likes", "Type", "Category",
                "comment", "like", "share", "Total.Interactions")]
head(subset2)
dim(subset2)

# Merging dataframe
merged <- merge(subset1, subset2, by="Category")
head(merged)
dim(merged)

# Sort dataframe
sortdf <- df[order(df$Category, df$Post.Month),]
head(sortdf)
dim(sortdf)

# Transpose of dataframe
transposedf = t(df)
head(transposedf)
dim(transposedf)

# Melt dataframe
meltdf <- melt(data=df, id=c("Type", "Category"))
head(meltdf)
dim(meltdf)

# Cast dataframe
castdf <- dcast(data=meltdf, Category~variable, sum)
head(castdf)
dim(castdf)

