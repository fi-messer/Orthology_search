Orthology Search
================
Fiona Messer
2026-09-04

Converting a long list of genes you are interested in from *Drosophila
pseudoobscura* to *D. melanogaster* is time-consuming and prone to
error. With this script, you can supply lists of genes, either manually
in the script or as a csv file, and it will convert the whole list in
one go.

Furthermore, you can supply genes from both *D. pseudoobscura* and *D.
melanogaster* in the same list. The supported formats are CG number, LOC
number and gene symbol. Inputs are not case sensitive.

This script requires the R package `stringr`.

## Inputs

Provide a list of genes you want to convert. You can provide a list in
the script, with each gene in quotes and separated by a comma
(e.g. `"cg3399", "Act42a", "4805701"`). Alternatively, you can supply a
csv file. Simply copy the file into the R project folder, then provide
the name of the csv file in the `markers` field
(e.g. `"genes_of_interest"`). You do not need to add the file extension.

``` r
markers <- c("cg3399", "Act42a", "4805701") # List of genes or name of csv file
```

Next, let the script know whether you have provided a list or a csv
file.

``` r
file_type <- "list" # type of file provided, either "list" or "csv"
```

Now decide how you would like your outputs. You can save the output to a
csv file, and if so, add a specific prefix to your output file.

``` r
save_orthologs <- FALSE # Logical (TRUE or FALSE) TRUE exports converted genes to .csv file

prefix <- "" # Add a prefix to your output file names
```

That’s it for inputs, now the script will run and generate the list of
orthologous genes.

## Orthology search script

The script loads or imports the database of orthologous genes.

    ## [1] "database imported"

Next it loads the list of genes provided by the user.

    ## [1] "markers provided as list"

Remove any data from previous searches:

And run the search:

    ## [1] "gene type = CG"
    ## [1] 88
    ## [1] "gene type = unknown"
    ## [1] 88 16 17
    ## [1] "gene type = unknown"
    ## [1] 88 16 17  2

    ## [1] "search completed"

## Outputs

A gene orthology dataframe is generated, containing both *D.
pseudoobscura* and *D. melanogaster* orthologues of all of the provided
genes.

The orthology table is printed below:

    ##    Dmel.Gene.stable.ID Dpse.Gene.stable.ID Dmel.Gene.name.x
    ## 88         FBgn0000256          LOC6902849             capu
    ## 16         FBgn0000043         LOC26534122           Act42A
    ## 17         FBgn0000043          LOC6898658           Act42A
    ## 2          FBgn0000008          LOC4805701                a
    ##    Flybase.annotation.ID Dmel.Gene.description
    ## 88                CG3399            cappuccino
    ## 16               CG12051             Actin 42A
    ## 17               CG12051             Actin 42A
    ## 2                 CG6741                   arc

    ## [1] "WARNING: Output not saved"
