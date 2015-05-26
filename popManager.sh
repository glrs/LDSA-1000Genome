#!/bin/bash
set -e

for pop in {CLM,PUR,ACB,FIN,CHS,CDX,IBS,PEL,PJL,KHV,CHB,JPT,CEU,TSI,GBR,YRI,LWK,GWD,MSL,ESN,ASW,MXL,BEB,STU,ITU,GIH}
do
echo "--------------- START for $pop ----------------"
hadoop dfs -mkdir /$pop
echo "Dir made for $pop"
hadoop dfs -put /mnt/gen-vol/GenomeData/*$pop* /$pop/
echo "$pop population transferred into HDFS."
rfile="$(hadoop dfs -ls /$pop | head -n 2 | xargs -0 -n 1 basename)"
hadoop jar ../target/hadoop-bam-7.0.0-jar-with-dependencies.jar view -H /$pop/$rfile > headers/$pop.txt
echo "BAM Header for $pop taken."
hadoop jar target/*-jar-with-dependencies.jar org.seqdoop.hadoop_bam.examples.TestBAM "file:/home/ubuntu/hadoop-bam-7.0.0/examples/headers/$pop.txt" /$pop/*.bam /GenomeResults/"$pop"_out
echo "END of HadoopBAM processing for $pop population."
hadoop dfs -copyToLocal /GenomeResults/"$pop"_out/part-r-00000 /home/ubuntu/Results/"$pop"_Results
echo "Results for $pop transferred out of HDFS."
hadoop dfs -rmr /$pop
echo "Folder $pop removed from HDFS."

samtools view ../../Results/"$pop"_Results | ./bam_res_mapper.py | sort | ./reducer.py > ../../Results/"$pop"_counts_pp.txt
echo "Results analysis step for $pop finished."
echo "--------------- END of $pop ----------------"

done
