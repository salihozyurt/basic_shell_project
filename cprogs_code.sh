cd
argument=$@
#Control that there is the arguman.
if [ -z "$argument" ]
then
    #If argument doesn't exist, Folder is created by mkdir.
    mkdir cprogs
    echo "A directory named cprogs is created under current working directory."
    #All of C files directory is found and added in array.
    declare -a cfiles_directory=$(echo "("; find -name '*.c'; echo ")")
    for cfiles in "${cfiles_directory[@]}"
    do
        #All C files move to cprogs folder has been created.
        mv -f ${cfiles:2} cprogs
    done
    echo "All the files whose name ends with .c in the current working directory are moved into cprogs directory."
else
    #If there is an argument, same transections are maden for the argument.
    cd $argument
    mkdir cprogs
    echo "A directory named cprogs is created under $argument."
    cd
    newargument="${argument}/cprogs/" #directory combining
    declare -a cfiles_directory=$(echo "("; find -name '*.c'; echo ")")
    for cfiles in "${cfiles_directory[@]}"
    do
        mv -f ${cfiles:2} $newargument
    done
    echo "All the files whose name ends with .c in $argument are moved into cprogs directory."
fi