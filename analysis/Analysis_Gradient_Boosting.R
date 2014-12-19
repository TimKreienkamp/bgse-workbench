
library(RMySQL)

export PKG_CPPFALGS="-I/usr/include/mysql"

Sys.setenv(PKG_LIBS = "-L/usr/local/mysql-5.6.20-osx10.8-x86_64/lib -lmysqlclient")

install.packages("RMySQL", type = "source")


Sys.setenv(PKG_CPPFLAGS = "-I/usr/local/mysql/include/")
Sys.setenv(PKG_LIBS = "-L/usr/local/mysql/lib -lmysqlclient")
install.packages("RMySQL", type = "source")




library(RMySQL)
Sys.setenv(MYSQL_HOME = "-H/usr/local/mysql")

db = dbConnect(MySQL(), user='root', password='root', dbname='stackexchange', host='127.0.0.1')


result = dbSendQuery(db, "SELECT * from analysis_mart")


data = fetch(result, n=-1)

input_data = cbind(data[,4:17],data[,19:28])


library(caret)


input_data$target <- as.factor(input_data$target)


n.trees = seq(100,250,50)
interaction.depth = c(3,4,5,6)
shrinkage = c(0.1,0.05,0.025,0.01)

tune_grid = data.frame(cbind(n.trees, interaction.depth, shrinkage))
names(tune_grid) = c("n.trees", "interaction.depth", "shrinkage")


      
# set train parameters
train_control <- trainControl(method="cv", number=5, summaryFunction = twoClassSummary, classProbs = T)
# train the model 
model <- train(target ~. , tuneGrid = tune_grid, data = input_data, trControl=train_control,  method="gbm",  metric ="ROC")


importance <- varImp(model, scale=FALSE)
plot(importance)

str(input_data)

