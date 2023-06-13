

while ($true) {

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest -Uri https://docs-test.zenit.ru/default.aspx

$JSONInfo =  $ie.Content
#$JSONInfo = ConvertTo-Xml -InputObject  $JSONInfo.result

$iewall= Invoke-WebRequest -Uri'http://docs-test.zenit.ru/_layouts/15/DT.Orgstructure/OrgstructurePage.aspx' -Method Get -ContentType "text/plain; charset=utf-8"
$JSONInfoWall = $iewall
$JSONInfoWall

sleep 100

}