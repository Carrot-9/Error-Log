#!/bin/bash

read  -p "Pick a file to log the errors of: " -r filename

function run_file() {
tempfile=$(mktemp);
trap 'rm -f "$tempfile"' EXIT

bash "$filename" > /dev/null 2> "$tempfile"
line_count=$( wc -l < "$tempfile");
current_date=$(date +%F_%T);

log_errors;
}

function log_errors() {
if [[ line_count -ne 0 ]]; then 
    printf "Sending Errors From $filename To Log...\n\n";
    echo -e "\nDate: $current_date\n" >> error.log && cat "$tempfile" >> error.log;
    printf "Errors Logged.";
    sleep 1;
    exit 0;
else 
    printf "...No Errors Occured In That File.";
    sleep 1; 
    exit 0;
fi
}

function file_check() {
if [[ -f "$filename" ]]; then
    printf "\nEntering Log File...\n\n"
    sleep 1;
    run_file
else 
    printf "\nFile Does Not Exist...";
    exit 1; 
fi
}
file_check





