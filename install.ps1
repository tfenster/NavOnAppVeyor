Write-Host "download image"
docker login arssolvendi.azurecr.io -u="$env:DOCKER_USER" -p="$env:DOCKER_PASS"
docker pull arssolvendi.azurecr.io/dynamics-nav:devpreview-finus-build