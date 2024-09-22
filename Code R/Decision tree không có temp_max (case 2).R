library(rpart)
library(rpart.plot)
library(caret)
#Loại bỏ DATE, temp_max, CITY 
data2<- Main_Data[, !(names(Main_Data) %in% c("DATE", "temp_max", "CITY"))]

indicies2<-sample(1:nrow(data2), 0.8*nrow(data2))
training.data2<-data2[indicies2, ]
test.data2<-data2[-indicies2, ]
#table(training.data$GO_PICNIC)
decisiontree_fit2 <- rpart(GO_PICNIC ~ ., data = training.data2, method = 'class')
#Vẽ cây quyết định
rpart.plot(decisiontree_fit2)


# Tạo dự đoán trên tập dữ liệu kiểm tra
predictions2 <- predict(decisiontree_fit2, test.data2, type = 'class')

# Chuyển đổi thành factor
predictions2 <- as.factor(predictions2)
test.data2$GO_PICNIC <- as.factor(test.data2$GO_PICNIC)

# Đồng bộ các levels
levels(predictions2) <- levels(test.data2$GO_PICNIC)

# Tạo ma trận nhầm lẫn
confusion_matrix2 <- confusionMatrix(predictions2, test.data2$GO_PICNIC)
# In ra ma trận nhầm lẫn
print(confusion_matrix2)