mkdir c:\result
Write-Output "running docker run -v c:\result:c:\result arssolvendi.azurecr.io/dynamics-nav:devpreview-finus-build c:\projects\$env:APPVEYOR_PROJECT_NAME\compile.bat"
docker run -v c:\result:c:\result arssolvendi.azurecr.io/dynamics-nav:devpreview-finus-build c:\projects\$env:APPVEYOR_PROJECT_NAME\compile.bat