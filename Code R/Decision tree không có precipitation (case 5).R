library(rpart)
library(rpart.plot)
library(caret)
#Loại bỏ DATE, temp_max, precipitation, CITY
data5<- Main_Data[, !(names(Main_Data) %in% c("DATE", "temp_max", "precipitation", "CITY"))]

indicies5<-sample(1:nrow(data5), 0.8*nrow(data5))
training.data5<-data5[indicies, ]
test.data5<-data5[-indicies5, ]
#table(training.data$GO_PICNIC)
decisiontree_fit5 <- rpart(GO_PICNIC ~ ., data = training.data5, method = 'class')
#Vẽ cây quyết định
rpart.plot(decisiontree_fit5)


# Tạo dự đoán trên tập dữ liệu kiểm tra
predictions5 <- predict(decisiontree_fit5, test.data5, type = 'class')

# Chuyển đổi thành factor
predictions5 <- as.factor(predictions5)
test.data5$GO_PICNIC <- as.factor(test.data5$GO_PICNIC)

# Đồng bộ các levels
levels(predictions5) <- levels(test.data5$GO_PICNIC)

# Tạo ma trận nhầm lẫn
confusion_matrix5<- confusionMatrix(predictions5, test.data5$GO_PICNIC)
# In ra ma trận nhầm lẫn
print(confusion_matrix5)