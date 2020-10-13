cd
argumentWord=$1
argumentDir=$2
# Word and directory argument length is taken.
lengthOfWord=$(echo -n $argumentWord | wc -m)
lengthOfDir=$(echo -n $argumentDir | wc -m)

#If there is star(*) in the word, it is changed with +[a-z]+
changeStar(){
    for (( i = 0; i <= $lengthOfWord+1; i++ ))
    do
        #Star is searched character by character aid by for loop.
        if [ "${argumentWord:$i:1}" == "*" ]
        then
            changedArgumentWord+="+[a-z]+"
        else
            changedArgumentWord+="${argumentWord:$i:1}"
        fi
    done
}
changeStar

#Output is writen in requirement format by printOutput function.
printOutput(){
    printArgument=$@
    if [ "$#" -eq "1" ]
    then
        lengthOfOutput=$(echo -n $printArgument | wc -m)
        for (( i = 0; i <= $lengthOfOutput+1; i++ ))
        do
            if [ "${printArgument:$i:1}" == ":" ]
            then
                #echo $printArgument
                upperPrintArgument=${printArgument:i+1}
                echo "The word “${printArgument:i+1}” inside ${printArgument:0:i} is substituted with “${upperPrintArgument^^}”."
            fi
        done
    fi
}

#Is there an word?
if [ -z "$changedArgumentWord" ]
then
    echo "Please input word"
else 
    #Is there an directory? Argument was not entried.
    if [ -z "$argumentDir" ]
    then
        # All text files is founded and added in array.
        declare -a txtFilesDirectory=$(echo "("; find ~/* -name '*.txt'; echo ")")
        for txtfiles in "${txtFilesDirectory[@]}"
        do
            # Word is searhed in all txt files using text files directory and word has been formatted.
            argumentGrep=$(grep -H -E -i -w -o -s "$changedArgumentWord" $txtfiles)
            lengthOfArgumentGrep=$(echo -n $argumentGrep | wc -m)
            # If any text file don't include the word, argumentGrep' length is equal zero.
            if [ $lengthOfArgumentGrep -ne 0 ]
            then
                # All directory path and word is written in Remember.log.
                echo "$argumentGrep" >> Remember.log
            fi
        done

        # All directory is readed line by line from Remember.log, and sent to printOutput function to writen in requirement formated.
        input="Remember.log"
        while IFS= read -r line
        do
            printOutput $line
        done < "$input"
        
        #Remember.log is removed
        rm Remember.log

    else
    # If there is an directory, same transections are maden for the argument.
        declare -a txtFilesDirectory=$(echo "("; find $argumentDir/* -name '*.txt'; echo ")")
        for txtfiles in "${txtFilesDirectory[@]}"
        do
            argumentGrep=$(grep -H -E -i -w -o -s "$changedArgumentWord" $txtfiles)
            lengthOfArgumentGrep=$(echo -n $argumentGrep | wc -m)
            if [ $lengthOfArgumentGrep -ne 0 ]
            then
                echo "$argumentGrep" >> Remember.log
            fi
        done
        input="Remember.log"
        while IFS= read -r line
        do
            printOutput $line
        done < "$input"
        
        rm Remember.log
    fi
fi
