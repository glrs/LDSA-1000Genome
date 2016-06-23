# LDSA-1000Genome
This is a project on the 1000Genomes data-set, for the LDSA course.

# Introduction
The Next Generation Sequencing (NGS) methods signaled a new era of data acquisition for the biologists around the globe and was followed, as expected, by an explosion of biological data. The new sequencing methods not only made the whole sequencing process much faster, but they led the way to a dramatic drop in sequencing costs during the years that followed (Metzker, 2010).
Projects that aimed to produce large amounts of data by utilizing these new methods were highly favored under, and one of the first and most known ones is the 1000 Genomes project (Siva, 2008). The project’s main focus was to produce human genome data from at least 1000 individuals, aiming to help the human variation studies, which target this 1% of our genome that tells populations and individuals apart from one another. The final number of samples for the project reached a bit over 2500 individuals.
One of the first and biggest issues that arose on the very beginning of the analysis pipeline, is the efficient handling of the sheer amounts of data that are being produced. It is known that biologists nowadays have so much data to use, however the analysis of this data requires days, weeks or even months. This is a major bottleneck in the utilization of the NGS data.
In this study we are using Hadoop MapReduce in order to test its utilization capabilities in such kind of data. More specifically, the testing scenario of the study has the goal of acquiring all the mate pair reads from the dataset, that have more than 1000 base pairs insert size, and a high alignment quality based on the cigar string information.

# Materials and Methods
## Data
We are using the genome data of the 1000 Genomes project, which is publicly available. The data is consisted of 26 populations from around the world, with a total number of 2535 individuals, and with a 4x sequencing coverage. Due to computational resource constraints, we are using a subset of that data, including data from all the individuals which derived only from the chromosome 20. The data are provided in BAM file format, summing up to 1.1TB in storage space.

## Hadoop MapReduce
Hadoop is mainly defined as the combination of the Hadoop Distributed File System (HDFS) with the MapReduce processing framework. For more on MapReduce: https://www-01.ibm.com/software/data/infosphere/hadoop/mapreduce/

## Hadoop-BAM
NGS data are usually stored in BAM formatted files, which are the compressed binary file equivalent of SAM files. According to (N iemenmaa et al., 2012) the problem of directly using Hadoop to process these files, is that it is difficult for Hadoop MapReduce to identify boundaries into binary files. Hadoop-BAM was developed in order to be able to process BAM files on top of Hadoop. To achieve that, the Hadoop-BAM Java library was created as an intermediate, connecting step for the Hadoop and the BAM files. The Hadoop-BAM
library was developed to provide two methods of data accessing:
 * First, with the use of precomputed indexing, which allows for random access to the BAM records
 * Second, with the use of a two-level detection routine (instead of indexing).
For more: https://github.com/HadoopGenomics/Hadoop-BAM

## Infrastracture
The infrastructure we used was an OpenStack cloud system that offers live nodes running Hadoop (v1.2.1). Each node used the computational power of 4 VCPUs, had 8GB of RAM, and Hard Disk capacity of 80GB. We enriched our instances with Hadoop-BAM (v7.0.0) and Samtools, in order to be able to analyse our data and view the results.

# Results
The resulting data are consisted of one BAM file per population that contains all the reads with insert size higher than 1000 and an alignment quality of more than 80M. From that data, the number of reads for each population was calculated and a basic analysis was performed, comparing the average total number of reads per population as well as grouping the populations using colorcode based on origin. The insert size (fragment length) is in log scale and there is a minimum/maximum representation per population, on top of each bar.

![alt tag](https://github.com/glrs/LDSA-1000Genome/blob/master/Figures/LDSA-FinalLog.png)
__Figure 1.__ A verage fragment length per population (green Asians, blue Europeans, red Africans, purple Americans and yellow Middle Easterns).

![alt tag](https://github.com/glrs/LDSA-1000Genome/blob/master/Figures/WorldMapPlot.png)

__Figure 2.__ World map representation of the fragment length average per population.


![alt tag](https://github.com/glrs/LDSA-1000Genome/blob/master/Figures/scalability.png)

__Figure 3.__ Scalability test plot, representing the running time in correspondence to the number of nodes (1-3) used.


# References
Niemenmaa, M., Kallio, A., Schumacher, A., Klemelä, P., Korpelainen, E., & Heljanko, K. (2012). HadoopBAM: directly manipulating next generation sequencing data in the cloud. Bioinformatics , 28 (6), 876-877.

Metzker, M. L. (2010). Sequencing technologies—the next generation. Nature Reviews Genetics , 11 (1), 31-46.

Siva, N. (2008). 1000 Genomes project. Nature biotechnology, 26 (3), 256-256.
