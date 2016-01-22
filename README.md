# bitcoin-bench

![Alt text](http://i.imgur.com/wkuOOLf.png "btc-bench.bash")

This script allows you to time the process of syncing to the blockchain when launching a full node.  It records the blockcount every N seconds in a log file.

Someone told me using the default bitcoind debug.log may slow down the test. This script uses `bitcoin-cli getblockcount` and unix tools to create the log file. It writes a neat log file when you launch bitcoind with the script.  

## Use

Download a bitcoin-core release and change into the directory `bitcoin-0.XY.0/bin`.  Run bench.bash from that location as shown. The logfile will be created in the same directory.

## Defaults

* default timeout = 2 seocnds. `getblockcount` will be run every 2 seconds unless you change the  `nSeconds` parameter.
* default `dbCacheMbytes=6000` so the command that starts bitcoind is `bitcoind -dbcache=6000 &`, which means 6GB of RAM.  If you have less memory, reduce the parameter.

There are some printing errors in the logfile meta section, but the timestamps and and blockcounts are accurate.

## Issues
* The script does not exit gracefully.  There is no test for sync completion so it must be halted manually.  
* The script does not compute final statistics when halting.  
