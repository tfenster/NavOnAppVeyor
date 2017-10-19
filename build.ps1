mkdir c:\result
$command = "c:\projects\$env:APPVEYOR_PROJECT_NAME\compile.bat"
Write-Output "running docker run -v c:\result:c:\result arssolvendi.azurecr.io/dynamics-nav:devpreview-finus-build $command"
docker run -v c:\result:c:\result arssolvendi.azurecr.io/dynamics-nav:devpreview-finus-build $command