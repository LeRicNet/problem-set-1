#! /usr/bin/env bash

# Problem set 1 for Molecular Biology 7621
# Eric Prince
# Jan 30 2017

datasets='/Users/ericprince/Desktop/MOLB7621/data-sets'

# Problem 1
	data="$datasets/misc/states.tab.gz"

	low_murder=$(gzcat $data \
		| cut -f1,6 \
		| sort -k2nr \
		| tail -n2 \
		| cut -nf1 \
		| sed '1q;d')
	# unzip file -> take col1 + col2 -> sort murder rate in descending order -> 
	# take the last value in list -> remove murder rate (leaving state) -> isolate state 
	# name from col name
	echo 'answer-1:' $low_murder

# Problem 2
	data="$datasets/fasta/sample.fa"
	seq_records=$(cat $data \
		| grep -e '>' \
		| wc -l)
	# find records (each record starts with ">") and count lines
	echo 'answer-2:' $seq_records

# Problem 3
	data="$datasets/bed/cpg.bed.gz"
	CpG_IDs=$(gzcat $data \
		| cut -f4 \
		| uniq \
		| wc -l)
	# unzip file, cut out CpG column, find unique instances, count lines
	echo 'answer-3:' $CpG_IDs

# Problem 4
	data="$datasets/fastq/SP1.fq"
	seq_records2=$(cat $data \
		| grep -c "^>")
	# call file, pass to grep and count instances of ">" at the start of each string/line
	echo 'answer-4:' $seq_records2

# Problem 5
	data="$datasets/misc/hamlet.txt"
	bloody_words=$(cat $data \
		| grep "bloody" \
		| wc -w)
	# call file, pass to grep to find instances of bloody, pass lines to count words
	echo 'answer-5:' $bloody_words

# Problem 6
	data="$datasets/fasta/sample.fa"
	seq_length=$(cat $data \
		| grep -v '>' | head -n1 | wc -c)
	# call file, pass to grep and find non-matches for '>', 
	# isolate first entry, count characters
	echo 'answer-6:' $seq_length

# Problem 7
	data="$datasets/bed/genes.hg19.bed.gz"
	longest_gene=$(gzcat $data \
		| cut -f4 \
		| uniq \
		| awk '{ print length, $0}' \
		| sort -n \
		| cut -d" " -f2- \
		| tail -n1)
	# unzip file, cut to gene ID column, take unique instances, determine the numerical
	# length of each, sort in ascending order, cut identifiers, pick the largest
	echo 'answer-7:' $longest_gene

# Problem 8
	unique_chr=$(gzcat $data \
		| cut -f1 \
		| uniq \
		| wc -l)
	# unzip file, cut to chromosome column, isolate unique instances, count lines
	echo 'answer-8:' $unique_chr

# Problem 9
	data="$datasets/bed/peaks.chr22.bed.gz"
	ctcf_intervals=$(gzcat $data \
		| cut -f4 \
		| grep -w "CTCF" \
		| wc -l)
	# unzip file, cut out CTCF column, isolate only CTCF and not any
	# string containing CTCFL, count lines
	echo 'answer-9:' $ctcf_intervals

# Problem 10
	data="$datasets/bed/lamina.bed"
	largest_interval=$(cat /$data \
		| cut -f1,2,3 \
		| awk '{ print $1, $3 - $2 }' \
		| sort -k2n \
		| tail -n1 \
		| cut -c1-4)
	# call file -> cut chr, start, and end columns -> calculate interval length
	# on each respective chr -> sort ascending numerically by interval
	# length -> take largest interval length, return only chr#
	echo 'answer-10:' $largest_interval