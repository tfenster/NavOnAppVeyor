Add-Type @"
using System;
using System.Net;
using System.Net.Security;
using System.Security.Cryptography.X509Certificates;
public class ServerCertificateValidationCallback
{
    public static void Ignore()
    {
        ServicePointManager.ServerCertificateValidationCallback += 
            delegate
            (
                Object obj, 
                X509Certificate certificate, 
                X509Chain chain, 
                SslPolicyErrors errors
            )
            {
                return true;
            };
    }
}
"@

[ServerCertificateValidationCallback]::Ignore();


& ./navcontainerhelper/NavContainerHelper.ps1
Wait-NavContainerReady devpreview
$vsix = docker exec devpreview powershell '(Get-Item ''C:\run\*.visx'').Name'
Invoke-WebRequest -Uri "http://devpreview:8080/$vsix" -OutFile "$vsix.zip"
Expand-Archive -Path "$vsix.zip"

$user = 'admin'
$pass = 'abc123ABC.'
$pair = "${user}:${pass}"
$bytes = [System.Text.Encoding]::ASCII.GetBytes($pair)
$base64 = [System.Convert]::ToBase64String($bytes)
$basicAuthValue = "Basic $base64"
$headers = @{ Authorization = $basicAuthValue }

New-Item -ItemType Directory -Name "alpackages"
Invoke-RestMethod -Method Get -Uri 'https://devpreview:7049/NAV/dev/packages?publisher=Microsoft&appName=US&versionText=11.0.0.0' -Headers $headers -OutFile 'alpackages\US.app'
Invoke-RestMethod -Method Get -Uri 'https://devpreview:7049/NAV/dev/packages?publisher=Microsoft&appName=System&versionText=11.0.0.0' -Headers $headers -OutFile 'alpackages\System.app'