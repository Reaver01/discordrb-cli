## discrordrb-cli 

# Commands
- .cc <channel_id>    Changes channel
- .cm <channel_id>    Changes monitored channel
- .hi                 Shows history of current channel
- .hm                 Shows history of monitored channel
- .sw                 Swaps current channel with monitored channel
- .mm                 Changes monitored channel to channel with last session mention/dm
- .re <message>       Replies to last mention/dm
- .rm <message>       Sends a message to last
- .ls                 Lists all connected servers and IDs
- .lc <server_id>     Lists channel IDs of current server or of specified server if server_id is supplied
- .e                  Evaluates code
- .exit               Exits the program

# Setup  

copy dotenv.sample to .env
put your token in TOKEN_STRING your user id in OWNER_ID and the channels you want it to start with in CHANNEL1 and CHANNEL2
run bundle install
start client with ruby run.rb
