# A shell program to remove empty files

# Error codes
PATH_DOES_NOT_EXIST_ERROR=47
DIRECTORY_DOES_NOT_EXIST_ERROR=48
WRONG_COMMAND_FORMAT=49
,
# Checks if path exists using ls
does_path_exist()
{
    path=$1
    ls $path > "message.log"
    if [ $? == 2 ]
    then
        echo "Path does not exist."
        exit $PATH_DOES_NOT_EXIST_ERROR
    fi
}

# Removes empty files in given path
remove_files()
{
    path=$1
    does_path_exist $path
    files=$path/*
    for file in $files
    do
        if ! [ -s $file ]
        then
            raw_filename="$(basename "$file")"
            read -p "Do you want to delete $raw_filename? (y/n): "
            if [ "$REPLY" == "y" ]
            then
                rm -f $file
                echo "1 file deleted"
            fi
        fi
    done
}

# Removes empty files starting from a root directory using recursiveness
# We concatenate directory names to the current directory then traverse inside it
remove_recursively()
{
    for directory in */
    do
        if [ $directory == "*/" ]
        then
            return 0
        fi
        current_dir=$(pwd)
        remove_files $directory
        cd $directory
        remove_recursively $directory
        cd $current_dir
    done
}

param=$1

# Checks for every case and removes empty files
if [ $# -eq 0 ]
then
    remove_files $(pwd)
elif [[ $# -eq 1 && $1 == "-R" ]]
then
    remove_files $(pwd)
    remove_recursively $(pwd)
elif [[ $# -eq 1 && ${param:0:1} != "-" ]]
then
    does_path_exist $1
    echo "Wow"
    cd $1
    remove_files $(pwd)
elif [[ $# -eq 2 && $1 -eq "-R" ]]
then
    does_path_exist $1
    cd $1
    remove_files $(pwd)
    remove_recursively $(pwd)
else
    echo "Command Format:: remove_files [-R] [path]"
    exit $WRONG_COMMAND_FORMAT
fi  