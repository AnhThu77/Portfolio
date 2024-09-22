# Load necessary library
library(ggplot2)

# Read the CSV file
data <- Main_Data

# Plot histograms for each variable

ggplot(data, aes(x = humidity, fill = GO_PICNIC)) +
  geom_histogram(binwidth = 0.05, color = "black", position = "stack") +
  ggtitle("Histogram of Humidity by Go Picnic") +
  xlab("Humidity") +
  ylab("Frequency") +
  scale_fill_manual(values = c("YES" = "blue", "NO" = "red"))


ggplot(data, aes(x = global_radiation, fill = GO_PICNIC)) +
  geom_histogram(binwidth = 0.1, color = "black", position = "stack") +
  ggtitle("Histogram of Global Radiation by Go Picnic") +
  xlab("Global Radiation") +
  ylab("Frequency")
scale_fill_manual(values = c("YES" = "blue", "NO" = "red"))


ggplot(data, aes(x = precipitation, fill = GO_PICNIC)) +
  geom_histogram(binwidth = 0.5, color = "black", position = "stack") +
  ggtitle("Histogram of Precipitation by Go Picnic") +
  xlab("Precipitation") +
  ylab("Frequency")
scale_fill_manual(values = c("YES" = "blue", "NO" = "red"))


ggplot(data, aes(x = sunshine, fill = GO_PICNIC)) +
  geom_histogram(binwidth = 0.5, color = "black", position = "stack") +
  ggtitle("Histogram of Sunshine by Go Picnic") +
  xlab("Sunshine") +
  ylab("Frequency")
scale_fill_manual(values = c("YES" = "blue", "NO" = "red"))

ggplot(data, aes(x = temp_mean, fill = GO_PICNIC)) +
  geom_histogram(binwidth = 3.5, color = "black", position = "stack") +
  ggtitle("Histogram of Mean Temperature by Go Picnic") +
  xlab("Mean Temperature") +
  ylab("Frequency")
scale_fill_manual(values = c("YES" = "blue", "NO" = "red"))

ggplot(data, aes(x = temp_max, fill = GO_PICNIC)) + 
  geom_histogram(binwidth = 3.5, color = "black", position = "stack") +
  ggtitle("Histogram of Max Temperature by Go Picnic") +
  xlab("Max Temperature") +
  ylab("Frequency")
scale_fill_manual(values = c("YES" = "blue", "NO" = "red"))
