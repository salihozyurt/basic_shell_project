# A script to draw squares using arguments

# We created error codes and boolean enums
WRONG_ARG_NUMBER=17
WRONG_ARG_VALUE=18
WRONG_ARG_FORMAT=19
SUCCESS=1
FAILURE=0

# Controls if an input is a number
is_number()
{
    input=$1
    regex='^[0-9]+$'
    if [[ $input =~ $regex ]]
    then
        return $SUCCESS
    else
        return $FAILURE
    fi
}

# Controls if a value is even
is_even()
{
    input=$1
    if [[ $input%2 -eq 0 ]]
    then
        return $SUCCESS
    else
        return $FAILURE
    fi
}

# if number of args is two we can proceed
if [ $# == 2 ]
then
    # Checks inputs
    is_number $1
    is_first_argument_number=$?
    is_number $2
    is_second_argument_number=$?
    # If tests are successful proceed
    if [[ $is_first_argument_number == $SUCCESS && $is_second_argument_number == $SUCCESS ]]
    then
        # If the different is even then continue
        is_even $(($1-$2))
        # If true continue
        if [[ $1 -gt $2 &&  $? == $SUCCESS ]]
        then
            # We create a floor and ceil using a basic drawing algorithm
            # Floor is constant yet ceil is changed by even and odd numbers
            floor=$(($1/2-$2/2-1))
            is_even $1
            if [ $? -eq $FAILURE ]
            then
                ceil=$(($1/2+$2/2+1))
            else
                ceil=$(($1/2+1))
            fi
            # In two for loops we draw the hallowed squares using floor and ceil
            for (( i = 0; i < $1; ++i ))
            do
                for (( j = 0; j < $1; ++j ))
                do
                    if [[ $i -gt $floor && $i -lt $ceil && $j -gt $floor && $j -lt $ceil ]]
                    then
                        echo -n " "
                    else
                        echo -n "*"
                    fi
                done
                echo
            done
        else
            echo "First number must be greater than the second. And the difference must be even."
            exit $WRONG_ARG_FORMAT
        fi
    else
        echo "Both arguments must be integers."
        exit $WRONG_ARG_VALUE
    fi
else
    echo "Please enter two numbers."
    exit $WRONG_ARG_NUMBER
fi