library(rpart)
library(rpart.plot)
library(caret)
#Loại bỏ DATE, temp_mean, CITY 
data3<- Main_Data[, !(names(Main_Data) %in% c("DATE", "temp_mean", "CITY"))]

indicies3<-sample(1:nrow(data3), 0.8*nrow(data3))
training.data3<-data3[indicies3, ]
test.data3<-data3[-indicies3, ]
#table(training.data$GO_PICNIC)
decisiontree_fit3 <- rpart(GO_PICNIC ~ ., data = training.data3, method = 'class')
#Vẽ cây quyết định
rpart.plot(decisiontree_fit3)


# Tạo dự đoán trên tập dữ liệu kiểm tra
predictions3 <- predict(decisiontree_fit3, test.data3, type = 'class')

# Chuyển đổi thành factor
predictions3 <- as.factor(predictions3)
test.data3$GO_PICNIC <- as.factor(test.data3$GO_PICNIC)

# Đồng bộ các levels
levels(predictions3) <- levels(test.data3$GO_PICNIC)

# Tạo ma trận nhầm lẫn
confusion_matrix3 <- confusionMatrix(predictions3, test.data3$GO_PICNIC)
# In ra ma trận nhầm lẫn
print(confusion_matrix3)