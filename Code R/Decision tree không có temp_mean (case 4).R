library(rpart)
library(rpart.plot)
library(caret)
#Loại bỏ DATE, temp_mean, CITY
data4<- Main_Data[, !(names(Main_Data) %in% c("DATE", "temp_mean", "temp_max", "CITY"))]

indicies4<-sample(1:nrow(data4), 0.8*nrow(data4))
training.data4<-data4[indicies4, ]
test.data4<-data4[-indicies4, ]
#table(training.data$GO_PICNIC)
decisiontree_fit4 <- rpart(GO_PICNIC ~ ., data = training.data4, method = 'class')
#Vẽ cây quyết định
rpart.plot(decisiontree_fit4)

# Tạo dự đoán trên tập dữ liệu kiểm tra
predictions4<- predict(decisiontree_fit4, test.data4, type = 'class')
# Chuyển đổi thành factor
predictions4 <- as.factor(predictions4)
test.data4$GO_PICNIC <- as.factor(test.data4$GO_PICNIC)
# Đồng bộ các levels
levels(predictions4) <- levels(test.data4$GO_PICNIC)

# Tạo ma trận nhầm lẫn
confusion_matrix4 <- confusionMatrix(predictions4, test.data4$GO_PICNIC)
# In ra ma trận nhầm lẫn
print(confusion_matrix4)