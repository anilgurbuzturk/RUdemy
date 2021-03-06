

### NN Regression

library(neuralnet)
library(caret)
library(mice)

concrete <- read.csv("Concrete_Data.csv" , header = T , sep = ";" , dec = ",")
View(concrete)

nrow(concrete)

md.pattern(concrete)

scaleModel <- preProcess(concrete , method = c("center" , "scale"))

modelData <- predict(scaleModel , concrete)
View(modelData)

scaleModel$mean
scaleModel$std


# Tran Test Split


set.seed(165)
trainIndex <- sample(1:nrow(modelData) , 0.75*nrow(modelData))

trainSet <- modelData[ trainIndex ,]
testSet <- modelData[ -trainIndex ,]

nrow(trainSet)
nrow(testSet)

modelNN_1 <- neuralnet(strength ~ . , data  = trainSet , 
                       hidden = 4,
                       threshold = 0.04,
                       learningrate = 0.05,
                       linear.output = TRUE
                       )

modelNN_2 <- neuralnet(strength ~ . , data  = trainSet , 
                       hidden = c(3,2),
                       threshold = 0.04,
                       learningrate = 0.05,
                       linear.output = TRUE
)

plot(modelNN_1)
plot(modelNN_2)


modelNN_1
modelNN_1$net.result



