# We created error codes
WRONG_ARG_NUMBER=34
WRONG_ARG_TYPE=47
proto_word=$@
# transforms word in to lower case
word=${proto_word,,}
word=${word// /}
# finds length of input string using wc command
LENGTH=$(echo -n $word | wc -m)
argnum=$#

# Using regex controls if a var is string in lowercase
is_string()
{
    regex='^[a-zi ]+$'
    if [[ $word =~ $regex ]]
    then
        return 1
    else
        return 0
    fi
}

# finds if a string is polindrome
# The main logic is to get reversed string and compare it with the original one
is_palindrome()
{
    if [ $argnum -eq 1 ]
    then
        is_string $word
        if [ $? = 1 ]
        then
            for (( i = $LENGTH - 1; i >= 0; --i ))
            do
                reverse="$reverse${word:$i:1}"
            done
            if [ "$reverse" == "$word" ]
            then
                return 1
            else
                return 0
            fi
        else
            echo "You must enter a string value."
            exit $WRONG_ARG_TYPE
        fi
    else
        echo "Please enter only one argument."
        exit $WRONG_ARG_NUMBER
    fi
    return 0
}

is_palindrome
# using return value we decide if string is palindrome or not
if [ $? -eq 1 ]
then
    echo "$proto_word is a palindrome"
else
    echo "$proto_word is not a palindrome"
fi