# Produces "test1.sh: line 4: 5: command not found"

function foo() {
    bar= 5;
    printf "Bar is equal to $bar";
}
foo