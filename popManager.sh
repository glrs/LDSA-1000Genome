#!/bin/bash
set -e

for pop in {CLM,PUR,ACB,FIN,CHS,CDX,IBS,PEL,PJL,KHV,CHB,JPT,CEU,TSI,GBR,YRI,LWK,GWD,MSL,ESN,ASW,MXL,BEB,STU,ITU,GIH}
do
echo "--------------- START for $pop ----------------"
hadoop dfs -mkdir path/$pop
echo "Dir made for $pop"
hadoop dfs -put /path/GenomeData/*$pop* path/$pop/
echo "$pop population transferred into HDFS."
rfile="$(hadoop dfs -ls path/$pop | head -n 2 | xargs -0 -n 1 basename)"
hadoop jar path/hadoop-bam-7.0.0-jar-with-dependencies.jar view -H path/$pop/$rfile > headers/$pop.txt
echo "BAM Header for $pop taken."
hadoop jar path/*-jar-with-dependencies.jar org.seqdoop.hadoop_bam.examples.TestBAM "file:/path/headers/$pop.txt" path/$pop/*.bam path/GenomeResults/"$pop"_out
echo "END of HadoopBAM processing for $pop population."
hadoop dfs -copyToLocal path/GenomeResults/"$pop"_out/part-r-00000 /path/Results/"$pop"_Results
echo "Results for $pop transferred out of HDFS."
hadoop dfs -rmr path/$pop
echo "Folder $pop removed from HDFS."

samtools view path/Results/"$pop"_Results | ./bam_res_mapper.py | sort | ./reducer.py > path/Results/"$pop"_counts_pp.txt
echo "Results analysis step for $pop finished."
echo "--------------- END of $pop ----------------"

done
