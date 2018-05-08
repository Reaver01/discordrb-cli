# discrordrb-cli 

## Commands 
- .c1 <channel_id>    Changes channel 1
- .c2 <channel_id>    Changes channel 2
- .c3 <channel_id>    Changes channel 3
- .h1                 Shows history of channel 1
- .h2                 Shows history of channel 2
- .h3                 Shows history of channel 3
- .12                 Swaps current channel 1 with channel 2
- .23                 Swaps current channel 2 with channel 3
- .13                 Swaps current channel 1 with channel 3
- .1r                 Changes channel 1 to channel with last session mention/dm
- .2r                 Changes channel 2 to channel with last session mention/dm
- .3r                 Changes channel 3 to channel with last session mention/dm
- .re <message>       Replies to last mention/dm
- .r2 <message>       Sends a message to channel 2
- .r3 <message>       Sends a message to channel 3
- .ls                 Lists all connected servers and IDs
- .lc <server_id>     Lists channel IDs of current server or of specified server if server_id is supplied
- .e                  Evaluates code
- .exit               Exits the program

## Setup 

copy dotenv.sample to .env 
put your token in TOKEN_STRING your user id in OWNER_ID and the channels you want it to start with in CHANNEL1, CHANNEL2, and CHANNEL3 
run bundle install 
start client with ruby run.rb 
