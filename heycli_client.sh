# By heycli.com
# License: Any kind of usage of this file is allowed 

function hey() {
  if [[ $1 == "setup" &&  $# -eq 1 ]];
  then
	history | cut -c 8- > ~/.hist.txt  
	HISTFILE=~/.hist.txt 
  	curl \
  		-F "userid=1" \
  		-F "filecomment=This is the command history file" \
  		-F "histfile=@$HISTFILE" \
  		https://api.heycli.com/uploader 
	return
  fi
  
  str="$*"
  current_dir="$(pwd)"
  curl \
                -F "command=$str" \
                -H "Authorization:$HEYCLI_API_KEY" \
                -F "curr_dir=$current_dir" \
                https://api.heycli.com//heycli
}
