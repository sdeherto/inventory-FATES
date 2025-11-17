rm(list = ls())

dir<- 'C:/Users/stevdher/OneDrive - UGent/Documenten/postdoc/fates-tutorial-main/fates-tutorial-main/inventory_data/'
# Step 1: Read the files (assuming CSV-like format for .css files)
# Use ED structured file as dummy
ed_file <- read.csv('C:/Users/stevdher/OneDrive - UGent/Documenten/postdoc/fates-tutorial-main/fates-tutorial-main/inventory_data/yangambi_dummy.css', header = TRUE,sep = "", stringsAsFactors = FALSE)

#this file is your own inventory file in FATES format
fat_file <- read.csv('C:/Users/stevdher/OneDrive - UGent/Documenten/postdoc/research/Data_DRC/inventory_data_recent/YGB_2plots_2020.css', header = TRUE,sep = "", stringsAsFactors = FALSE)

# Step 2: Check for row length differences
fat_rows <- nrow(fat_file)
ed_rows <- nrow(ed_file)

# If the dummy has more rows than the FATES inventory file, truncate it
if (ed_rows > fat_rows) {
  ed_file <- ed_file[1:fat_rows, ]
} 

# If the FATES inventory has more rows than the ED2 dummy, pad it with NA rows
# Make sure they have matching number of rows
if (nrow(ed_file) < nrow(fat_file)) {
  rows_to_add <- nrow(fat_file) - nrow(ed_file)
  
  # Ensure new rows are added with matching column names
  new_rows <- data.frame(matrix(0, nrow = rows_to_add, ncol = ncol(ed_file)))
  colnames(new_rows) <- colnames(ed_file)  # Ensure the column names match
  
  # Append new rows to the dummy
  ed_file <- rbind(ed_file, new_rows)
}

# Step 3: Choose which columns to overwrite in the ED2 dummy
ed_file$time <- fat_file$time
ed_file$patch <- fat_file$patch  
ed_file$dbh <- fat_file$dbh  
ed_file$hite <- fat_file$height +1  
ed_file$pft <- fat_file$pft  
ed_file$n <- fat_file$nplant  

# Step 4: Apply the logic for the pft column
ed_file$pft <- ifelse(fat_file$pft == 1, 3)
# Step 4: Save the new modified ED2 file
#write.csv(bci_file, 'C:/Users/stevdher/OneDrive - UGent/Documenten/postdoc/fates-tutorial-main/fates-tutorial-main/inventory_data/Yangambi_copy.css', row.names = FALSE,sep = " ")
write.table(ed_file, 
            file = 'C:/Users/stevdher/OneDrive - UGent/Documenten/postdoc/research/Data_DRC/inventory_data_recent/YGB_2plots_2020_ED.css', 
            row.names = FALSE, 
            col.names = TRUE, 
            sep = " ",     # Use space as the separator
            quote = FALSE) # Prevent quotation marks around values

#Repeat process for .pss file
# Step 1: Read the files (assuming CSV-like format for .pss files)
fat_patch_file <- read.csv('C:/Users/stevdher/OneDrive - UGent/Documenten/postdoc/research/Data_DRC/inventory_data_recent/YGB_2plots_2020.pss', header = TRUE,sep = "", stringsAsFactors = FALSE)

ed_patch_file <- read.csv('C:/Users/stevdher/OneDrive - UGent/Documenten/postdoc/fates-tutorial-main/fates-tutorial-main/inventory_data/yangambi_dummy.pss', header = TRUE,sep = "", stringsAsFactors = FALSE)


# Step 2: Check for row length differences
fat_rows_p <- nrow(fat_patch_file)
ed_rows_p <- nrow(ed_patch_file)


# If the dummy has more rows than the FATES inventory file, truncate it
if (ed_rows_p > fat_rows_p) {
  ed_patch_file <- ed_patch_file[1:fat_rows_p, ]
} 

# If the FATES inventory has more rows than the ED2 dummy, pad it with NA rows
# Make sure they have matching number of rows
if (nrow(ed_patch_file) < nrow(fat_patch_file)) {
  rows_to_add <- nrow(fat_patch_file) - nrow(ed_patch_file)
  
  # Ensure new rows are added with matching column names
  new_rows <- data.frame(matrix(0, nrow = rows_to_add, ncol = ncol(ed_patch_file)))
  colnames(new_rows) <- colnames(ed_patch_file)  # Ensure the column names match
  
  # Append new rows to the dummy
  ed_patch_file <- rbind(ed_patch_file, new_rows)
}

# Step 3: Choose which columns to overwrite in the BCI copy
# Example: If you want to overwrite "colA" in BCI with "col1" in yangambi
# Modify these column names as per your files
ed_patch_file$time <- fat_patch_file$time
ed_patch_file$patch <- fat_patch_file$patch  # Overwrite more columns if needed
ed_patch_file$trunk <- fat_patch_file$trunk  # Overwrite more columns if needed
ed_patch_file$age <- fat_patch_file$age  # Overwrite more columns if needed
ed_patch_file$area <- fat_patch_file$area  # Overwrite more columns if needed

# Step 4: Save the new modified BCI file
#write.csv(bci_file, 'C:/Users/stevdher/OneDrive - UGent/Documenten/postdoc/fates-tutorial-main/fates-tutorial-main/inventory_data/Yangambi_copy.pss', row.names = FALSE,sep = " ")
write.table(ed_patch_file, 
            file = 'C:/Users/stevdher/OneDrive - UGent/Documenten/postdoc/research/Data_DRC/inventory_data_recent/YGB_2plots_2020_ED.pss', 
            row.names = FALSE, 
            col.names = TRUE, 
            sep = " ",     # Use space as the separator
            quote = FALSE) # Prevent quotation marks around values
