#!/bin/bash
# CONVERT MD to LaTeX
opath=$(pwd)/"$1"
new_filename=$(echo "$1" | sed 's/.md/.tex/')
article_title=$(echo "$1" | sed 's/.md//')
new_path=$(pwd)/"$new_filename"
pandoc "$opath" -o "$new_path"

#Build the article file.
build_start=$(pwd)"/template/doc-open.tex"
build_end=$(pwd)"/template/doc-close.tex"
cat "$build_start" "$new_filename" "$build_end" > temp.tex
rm "$new_path"
mv temp.tex "$new_path"

# Supress header nums
sed -i 's/section/section*/g' "$new_path"
sed -i "s/|TITLE|/$article_title/" "$new_path"
sed -i '/\includegraphics/d' "$new_path"

# Build the file.
pdflatex "$new_path"

rm "$article_title.aux"
rm "$article_title.log"
rm "$article_title.out"
rm "$article_title.tex"
