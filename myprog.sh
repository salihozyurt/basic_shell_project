# Menu design for scripts

while :
  do
    clear
    echo "1. Check for palindromes"
    echo "2. Move .c files"
    echo "3. Draw hollowed square"
    echo "4. Uppercase conversion"
    echo "5. Delete files"
    echo "6. Exit"
    echo "For arguments star means optional."
    echo "[] in arguments denotes a set."
    echo -n "Please select an option: "
    read yourChoice
    case $yourChoice in
        1) echo -n -e "Argument Form: [word]\nEnter arguments: "
        read args
        ./palindrome.sh $args
        read ;;
 	    2) echo -n -e "Argument Form: [*directory]\nEnter arguments: "
        read args
        ./cprogs_code.sh $args
        read ;;
 	    3) echo -n -e "Argument Form: [number number]\nEnter arguments: "
        read args
        ./draw_square.sh $args
        read ;;
 	    4) echo -n -e "Argument Form: [regex_word *directory]\nEnter arguments: "
        read args
        ./find_word.sh $args
        read ;;
        5) echo -n -e "Argument Form: [*-R *directory]\nEnter arguments: "
        read args
        ./remove_files.sh $args
        read ;;
 	    6) exit 0 ;;
 	    *) echo "Opps!!! Please select choice 1,2,3,4,5, or 6";
 	   echo "Press a key. . ." ; read ;;
     esac
  done