
# Importing libraries
#library(RCurl) # for downloading the iris CSV file
library(randomForest)
library(caret)
library(modelr)
library(rpart)
library(tidyverse)

# Importing the Iris data set

housePrice <- read.csv("C:/Users/tansiahong/Desktop/MAster Data Science/sem 3/principle of DS/group project/house_price_project/Properties_preprocessed.csv",sep = ",")


fit <- rpart(Price ~ Rooms.Num  + Bathrooms + Car.Parks + Size.Num,data = housePrice ) 
splitData <- resample_partition(housePrice,c(test=0.3,train=0.7))

write.csv(splitData$train, "training.csv")
write.csv(splitData$test, "testing.csv")

fit2 <- randomForest(Price ~ Rooms.Num  + Bathrooms + Car.Parks + Size.Num 
                     , data = splitData$train,na.action = na.exclude)

# Save model to RDS file
saveRDS(fit2, "model.rds")
