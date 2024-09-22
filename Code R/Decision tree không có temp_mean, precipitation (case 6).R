library(rpart)
library(rpart.plot)
library(caret)
#Loại bỏ DATE, temp_mean,temp_max, precipitation, CITY
data6<- Main_Data[, !(names(Main_Data) %in% c("DATE", "precipitation", "temp_mean", "temp_max", "CITY"))]

indicies6<-sample(1:nrow(data6), 0.8*nrow(data6))
training.data6<-data6[indicies6, ]
test.data6<-data6[-indicies6, ]
#table(training.data$GO_PICNIC)
decisiontree_fit6 <- rpart(GO_PICNIC ~ ., data = training.data6, method = 'class')
#Vẽ cây quyết định
rpart.plot(decisiontree_fit6)

# Tạo dự đoán trên tập dữ liệu kiểm tra
predictions6 <- predict(decisiontree_fit6, test.data6, type = 'class')
# Chuyển đổi thành factor
predictions6 <- as.factor(predictions6)
test.data6$GO_PICNIC <- as.factor(test.data6$GO_PICNIC)
# Đồng bộ các levels
levels(predictions6) <- levels(test.data6$GO_PICNIC)

# Tạo ma trận nhầm lẫn
confusion_matrix6 <- confusionMatrix(predictions6, test.data6$GO_PICNIC)
# In ra ma trận nhầm lẫn
print(confusion_matrix6)