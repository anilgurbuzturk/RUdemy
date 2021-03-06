library(tidyverse)
library(rstatix)

# install.packages("mvnormtest")
library(mvnormtest)

heart %>% group_by(cp) %>% 
          summarise(ShapiroResult = mshapiro_test(cbind(chol,thalach) )$p.value )

?identify_outliers
identify_outliers(heart["chol"])
identify_outliers(heart["thalach"])
quantile(heart$thalach)

heart <- heart %>% filter( chol < 394 & thalach > 71)


heart %>% group_by(cp) %>% 
  summarise(ShapiroResult = mshapiro_test(cbind(chol,thalach) )$p.value )


### Çok Değişkenli Varyans Homojenliği Testleri 

install.packages("heplots")
library(heplots)

bartlettTests()
leveneTests()

?bartlettTests


bartlettTests(y = heart[c("chol" , "thalach")] , group = heart$cp )
leveneTests(y = heart[c("chol" , "thalach")] , group = heart$cp )

leveneTest(heart$chol , heart$cp)





