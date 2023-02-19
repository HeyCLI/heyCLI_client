# heyCLI

LLM powered command line. Uses GPT-3 davinci-003 as of last update. 

Helps use shell command line without need to remeber commands or spend time searching Google and stackoverflow. Demo below.

Website: [https://heycli.com](https://heycli.com)

## how to install

1. Go to your terminal and download the sh file from this repo 

```
curl -o heycli_client.sh https://raw.githubusercontent.com/HeyCLI/heyCLI/main/heycli_client.sh
```

2. Source the script, type in your terminal:  

```
source heycli_client.sh
```

3. Go grab an API token here: https://signup.heycli.com/

4. Finally, set the HEYCLI_API_KEY environment variable in your terminal: 

```
export HEYCLI_API_KEY=<token>
```
5. (Optional) setup context for HeyCLI for improved answers and suggestions. Type:

```
hey setup
```

That's it, you should be able to use the "hey" command!

## IMPORTANT 
The setup command will upload your command history as is. We will add tooling to anonymise and clean the history from potential sensitive data in the future

## Support

Encounter any issues? please open an issue or email me at hadiazzouni@heycli.com

Also, for timely updates, please follow [@hadiazouni](https://twitter.com/hadiazouni) on Twitter 


## Demo & use cases

![alt text](https://github.com/HeyCLI/heyCLI_client/blob/main/assets/demo_heycli.gif)

In addition to simple command suggestions, you can do:

1.  In-terminal debugging of python, nodejs, kubectl, gcloud, aws and many other command errors. When you get an error, just type: hey debug the error above (or something like that, be creative!) 

Example:
![alt text](https://github.com/HeyCLI/heyCLI_client/blob/main/assets/debug.png)

To activate this feature, you need to update your heycli_client.sh file. Get the new one from https://github.com/HeyCLI/heyCLI_client

To add a specific command to be debugged, all you need to do is add the command at the end of the heycli_client.sh file (don't forget to source it afterwards!):

![alt text](https://github.com/HeyCLI/heyCLI_client/blob/main/assets/add_command.png)

2. we attached HeyCLI to some commands so you can type "yes" to execute them. 

Example:
![alt text](https://github.com/HeyCLI/heyCLI_client/blob/main/assets/execute.png)

## License
  
   copyright © 2023 HeyCLI open source project

   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
   SOFTWARE.
