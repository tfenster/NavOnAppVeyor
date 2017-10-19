Write-Host "set up build environment"

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

$pair = "${username}:${password}"
$bytes = [System.Text.Encoding]::ASCII.GetBytes($pair)
$base64 = [System.Convert]::ToBase64String($bytes)
$basicAuthValue = "Basic $base64"
$headers = @{ Authorization = $basicAuthValue }

Write-Host "Create folder"
mkdir -Path "c:\ForBuildStage"

Write-Host "Download symbols"
$hostname = hostname
$usURL = 'https://'+$hostname+':7049/NAV/dev/packages?publisher=Microsoft&appName=US&versionText=11.0.0.0'
$sysURL = 'https://'+$hostname+':7049/NAV/dev/packages?publisher=Microsoft&appName=System&versionText=11.0.0.0'
Invoke-RestMethod -Method Get -Uri ($usURL) -Headers $headers -OutFile 'c:\ForBuildStage\US.app'
Invoke-RestMethod -Method Get -Uri ($sysURL) -Headers $headers -OutFile 'c:\ForBuildStage\System.app'

Write-Host "Copy vsix as zip"
$vsixFile = (Get-ChildItem -Path C:\inetpub\wwwroot\http -Filter "al*.vsix")[0]
Rename-Item $vsixFile.FullName -NewName ($vsixFile.Name+'.zip')
Copy-Item -Path ($vsixFile.FullName+'.zip') C:\ForBuildStage