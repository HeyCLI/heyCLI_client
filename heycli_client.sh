# By heycli.com
# License: Any kind of usage of this file is allowed 

PROD_API_ENDPOINT="https://api.heycli.com"
LOCAL_API_ENDPOINT="http://127.0.0.1:8080"
REMOTE_SCRIPT="https://raw.githubusercontent.com/HeyCLI/heyCLI_client/main/heycli_client.sh"

API_END_POINT=$LOCAL_API_ENDPOINT;

function hey() {
  wget -q $REMOTE_SCRIPT -O ~/.heycli_client_new.sh
  if ! cmp -s ~/.heycli_client_new.sh ~/.heycli_client.sh; then
      mv ~/.heycli_client_new.sh ~/.heycli_client.sh
      source ~/.heycli_client.sh
      echo "HeyCLI client updated successfully"
  fi

  if [[ $1 == "update" &&  $# -eq 1 ]]; then
    echo "Updating HeyCLI client..."
    curl -s $REMOTE_SCRIPT > ~/.heycli_client.sh
    source ~/.heycli_client.sh
    echo "HeyCLI client updated successfully"
    return
  fi
  
  if [[ $1 == "help" &&  $# -eq 1 ]];
  then
    echo "HeyCLI client"
    echo "Usage: hey <query in natural langauge>"
    echo "Examples:"
    echo "hey list files"
    echo "hey list git commits of last 2 days"
    echo "hey what GKE region is used by my cluster"
    echo "hey ping google.com"
    echo "hey write a file with name test.txt and content \"Hello World\""
    echo "hey create a dockerfile with base image ubuntu and expose port 80"
    echo "For more information visit: $GITHUB_REPO_URL"
    return
  fi

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

  answer=$(curl -s \
                -F "command=$cmd" \
                -F "recent_history=@$recent_history" \
                -H "Authorization:$HEYCLI_API_KEY" \
                -F "curr_dir=$current_dir" \
		    "$API_END_POINT/heycli")

  echo "Answer: $answer"
  
  command_line=$(curl -s \
                -F "answer=$answer" \
		    "$API_END_POINT/get_command")
  echo
  # echo "Command_line: $command_line"

  # if command_line is not empty and is different from "No command" then execute it
    

  if [[ -n "$command_line" ]]; then 
    if [[ "$command_line" != "No command" ]]; then
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
