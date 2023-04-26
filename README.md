# heyCLI

LLM powered command line. Uses GPT-3 davinci-003 as of last update. It works for Linux and MacOS only for now.

This tool helps you use the command line terminal without needing to remember commands or spending time searching Google and Stack Overflow. See the demo below.

Website: [https://heycli.com](https://heycli.com)

If you find this useful or cool, please give this repo a star ⭐️  :) 

## How to install

1. Go to your terminal and download the sh file from this repo 

```
wget -q heycli_client.sh https://raw.githubusercontent.com/HeyCLI/heyCLI/main/heycli_client.sh -O ~/.heycli_client.sh
```

2. Source the script, type in your terminal:  

```
source ~/.heycli_client.sh
```

3. Go grab an API token here: https://signup.heycli.com/

4. Finally, set the HEYCLI_API_KEY environment variable in your terminal: 

```
export HEYCLI_API_KEY=<token_you_got_in_step_3>
```
5. (Optional) Set up context for HeyCLI for improved answers and suggestions. Type:

```
hey setup
```

That's it, you should be able to use the "hey" command!

## IMPORTANT 
The setup command will upload your command history as it is. We will add tools to anonymize and remove any sensitive data from the history in the future.

## Demo & use cases

![alt text](https://github.com/HeyCLI/heyCLI_client/blob/main/assets/demo_heycli.gif)

In addition to simple command suggestions, you can do:

1.  In-terminal debugging of python, nodejs, kubectl, gcloud, aws and many other command errors. When you get an error, just type: hey debug the error above (or something like that, be creative!) 

Example:

![alt text](https://github.com/HeyCLI/heyCLI_client/blob/main/assets/debug.png)

To activate this feature, you need to update your heycli_client.sh file. Get the new one from https://github.com/HeyCLI/heyCLI_client

To add a specific command to be debugged, all you need to do is add the command at the end of the heycli_client.sh file (don't forget to source it afterwards!)

![alt text](https://github.com/HeyCLI/heyCLI_client/blob/main/assets/add_commands.png)

2. We attached HeyCLI to some commands so you can type "yes" to execute them. 

Example:

![alt text](https://github.com/HeyCLI/heyCLI_client/blob/main/assets/execute.png)

## Support

Encounter any issues? please open an issue or email me at hadiazzouni@heycli.com

Also, for timely updates, please follow [@hadiazouni](https://twitter.com/hadiazouni) on Twitter 

## License
  
   Copyright © 2023 HeyCLI open source project

   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
   SOFTWARE.