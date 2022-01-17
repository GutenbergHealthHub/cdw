# awk to select columns in csv file
awk -F 'separator_in_file' 'BEGIN{OFS = "separator_output"}{print $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $15, $16}' file_to_read > file_to_write

# awk + head to show the columns of the 1st line of a file
awk -F ';' '{OFS = ";"}{print $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $15, $16}' file_to_read | head -1

# sed to remove/replace windows end of line
sed -e 's/^M/patern/' file_to_read > file_to_write

# iconv to convert from ISO-8859-15 (Windows) to utf-8
iconv -f ISO-8859-15 -t UTF-8//TRANSLIT < FILE_TO_READ > FILE_OUPUT

# for to execute script
for i in {1..100000}; do bash script_to_execute.sh; done

# generate ramdom string and save into a file
str=`</dev/urandom tr -dc 'A-Za-z0-9!"#$%&'\''()*+,-./:;<=>?@[\]^_\`{|}~' | head -c number`
echo "$str" >> /dir/file

# delete BOM
sed -i '1s/^\xEF\xBB\xBF//' file
