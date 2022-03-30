#! /bin/bash



input=($@)



function help()
{
   echo "--version                                              Version of the command"
   echo "cpu getinfo                                            Information of cpu"
   echo "memory getinfo                                         Information of memory"
   echo "user create <username>                                 Create a new user"
   echo "user list                                              Show all the present user"
   echo "user list --sudo-only                                  Show all the user with sudo permissions"
   echo "file getinfo <file-name>                               Information about the file"
   echo "file getinfo <option> <file-name>                      Particular information about the file"
   echo "<option> are"
   echo "(--size)                                              to print size of the given file"
   echo "(--permissions)                                       to print permission of the given file"
   echo "(--Owner)                                             to print owner of the given file"
   echo "(--last-modified)                                     to print last modified date of the given file"
    
}






if [ $# -eq 1 ] 
then

    if [ ${input[0]} == '--version' ]
    then 
         echo "v0.1.0"
    elif [ ${input[0]} == '--help' ]
    then
         help
    fi

elif [ $# -eq 2 ]
then
    
    if [ ${input[0]} == 'cpu' ] && [ ${input[1]} == 'getinfo' ] 
    then
         lscpu
    elif [ ${input[0]} == 'memory' ] && [ ${input[1]} == 'getinfo' ] 
    then
          free
    elif [ ${input[0]} == 'user' ] && [ ${input[1]} == 'list' ]
    then
        cut -f1 -d ":" /etc/passwd
    fi
    
elif [ $# -eq 3 ]
then 
     
     if [ ${input[0]} == 'user' ] && [ ${input[1]} == 'create' ] && [ ${input[2]} != "" ]
    then
         sudo useradd ${input[2]}
    elif [ ${input[0]} == 'user' ] && [ ${input[1]} == 'list' ] && [ ${input[2]} == "--sudo-only" ]
    then
          getent group sudo | cut -f4  -d ":"
    elif [ ${input[0]} == 'file' ] && [ ${input[1]} == 'getinfo' ] && [ ${input[2]} != "" ]
    then
          read -a text <<< $( ls -lh ${input[2]})
          
       echo "file: ${input[2]}"
	  echo "Size: ${text[4]}"
	  echo "Access: ${text[0]}"
	  echo "Owner: ${text[2]}"
	  echo "Modify: ${text[5]} ${text[6]} ${text[7]}"
    fi 

elif [ $# -eq 4 ]
then   
     if [ ${input[0]} == 'file' ] && [ ${input[1]} == 'getinfo' ] && [ ${input[2]} != "" ] && [ ${input[3]} != "" ]
     then
         
		  read -a filename <<< $( ls -l ${input[3]})
		  
		  case ${input[2]} in
		   
		  --size)
		    echo ${filename[4]}
		    ;;

		  --permissions)
		    echo ${filename[0]}
		    ;;

		  --Owner)
		    echo ${filename[2]}
		    ;;
		    
		  --last-modified)
		    echo ${filename[5]} ${filename[6]} ${filename[7]}
		    ;;

		  *)
		    echo "unknown"
		    ;;
		esac
		
      fi          
               
fi








