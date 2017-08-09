#!/bin/bash
# Script for removing metadata and linearizing PDF's so they load faster
# Run script as root
# Script will place the original copy of the PDF's into a folder you specify below. 

echo ""
echo "----------------------------------------------------------------------------------------------------------------------"
echo ""
echo "Initiating metadata removal..."
echo ""

count=0
pdf_path="/tmp/original_pdfs"
mkdir ${pdf_path}
shopt -s globstar

for file in /var/www/**/*.pdf

do
	let count++
	echo "----------------------------------------------------------------------------------------------------------------------"
	echo ""
	echo "Removing metadata on ${file}"
	cp "${file}" "${pdf_path}"
	mv "${file}" "${file}_meta"
	echo ""
	echo "Running exiftool on ${file}"
	exiftool -all:all= "${file}_meta"
	echo ""
	echo "Running qpdf on ${file}"
	qpdf --linearize "${file}_meta" "$file"
	rm "${file}_meta"
	echo ""
done

# Reset ownership of PDFs to www-data
echo "----------------------------------------------------------------------------------------------------------------------"
echo "Resetting permissions..."
echo ""
shopt -s globstar
chown -R www-data:www-data /var/www/**/*.pdf
shopt -s globstar
chmod -R 644 /var/www/**/*.pdf
echo "----------------------------------------------------------------------------------------------------------------------"
echo ""
echo "All permissions reset and metadata removed from ${count} files"
echo "Original PDFs moved to: ${pdf_path}"
echo ""
echo "----------------------------------------------------------------------------------------------------------------------"
echo ""