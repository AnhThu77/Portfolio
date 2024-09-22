# Cài đặt và nạp các gói cần thiết
install.packages("readxl")
install.packages("dplyr")
install.packages("tidyr")
install.packages("writexl")
library(writexl)
library(readxl)
library(dplyr)
library(tidyr)
# Đọc dữ liệu từ file CSV
data2 <- read.csv("/Users/nguyenkimngan/Documents/poject/weather_prediction_bbq_labels.csv", header = T)
data1 <- read.csv("/Users/nguyenkimngan/Documents/poject/weather_prediction_dataset.csv", header = T)
# Loại bỏ các cột có chứa tên thành phố
cleaned_data <- data1 %>%
  select(
    -starts_with("Malmo"),
    -starts_with("Montelimar"),
    -starts_with("Perpignan"),
    -starts_with("Roma"),
    -starts_with("Stockholm"),
    -starts_with("Tours")
  )
# Get the column names excluding 'DATE' and 'MONTH'
column_names <- colnames(cleaned_data)[-c(1, 2)]
# Extract city names and variable names
split_names <- strsplit(column_names, "_")
cities <- sapply(split_names, function(x) x[1])
variables <- sapply(split_names, function(x) paste(x[-1], collapse = "_"))
# Find unique cities
unique_cities <- unique(cities)
# Initialize a list to store the variables for each city
variables_by_city <- lapply(unique_cities, function(city) {
  unique(variables[cities == city])
})
# Find the intersection of variables across all cities
common_variables <- Reduce(intersect, variables_by_city)
# Print the common variables
#print(common_variables)
# Lấy tên cột hiện tại
new_colnames <- colnames(cleaned_data)
# Xóa tên thành phố khỏi tên cột, chỉ giữ lại tên biến
new_colnames <- gsub("^[A-Za-z]+_", "", new_colnames)
# Cập nhật lại tên cột trong cleaned_data
colnames(cleaned_data) <- new_colnames
# Khởi tạo danh sách để lưu các cột đã gộp
stacked_columns_list <- list()
# Gộp các cột có cùng tên và lưu vào danh sách
for (col in common_variables) {
  # Tìm các cột có cùng tên cần gộp (ví dụ "A" và "A2")
  matching_columns <- cleaned_data[, grep(col, names(cleaned_data))]
  # Xếp chồng dữ liệu của các cột
  stacked_column <- unlist(matching_columns)
  # Chuyển vector thành dataframe với tên cột đúng
  stacked_column_df <- data.frame(stacked_column)
  colnames(stacked_column_df) <- col
  # Thêm cột đã gộp vào danh sách
  stacked_columns_list[[col]] <- stacked_column_df
}
# Kết hợp các cột đã gộp vào dataframe mới
df_new <- do.call(cbind, stacked_columns_list)
# Hiển thị dataframe mới
#print(df_new)
# Nhân dữ liệu của cột date lên gấp 12 lần
data1_date <- data.frame(DATE = data1$DATE)
data1_date <- data.frame(DATE = rep(data1_date$DATE, 12))
# Nhân dữ liệu của cột city2 lên gấp 12 lan
data1_month <- data.frame(MONTH = data1$MONTH)
data1_month <- data.frame(MONTH = rep(data1_month$MONTH, 12))
# Tạo cột mới "sesion" dựa trên giá trị của cột city2
data_session <- data.frame(SEASION = data1$session)
data_session <- data.frame( SEASION = ifelse(data1_month$MONTH < 5 & data1_month$MONTH > 1 , "Spring", 
                                             ifelse(data1_month$MONTH < 8 & data1_month$MONTH > 4, "Summer",
                                                    ifelse(data1_month$MONTH < 11 & data1_month$MONTH >7, "Autumn", "Winter"))))
# Loại bỏ các cột có chứa tên thành phố
cleaned_data2 <- data2 %>%
  select(
    -starts_with("Malmo"),
    -starts_with("Montelimar"),
    -starts_with("Perpignan"),
    -starts_with("Roma"),
    -starts_with("Stockholm"),
    -starts_with("Tours")
  )

# Lấy tên cột hiện tại
new_colnames2 <- colnames(cleaned_data2)
# Xóa tên thành phố khỏi tên cột, chỉ giữ lại tên biến
new_colnames2 <- gsub("^[A-Za-z]+_", "", new_colnames2)
# Cập nhật lại tên cột trong cleaned_data
colnames(cleaned_data2) <- new_colnames2
# Tên gốc của các cột cần gộp
base_name <- "BBQ_weather"
# Tìm các cột có cùng tên gốc cần gộp (ví dụ "A", "A2", "A3", "A4")
matching_columns <- cleaned_data2[, grep(base_name, names(cleaned_data2))]
# Xếp chồng dữ liệu của các cột
stacked_column <- unlist(matching_columns)
# Tạo dataframe mới với cột đã gộp
df_new2 <- data.frame(GO_PICNIC = stacked_column)
# Hiển thị dataframe mới
#print(df_new2)
Main_data <- cbind(data1_date,data1_month,data_session,df_new,df_new2)
# Lưu kết quả vào file CSV mới 
write_xlsx(Main_data, "/Users/nguyenkimngan/Documents/poject/Main Data1.xlsx")






