#!/bin/bash

set -e

read -p  "Pick a file to log the errors of: " filename

current_date=$(date +%F_%T);
line_count=$(wc -l);
exit_status=$?;

function foo() {
if [[ exit_status -ne 0 ]]; then 
    (printf "Date: $current_date\n\n") | tee error.log && "$filename" 2> error.log && cat -n error.log; 
elif (( exit_status != 0 && line_count >= 200 )); then 
    printf "Reset On: $current_date" > error.log;  
else 
    printf " No Errors Have Occured."; 
    exit 0;
fi
}
foo

