rm(list = ls())
#prepare inventory data YGB to be read in via FATES specific script
#install.packages("readxl")

pth<- 'C:/Users/stevdher/OneDrive - UGent/Documenten/postdoc/research/Data_DRC/inventory_data_recent/MIX5-c5.xlsx'
# Prepare inventory data YGB to be read in via FATES specific script
# install.packages("readxl")

library(readxl)
library(dplyr)

data <- read_excel(pth, col_names = FALSE)

# Combine the first two rows into a single header
headers <- paste(data[1, ], data[2, ], sep = "_") # Combine with an underscore, adjust as needed

# Remove the first two rows from the data
data <- data[-c(1, 2), ]

# Assign the combined headers to the dataframe
colnames(data) <- headers

# Optionally, convert to proper data types if necessary
data <- type.convert(data, as.is = TRUE)

pth2<- 'C:/Users/stevdher/OneDrive - UGent/Documenten/postdoc/research/Data_DRC/inventory_data_recent/MIX2_C5.xlsx'
# Prepare inventory data YGB to be read in via FATES specific script
# install.packages("readxl")

data2 <- read_excel(pth2, col_names = FALSE)

# Combine the first two rows into a single header
headers <- paste(data2[1, ], data2[2, ], sep = "_") # Combine with an underscore, adjust as needed

# Remove the first two rows from the data
data2 <- data2[-c(1, 2), ]

# Assign the combined headers to the dataframe
colnames(data2) <- headers

# Optionally, convert to proper data types if necessary
data2 <- type.convert(data2, as.is = TRUE)

### increase data2$NA_T1 by max(data$NA_T1) 

max_val <- max(data$NA_T1, na.rm = TRUE)
data2$NA_T1 <- data2$NA_T1 + max_val


data1<- bind_rows(data,data2)

# Create the new dataframe based on transformations
new <- data.frame(
  status = ifelse(data1$'2020_F1' != '0', "A", "D"),
  quadrat = data1$NA_T1,
  dbh = data1$'2020_DBH0',
  gx = data1$NA_X,
  gy = data1$NA_Y
)

# Drop rows with NA in the 'status' column
new <- new[!is.na(new$status), ]

# Save the final dataframe as an .Rdata file
save(new, file = "C:/Users/stevdher/OneDrive - UGent/Documenten/postdoc/research/Data_DRC/inventory_data_recent/new_dataframe.Rdata")

# To load it back later:
# load("new_dataframe.Rdata")


