mkdir c:\result | Out-Null
$command = "c:\projects\$env:APPVEYOR_PROJECT_NAME\appveyor\compile.bat"
Write-Output "run docker NAV build image"
docker run -v c:\result:c:\result -v c:\projects:c:\projects -e APPVEYOR_PROJECT_NAME=$env:APPVEYOR_PROJECT_NAME arssolvendi.azurecr.io/dynamics-nav:devpreview-finus-build $command
