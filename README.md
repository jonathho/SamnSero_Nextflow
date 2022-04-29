# SamnSero (Nextflow)
The nextflow pipeline processes raw Nanopore sequencing reads for *Salmonella enterica*. Different modules can be optionally invoked to perform genome annotation and quality control checks.

## Installation
```bash
# Install Pre-requisites
 - Nextflow
 - Docker

# Install SamnSero Nextflow pipeline
nextflow pull -hub github jimmyliu1326/SamnSero_Nextflow
```

## Pipeline Usage
```
Required arguments:
    --input PATH                  Path to a .csv containing two columns describing Sample ID and path to raw reads directory
    --outdir PATH                 Output directory path

Optional arguments:
    --annot                        Annotate genome assemblies using Abricate
    --custom_db PATH               Path to a headerless .csv that lists custom databases (.FASTA) to search against for 
                                   genome annotation instead of default Abricate databases (card, vfdb, plasmidfinder).
                                   The .csv should contain two columns describing database name and path to FASTA.
    --qc                           Perform quality check on genome assemblies
    --notrim                       Skip adaptor trimming by Porechop
    --help                         Print pipeline usage statement
```

## Example Usage
```bash
nextflow run /path/to/SamnSero.nf --input samples.csv --outdir results
```