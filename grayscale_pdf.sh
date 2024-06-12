#!/bin/bash
echo select the PDF file to convert to grayscale
echo output file will have additional "-grayscale.pdf" in filename 
read -p "Press enter to continue"
input_file=$(zenity --file-selection --file-filter=*[PpDdFf])
if2=${input_file::-4}
if3="$if2.pdf"
if4="$if2-grayscale.pdf"
gs  -sOutputFile="$if4"  -sDEVICE=pdfwrite  -sColorConversionStrategy=Gray  -dProcessColorModel=/DeviceGray  -dCompatibilityLevel=1.4  -dNOPAUSE  -dBATCH "$if3"


