library(rpart)
library(rpart.plot)
library(caret)

#Loại bỏ DATE, CITY
data1<- Main_Data[, !(names(Main_Data) %in% c("DATE", "CITY"))]

indicies1<-sample(1:nrow(data1), 0.8*nrow(data1))
training.data1<-data1[indicies1, ]
test.data1<-data1[-indicies1, ]
#table(training.data$GO_PICNIC)
decisiontree_fit1 <- rpart(GO_PICNIC ~ ., data = training.data1, method = 'class')
#Vẽ cây quyết định
rpart.plot(decisiontree_fit1)


# Tạo dự đoán trên tập dữ liệu kiểm tra
predictions1 <- predict(decisiontree_fit1, test.data1, type = 'class')

# Chuyển đổi thành factor
predictions1 <- as.factor(predictions1)
test.data1$GO_PICNIC <- as.factor(test.data1$GO_PICNIC)

# Đồng bộ các levels
levels(predictions1) <- levels(test.data1$GO_PICNIC)

# Tạo ma trận nhầm lẫn
confusion_matrix1 <- confusionMatrix(predictions1, test.data1$GO_PICNIC)
# In ra ma trận nhầm lẫn
print(confusion_matrix1)