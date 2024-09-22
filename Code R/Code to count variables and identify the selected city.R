data <- read.csv("/Users/nguyenkimngan/Documents/poject/weather_prediction_dataset.csv")
col_names <- colnames(data)
city_prefixes <- unique(sub("_.*", "", col_names))
city_prefixes <- city_prefixes[city_prefixes != "DATE" & city_prefixes != "MONTH"]
city_variables <- list()
for (city in city_prefixes) {
  city_cols <- grep(paste0("^", city, "_"), col_names, value = TRUE)
  variables <- sub(paste0("^", city, "_"), "", city_cols)
  city_variables[[city]] <- variables
}
city_variables


city_var_counts <- sapply(city_variables, length)
print(city_var_counts)


cities_under_9_vars <- names(city_variables)[city_var_counts < 9]
cities_under_9_vars