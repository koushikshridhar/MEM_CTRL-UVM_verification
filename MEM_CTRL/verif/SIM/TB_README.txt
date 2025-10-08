// Command to genearte a image files having random byte data
head -c 8192 /dev/urandom | xxd -p -c1 -u > image.hex

