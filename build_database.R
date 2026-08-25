library(dplyr)

#### Make database

dpse <- read.csv("ensembl_dpseallgenes.csv") # all dpse genes

dpse2dmel <- read.csv("ensembl_dpse2dmel.csv") # orthology dpse to dmel

# merge the datasets

dpse_orthology <- merge(dpse, dpse2dmel, all = T)

# change column names
colnames(dpse_orthology) <- c("Dpse.Gene.stable.ID", 
                                 "Dpse.Gene.name", 
                                 "Dpse.Gene.type",
                                 "LOC",
                                 "Dmel.Gene.name",
                                 "Dmel.Gene.stable.ID",
                                 "Dmel.orthology.confidence",
                                 "Dmel.orthology.type")


# load dmel dataset

dmel <- read.csv("ensembl_dmelallgenes.csv")

# change column names to match dpse_orthology database
colnames(dmel) <- c("Dmel.Gene.stable.ID",
                    "Dmel.Gene.name",
                    "Flybase.annotation.ID",
                    "Dmel.Gene.type",
                    "Dmel.Gene.description")

# merge with dpse_orthology dataset

dpse_orthology <- merge(dpse_orthology, dmel, all = T, 
                        by = "Dmel.Gene.stable.ID")

dpse_orthology$Dmel.Gene.name.x <- NULL
dpse_orthology$Dmel.Gene.name <- dpse_orthology$Dmel.Gene.name.y
dpse_orthology$Dmel.Gene.name.y <- NULL

# find dmel genes which do not have a dpse orthologue annotated

no_dpse_ortholog <- dpse_orthology %>% filter(is.na(Dpse.Gene.stable.ID))

no_dpse_ortholog <- no_dpse_ortholog[, c(1, 2, 9:12)] # come back to this with bulk download from orthodb

sum(no_dpse_ortholog$Dmel.Gene.type == "protein_coding")

# https://gitlab.com/rmwaterhouse/OrthoDB-API-Scripting/-/blob/master/README?ref_type=heads

# find dpse genes with no dmel orthologue annotated

no_dmel_orthology <- dpse_orthology %>% filter(is.na(Dmel.Gene.stable.ID))

sum(no_dmel_orthology$Dpse.Gene.type == "protein_coding")

# Export the database
write.csv(dpse_orthology, "dpse_dmel_orthology.csv")
