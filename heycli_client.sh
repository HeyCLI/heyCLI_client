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
  		http://127.0.0.1:8080/setup
	return
  fi
  
  history | tail -n 50 | cut -c 8- > ~/.recent_hist.txt
  recent_history=~/.recent_hist.txt 
  cmd="$*"
  current_dir="$(pwd)"
  curl -s \
                -F "command=$cmd" \
                -F "recent_history=@$recent_history" \
                -H "Authorization:$HEYCLI_API_KEY" \
                -F "curr_dir=$current_dir" \
		http://127.0.0.1:8080/heycli
                
}

# http://127.0.0.1:8080/heycli
# https://api.heycli.com//heycli

function save_output {

  # run the command and capture its output
  output=$($@ 2>&1 | tee ~/.command_outputs)

  # display the output
  echo "$output"
  command="$*"
  current_dir="$(pwd)"
  # send the output to an API endpoint in a background process
  # curl -s -X POST -d "$output" -H "Authorization:$HEYCLI_API_KEY" http://127.0.0.1:8080/heycli > /dev/null 2>&1
  curl -s \
                -F "command=$str" \
                -F "output=$output" \
                -H "Authorization:$HEYCLI_API_KEY" \
                -F "curr_dir=$current_dir" \
		http://127.0.0.1:8080/send_context
		
}

# alias the function to every command
alias sudo='save_output sudo'
alias ssh='save_output ssh'
alias ping='save_output ping'
alias python3='save_output python3'
alias python='save_output python'
# alias hey='save_output hey'
# add more aliases for other commands as needed


