#!/usr/bin/env bash

startTime=$(date +%Y-%d-%mT%T%z)
startTimeSeconds=$(date +%s)
logFile="bitcoin_bench_""$startTimeSeconds"".log"
# this makes an rpc call every 2 seconds; increase for slower systems
nSeconds=2 
currentBlockHeight=394395
# 6 GB default dbcache size; descrease for older systems with less memory
dbCacheMbytes=6000 
bitcoindCmd="./bitcoind -dbcache=$dbCacheMbytes &"

x='echo -e'
$x "$(uname -a)" >> $logFile
$x "Writing to file: ./$logfile"
a=$startTime; b=$startTimeSeconds; c=$logFile; d=$nSeconds; e=$currentBlockHeight; f=$dbCacheMbytes; g=$bitcoindCmd;
$x "Time:\t\t$a\nUnix Start Time:\t\t$b\nLog File Name:\t\t$c\nRecording:\t\t$g\ntimeout:\t\t$d\nCurrentBlockheight\t\t$e\ndbcahce:\t\t$f MB\n" >> $logFile

# warns users not to proceed with their wallets in the data directory
if [[ -a "$HOME/.bitcoin" ]]; then
	$x "\n\n################\n#\n#\tERROR:\n#\t>>\t$HOME/.bitcoin exists.  This directory may store your wallet data. \n#\t>>\tMake a backup of wallet.dat, remove $HOME/.bitcoin, and try again.\n#\t>>\tAborting now.\n#\n################"
	exit 1;
fi

$x "START TIME:\t$startTime" >> "$logFile"
message="Executing\t$bitcoindCmd\tevery $nSeconds seconds"
$x $message >> $logFile;
$x $message

./bitcoind -dbcache=$dbCacheMbytes &

while :
  do
    $x "blockcount: $(./bitcoin-cli getblockcount)\tTime: $(date +%Y-%m-%dT%T)\tTime Elapsed (sec): $(($(date +%s)-b))\tUnixTime (sec): $(date +%s)"  >> "$logFile"
    sleep "$nSeconds"
done
