
# Функция пишет сообщения в лог-файл и выводит на экран.
function Get-Log ($message,$logfile){	
	$dt=Get-Date -Format "dd.MM.yyyy HH:mm:ss"	
	$msg=$dt + "`t" + $message #формат: 01.01.2001 01:01:01 [tab] Сообщение
	Out-File -FilePath $logfile -InputObject $msg -Append -encoding default
	
	}

cls
#иНИЦИАЛИЗАЦИЯ Proxy
netsh winhttp import proxy source=ie
$Wcl = new-object System.Net.WebClient
$Wcl.Headers.Add(“user-agent”, “PowerShell Script”)
$Wcl.Proxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials
#
    $console=$Host.UI.RawUI.WindowSize
    $console.Height = 4
    $console.width = 40
    $Host.UI.RawUI.WindowSize = $console
#$Host.UI.RawUI.WindowSize.Height = 40
    $console=$Host.UI.RawUI.BufferSize
    $console.Height = 4
    $console.width = 40
    $Host.UI.RawUI.BufferSize = $console
    $Host.UI.RawUI.WindowTitle = "Мониторинг"

[string]$InfoWorkers = ''
[array]$DataWorker =$null

#0 = Scrypt;1 = SHA256;2 = ScryptNf;3 = X11;4 = X13;5 = Keccak;6 = X15;7 = Nist5;8 = NeoScrypt;9 = Lyra2RE;10 = WhirlpoolX;11 = Qubit;12 = Quark;
#13 = Axiom;14 = Lyra2REv2;15 = ScryptJaneNf16;16 = Blake256r8;17 = Blake256r14;18 = Blake256r8vnl;19 = Hodl;20 = DaggerHashimoto
#21 = Decred;22 = CryptoNight;23 = Lbry;24 = Equihash;25 = Pascal;26 = X11Gost;27 = Sia;28 = Blake2s;29 = Skunk

# 0 = standard order
# 1 = fixed order

while ($true) {
[string]$DATELOG = Get-Date -Format "yyyy.MM.dd"  
$logfile = 'C:\tools\cmd\LOG\'+ 'MinigMon_' + $DATELOG + '.log'

$ie = Invoke-WebRequest -Uri 'https://api..com/api?method=stats.provider.workers&addr=LyrT2MKLrqiZPQa' -Method Get -ContentType "text/plain; charset=utf-8"
$JSONInfo = ConvertFrom-Json -InputObject $ie.Content
#$JSONInfo = ConvertTo-Xml -InputObject  $JSONInfo.result

$iewall=Invoke-WebRequest -Uri 'https://api..com/api?method=stats.provider&addr=kYLyrT2MKLrqiZPQa' -Method Get -ContentType "text/plain; charset=utf-8"
$JSONInfoWall = ConvertFrom-Json -InputObject $iewall

# https://api.nicehash.com/api?method=multialgo.info

# https://api.nicehash.com/api?method=orders.get&location=0&algo=3

cls

#$JSONInfoWall.result.stats|select *|FL
#$JSONInfoWall.result.payments|select *|FL

#Write-Host 'Кошелек: ' $JSONInfo.result.addr -ForegroundColor Green
$message = 'Хэшрейт: ' + $JSONInfo.result.workers.a + ' Sol/s'
#Write-Host $message -ForegroundColor Green
[string]$workersStatus = $JSONInfo.result.workers
IF ($workersStatus -eq ''){
#Майнинг не выполняется
#Перезапуск C:\coin\miner\nicehash.bat
[string]$procc = (Get-Process miner -ErrorAction SilentlyContinue).ProcessName

    If ($procc -eq 'miner'){
    [int]$idProcc = (Get-Process miner).Id
    Stop-Process -Id $idProcc 
    Write-Host $message -ForegroundColor Red
    sleep 150
    }
} 
Get-Log $message $logfile
Write-Host  $JSONInfo.result.workers -ForegroundColor Green
#$InfoWorkers = $JSONInfo.result.workers|Select *
#$InfoWorkers.split("`n") 
#[array]$DataWorker = $JSONInfo.result.workers.SyncRoot -split("`n") 
#$DataWorker[0]-split("`n") 
#[string]$procc = (Get-Process miner -ErrorAction SilentlyContinue).ProcessName
#$procc
sleep 30 #обновление каждые 15 секунд
}
#$JSONInfo.result.algo
#https://api.nicehash.com/api?method=simplemultialgo.info #Инфа прибыльности

#https://api.nicehash.com/api?method=methodname&parameter1=parameter1value&parameter2=parameter2value