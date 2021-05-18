# awk to select columns in csv file
awk -F 'separator_in_file' 'BEGIN{OFS = "separator_output"}{print $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $15, $16}' file_to_read > file_to_write

# sed to remove/replace windows end of line
sed -e 's/^M/patern/' file_to_read > file_to_write
