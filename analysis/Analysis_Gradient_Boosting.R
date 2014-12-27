#uncomment to set path / environment variables correctly
#export PKG_CPPFALGS="-I/usr/include/mysql"
#Sys.setenv(PKG_LIBS = "-L/usr/local/mysql-5.6.20-osx10.8-x86_64/lib -lmysqlclient")
#install.packages("RMySQL", type = "source")
#Sys.setenv(PKG_CPPFLAGS = "-I/usr/local/mysql/include/")
#Sys.setenv(PKG_LIBS = "-L/usr/local/mysql/lib -lmysqlclient")
#install.packages("RMySQL", type = "source")

#load libraries
library(RMySQL)
library(caret)
#uncomment to set mysql home
Sys.setenv(MYSQL_HOME = "-H/usr/local/mysql")

#establish connection
db = dbConnect(MySQL(), user='root', password='root', dbname='stackexchange', host='127.0.0.1')

result_1 <- dbSendQuery(db, "SELECT * from questions_answers_time where time_elapsed > 0")
time_data = dbFetch(result_1, n=-1)

q <- quantile(time_data$time_elapsed, probs = seq(0,1,0.05))
quantiles <- data.frame(cbind(names(q), unname(q)))
names(quantiles) <- c("Quantile", "Hours")

dbSendQuery(db, 'drop table if exists quantiles')
dbWriteTable(db, name = 'quantiles', value = quantiles, row.names = T)


#query
result = dbSendQuery(db, "SELECT * from analysis_mart_w_answered_questions")
#store data in dataframe
data = dbFetch(result, n=-1)




#remove non-feature  columns
train <- cbind(data[,5:18],data[,20:30])


#summary

summary <- matrix(rep(0,(7*25)), ncol = 7, nrow = 25)

for (i in 1:length(train[1,])){
  if (max(train[,i])==1){
    SD <- "NA"
    positive_cases <- round(mean(train[,i]),3)
  }
  
  else{
    SD <- round(sd(train[,i]),3)
    positive_cases <- "NA"
  }
  summary[i,] <- c(quantile(train[,i]),SD, positive_cases)
  
}


summary <- data.frame(summary)
summary <- cbind(names(train), summary)
names(summary)<- c("Feature", "Q-0", "Q-25", "Q-50", "Q-75","Q-100","Std.Dev", "If Factor_Fraction Pos")



#feed results back into the database
dbSendQuery(db, 'drop table if exists summary')
dbWriteTable(db, name = "summary", value = summary, row.names = F)


###preprocessing#####
#remove no-variance columns
train$creation_year_2009 <- NULL
test$creation_year_2009 <- NULL

#impute missing age values with median
train$age <- ifelse(train$age == 0, median(train$age), train$age)
test$age <- ifelse(test$age == 0, median(train$age), test$age)

#scale continouous features
train$questions_answered_to_date <- (train$questions_answered_to_date-(mean(train$questions_answered_to_date)))/sd(train$questions_answered_to_date)
train$Reputation <- (train$Reputation - mean(train$Reputation))/sd(train$Reputation)
train$length_body <- (train$length_body - mean(train$length_body))/sd(train$length_body)


#R is weird...
train$target <- as.factor(train$target)

#set tuning parameters for Grid search heuristically
n.trees = seq(100,250,50)
interaction.depth = c(3,4,5,6)
shrinkage = c(0.1,0.05,0.025,0.01)
tune_grid = data.frame(cbind(n.trees, interaction.depth, shrinkage))                        
names(tune_grid) = c("n.trees", "interaction.depth", "shrinkage")

#feed tune grid back into db
dbSendQuery(db, 'drop table if exists tune_grid')
dbWriteTable(db, name = "tune_grid", value = tune_grid, row.names = F)


# set training parameters
train_control <- trainControl(method="cv", number=10, summaryFunction = twoClassSummary, classProbs = T)

# train the model 
model_1 <- train(target ~., data = train, tuneGrid = tune_grid, trControl=train_control,  method="gbm",  metric ="ROC")

#compute feature importances
importance <- varImp(model_1, scale=T)
importances <- importance$importance


#feed results back into the database
dbSendQuery(db, 'drop table if exists feature_importances')
dbWriteTable(db, name = "feature_importances", value = importances, row.names = T)

dbSendQuery(db, 'drop table if exists results_model_1')
dbWriteTable(db, name = 'results_model_1', value = round(model_1$results,3), row.names = F)


#second model only with important features
model_2 <- train(target ~ Reputation + questions_answered_to_date + creation_year_2010, data = train, tuneGrid = tune_grid, trControl=train_control,  method="gbm",  metric ="ROC")

#feed results back into the database
dbSendQuery(db, 'drop table if exists results_model_2')
dbWriteTable(db, name = 'results_model_2', value = round(model_2$results,3), row.names = F)





