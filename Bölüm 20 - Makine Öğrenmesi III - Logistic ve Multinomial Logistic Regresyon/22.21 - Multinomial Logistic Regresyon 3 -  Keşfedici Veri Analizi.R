
#install.packages("nnet")
library(tidyverse)
library(nnet)

modelData <- read.csv('heart.csv')
View(modelData)

modelData <- modelData[ , -which(names(modelData) == "target")]
table(modelData$cp)

modelData <- modelData[modelData$cp != 3 , ]
table(modelData$cp)

modelData <- modelData %>% mutate(
                        cp = as.factor(cp),
                        slope = as.factor(slope),
                        ca = as.factor(ca),
                        thal = as.factor(thal),
                        restecg = as.factor(restecg)
)

table(modelData$restecg)

## Train ve Test Ayrımı 

trainTestSplit <- function(data , dvName , seed){
  
          tbl <- table(data[,dvName])
          classes <- names(tbl)
          minClass <- min(tbl)
          lengthClass <- length(tbl)
          
          train <- data.frame()
          test <- data.frame()
          
          for(i in 1:lengthClass){
              
             selectedClass <- data[,dvName] == classes[i]
             set.seed(seed)
             sampleIndex <- sample(1:nrow(data[selectedClass , ]) , size = minClass*0.8)
             
             train <- rbind(train , data[selectedClass , ][sampleIndex , ])
             test <- rbind(test , data[selectedClass , ][-sampleIndex , ])
          }
          
          return(list(train , test))
  
}

train <- trainTestSplit(modelData , "cp" , 125)[[1]]
test <- trainTestSplit(modelData , "cp" , 125)[[2]]

table(train$cp)
table(test$cp)


### Keşfecidici Veri Analizi

par(mfrow= c(2,2))
plot(train$cp , train$age , main = "Age")
plot(train$cp , train$trestbps , main = "trestbps")
plot(train$cp , train$chol , main = "Chol")
plot(train$cp , train$thalach , main = "Thalach")

dev.off()
plot(train$cp , train$oldpeak , main = "Oldpeak")


table(train$cp , train$sex)
## Cinsiyet
chisq.test(table(train$cp , train$sex))

## Exang
chisq.test(table(train$cp , train$exang))

## Slope
chisq.test(table(train$cp , train$slope))
table(train$cp , train$slope)


# Ca 
chisq.test(table(train$cp , train$ca))

# Fbs
chisq.test(table(train$cp , train$fbs))

# Thal
chisq.test(table(train$cp , train$thal))


# 

