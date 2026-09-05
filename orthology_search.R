#### Orthology Search and Convert Tool
#### Fiona Messer
#### 28/07/2026

# install packages
library("stringr")

# Search for gene list

markers <- c("cg3399", "Act42a", "4805701") # List of genes or name of csv file

file_type <- "list" # type of file provided to markers, either "list" or "csv"

prefix <- "" # Add a prefix to your output file names

save_orthologs <- TRUE # Logical (TRUE or FALSE) TRUE exports converted genes to .csv file

# Load the database
if (exists("dpse_orthology") && is.data.frame(get("dpse_orthology"))){
  print("database pre-loaded")
} else {
  dpse_orthology <- read.csv("dpse_dmel_orthology.csv")
  print("database imported")
}

# Load the marker list
if (file_type == "csv"){
  markers <- read.csv(paste0(markers, ".csv")) # Loads the list of genes
  print("markers provided as csv")
} else {
  print("markers provided as list")
}

# clear outputs from previous searches
matching_values <- NULL
orthologs <- NULL
search_column <- NULL

# search with stringr
for (m in markers){
  if((grepl("CG", m, ignore.case = TRUE)) == TRUE){
    search_column <- dpse_orthology$Flybase.annotation.ID
    print("gene type = CG")
  } else if((grepl("LOC", m, ignore.case = TRUE)) == TRUE){
    search_column <- dpse_orthology$Dpse.Gene.stable.ID
    print("gene type = LOC")
  } else if((grepl("FBgn", m, ignore.case = TRUE)) == TRUE){
    search_column <- dpse_orthology$Dmel.Gene.stable.ID
    print("gene type = FBgn")
  } else {
    search_column <- NULL
    print("gene type = unknown") #tells stringr which column to serach depending on type of input
  }
  if(length(search_column) < 1){
    matching_values <- append(matching_values, 
                              str_which(dpse_orthology$LOC, 
                                        regex(paste0("^", m, "$"), ignore_case = TRUE)))
    matching_values <- append(matching_values, 
                              str_which(dpse_orthology$Dmel.Gene.name.y, 
                                        regex(paste0("^", m, "$"), ignore_case = TRUE)))
    matching_values <- append(matching_values, 
                              str_which(dpse_orthology$Dmel.Gene.description, 
                                        regex(paste0("^", m, "$"), ignore_case = TRUE)))
  } else {
    matching_values <- append(matching_values, 
                              str_which(search_column, 
                                        regex(paste0("^", m, "$"), ignore_case = TRUE)))}
  print(matching_values)
  }
print("search completed")

# output dataframe
orthologs <- dpse_orthology[matching_values,c(2, 3, 7, 11, 13)]
orthologs

if(save_orthologs == TRUE){
  write.csv(orthologs, paste0(prefix, "orthologues.csv"))
  print("Output saved as csv")
} else {
  print("WARNING: Output not saved")
}


