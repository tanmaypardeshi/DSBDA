# Load Libraries
library("ggplot2")
library("dplyr")
library("Metrics")
library("caret")
library("randomForest")
library("e1071")
library("caTools")
set.seed(1)
rm(list=ls())
getwd()
setwd("/home/tanmay/Downloads")
getwd()
df <- read.csv("air.csv", header=TRUE, sep=",")
head(df)


# Data cleaning
summary(df)

# Change all -200 values to NA
for(i in names(df)[c(3:20)]){
  df[i][df[i]==-200] <- NA
}

# Replace all NA values with median
for(i in names(df)[c(3:20)]){
  df[i][is.na(df[i])] = median(df[[i]], na.rm=TRUE)
}
summary(df)
head(df)

# Data transformation
air=df
head(air)

class(air$CO.GT.)
air$CO.GT. <- as.character(air$CO.GT.)
class(air$CO.GT.)

air$C6H6.GT.High=air$C6H6.GT.>100
head(air)

#Error correcting
# Box Plots to Check for Outliers
for(i in names(df)[c(3:15)]){
  boxplot(x=df[i], main=i, col="red")
}

vec1 <- boxplot.stats(df$CO.GT.)$out
df$CO.GT.[df$CO.GT.%in%vec1] <- median(df$CO.GT.)


# Data model building

# Normalize data
df[names(df)[c(3:11,13,14)]]<-scale(df[names(df)[c(3:11,13,14)]])

# Split into train and test dataset
sample = sample.split(df$T, SplitRatio = .80)
train = subset(df, sample == TRUE)
test  = subset(df, sample == FALSE)
cat("Train Dimensions: ", dim(train), "\n")
cat("Test Dimensions: ", dim(test), "\n")


# Multiple Linear Regression
T_multipleRegressor <- lm(T ~ CO.GT.+PT08.S1.CO.+NMHC.GT.+C6H6.GT.+NOx.GT.+PT08.S3.NOx.+NO2.GT.+PT08.S4.NO2.+PT08.S5.O3.+RH+AH, data=train)
# show results
summary(T_multipleRegressor)

# Test Prediction and Accuracy
pred <- predict(T_multipleRegressor, test)
cat("\nTest Dataset Scores - \n")
data.frame(R2 = R2(pred, test$T),RMSE = RMSE(pred, test$T),MAE = MAE(pred, test$T),MSE = mse(pred, test$T))

# Train Prediction and Accuracy
pred <- predict(T_multipleRegressor, train)
cat("\nTrain Dataset Scores - \n")
data.frame(R2 = R2(pred, train$T),RMSE = RMSE(pred, train$T),MAE = MAE(pred, train$T),MSE = mse(pred, train$T))

plot(T_multipleRegressor)