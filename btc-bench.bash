#!/usr/bin/env bash

startTime=$(date +%Y-%d-%mT%T%z)
startTimeSeconds=$(date +%s)
logFile="bitcoin_bench_""$startTimeSeconds"".log"

#######################################
#     $nSeconds sets an rpc call      #
#     every 2 seconds; increase       #
#     for slower  systems.            #
#######################################
#     6 GB default dbcache size;      #
#     descrease for older systems     #
#     with less memory	              #
#######################################

nSeconds=2 
currentBlockHeight=394395
dbCacheMbytes=6000 
bitcoindCmd="./bitcoind -dbcache=$dbCacheMbytes &"

e='echo -e'

$e
$e
$e "$(uname -a)" >> $logFile
$e "Writing to file: ./$logfile"
$e
$e

a=$startTime 
b=$startTimeSeconds 
c=$logFile 
d=$nSeconds
e=$currentBlockHeight 
f=$dbCacheMbytes
g=$bitcoindCmd


$e				>>	$logfile
$e "Time:\t\t$a"		>>	$logfile
$e "Unix Start Time:\t\t$b"	>>	$logfile
$e "Log File Name:\t\t$c"	>>	$logfile
$e "Recording:\t\t$g"		>>	$logfile
$e "timeout:\t\t$d"		>>	$logfile
$e "CurrentBlockheight\t\t$e"	>>	$logfile
$e "dbcahce:\t\t$f MB" 		>>	$logFile
$e				>>	$logfile

#######################################
# 	warns users not to proceed    #
# 	with their wallets in the     #
#      	data directory                #
#######################################

if [[ -a "$HOME/.bitcoin" ]]; then
	$e
	$e "\n\n################"
	$e "\tERROR:\t$HOME/.bitcoin exists."
	$e "This directory may store your"
	$e "wallet data. Please make a "
	$e "backup of wallet.dat, remove "
	$e "$HOME/.bitcoin, and try again."
	$e "\n\tAborting now."
	$e "################"
	$e
	exit 1;
fi

$e "START TIME:\t$startTime" >> "$logFile"
message="Executing\t$bitcoindCmd\tevery $nSeconds seconds"
$e $message >> $logFile;
$e $message

./bitcoind -dbcache=$dbCacheMbytes &

while :
  do
    $e "blockcount: $(./bitcoin-cli getblockcount)\tTime: $(date +%Y-%m-%dT%T)\tTime Elapsed (sec): $(($(date +%s)-b))\tUnixTime (sec): $(date +%s)"  >> "$logFile"
    sleep "$nSeconds"
done
