# Transcriptome_creation_analysis

## Description

This project focuses on creating a reference transcriptome for Aegilops speltoides. The analysis combines genomic resources from three publications and involves processing annotation files to extract and organize transcriptomic data. The aim is to provide a reliable reference for downstream analyses related to genetic diversity and evolutionary studies in Aegilops speltoides and its close relatives.

## Data Sources

The genomic annotations (GFF files) used in this project were derived from the following studies:

    Yang et al. (2023): Genome sequencing of Sitopsis species provides insights into their contribution to the B subgenome of bread wheat.
    Li et al. (2022): Genome sequences of five Sitopsis species of Aegilops and the origin of polyploid wheat B subgenome.
    Avni et al. (2022): Genome sequences of three Aegilops species of the section Sitopsis reveal phylogenetic relationships and provide resources for wheat improvement.

## Methods

  ### Processing GFF Files
      Rename the sequences names to have correspondance between sequences names of the gff and the genome.
    Extraction of Genomic Regions
        Using AGAT (Another Gff Analysis Toolkit), relevant genomic regions were extracted from the GFF files.
    Ordering the genes of the transcriptomes
        The GenomicRanges package was employed to organize the GFF annotations systematically and prepare the final reference transcriptome.

### Tools and Dependencies

    AGAT: For extracting specific genomic regions.
    GenomicRanges (R package): For ordering and structuring GFF annotations.
    R: For scripting and data manipulation.
