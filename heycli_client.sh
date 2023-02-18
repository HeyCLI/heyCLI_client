# By heycli.com
# License: Any kind of usage of this file is allowed 

function hey() {
  if [[ $1 == "setup" &&  $# -eq 1 ]];
  then
	history | cut -c 8- > ~/.hist.txt  
	HISTFILE=~/.hist.txt 
  	curl \
      -F "curr_dir=$current_dir" \
      -H "Authorization:$HEYCLI_API_KEY" \
  		-F "histfile=@$HISTFILE" \
  		https://api.heycli.com/setup
	return
  fi
  
  history | tail -n 50 | cut -c 8- > ~/.recent_hist.txt
  recent_history=~/.recent_hist.txt 
  cmd="$*"
  current_dir="$(pwd)"

  result=$(curl -s \
                -F "command=$cmd" \
                -F "recent_history=@$recent_history" \
                -H "Authorization:$HEYCLI_API_KEY" \
                -F "curr_dir=$current_dir" \
		    https://api.heycli.com/heycli)
  
  echo "$result"
  
  command_line=$(echo "$result" | grep -o "Answer: .*" | sed 's/Answer: //')

  # echo "Command is: $command_line"

  if [[ -n "$command" ]]; then 
      echo -n "Execute command? (yes/no): "  # prompt user to confirm choice
      read choice   # read user input
            case "$choice" in
                [Yy][Ee][Ss])   # if user enters "yes"
                    eval "$command_line"   # execute the command
                    ;;
                [Nn][Oo])   # if user enters "no"
                    echo "Command not executed."
                    ;;
                *)   # if user enters anything else
                    echo "Please enter 'yes' or 'no'."
                    ;;
            esac
  fi
                
}

# http://127.0.0.1:8080/heycli
# https://api.heycli.com//heycli

function save_output {

  # run the command and capture its output
  # output=$($@ 2>&1 | tee ~/.command_outputs)
  output=$($@ 2>&1 | tee /dev/tty)

  # display the output
  # echo "$output"
  command="$*"
  current_dir="$(pwd)"
  # send the output to an API endpoint in a background process
  # curl -s -X POST -d "$output" -H "Authorization:$HEYCLI_API_KEY" http://127.0.0.1:8080/heycli > /dev/null 2>&1
  curl -s \
                -F "command=$command" \
                -F "output=$output" \
                -H "Authorization:$HEYCLI_API_KEY" \
                -F "curr_dir=$current_dir" \
		https://api.heycli.com/send_context
		
}



# alias the function to every command
alias ls='save_output ls'
alias sudo='save_output sudo'
alias ssh='save_output ssh'
alias ping='save_output ping'
alias python3='save_output python3'
alias python='save_output python'
# add more aliases for other commands as needed
