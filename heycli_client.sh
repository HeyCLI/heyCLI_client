# By heycli.com
# License: Any kind of usage of this file is allowed 
# Install jq using apt-get or yum depending on the detected OS
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Debian/Ubuntu-based systems
    apt-get update
    apt-get install -y jq
elif [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    brew install jq
else
    # Unsupported OS
    echo "Error: Unsupported OS"
    exit 1
fi

PROD_API_ENDPOINT="https://api.heycli.com"
LOCAL_API_ENDPOINT="http://127.0.0.1:8080"

API_END_POINT=$PROD_API_ENDPOINT

function hey() {
  if [[ $1 == "setup" &&  $# -eq 1 ]];
  then
	history | cut -c 8- > ~/.hist.txt  
	HISTFILE=~/.hist.txt 
  	curl \
      -F "curr_dir=$current_dir" \
      -H "Authorization:$HEYCLI_API_KEY" \
  		-F "histfile=@$HISTFILE" \
  		"$API_END_POINT/setup"
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
		    "$API_END_POINT/heycli")

  # echo $result
  
  command_line=$(echo $result | jq -r '.command')
  answer=$(echo $result | jq -r '.original_text')

  echo "Answer: $answer"

  if [[ -n "$command_line" ]]; then 
      echo -n "Execute command ($command_line)? (type \"yes\" to approve): "  # prompt user to confirm choice
      read choice   # read user input
            case "$choice" in
                [Yy][Ee][Ss])   # if user enters "yes"
                    eval "$command_line"   # execute the command
                    ;;
                *)   # if user enters anything else
                    echo "Command not executed."
                    ;;
            esac
  fi
}


function save_output {

  # run the command and capture its output
  # output=$($@ 2>&1 | tee ~/.command_outputs)
  output=$($@ 2>&1 | tee /dev/tty)

  command="$*"
  current_dir="$(pwd)"

  curl -s \
                -F "command=$command" \
                -F "output=$output" \
                -H "Authorization:$HEYCLI_API_KEY" \
                -F "curr_dir=$current_dir" \
		"$API_END_POINT//send_context"
		
}



# alias the function to every command
alias ls='save_output ls'
alias sudo='save_output sudo'
alias ssh='save_output ssh'
alias ping='save_output ping'
alias python3='save_output python3'
alias python='save_output python'
# add more aliases for other commands as needed
