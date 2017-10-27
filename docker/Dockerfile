FROM microsoft/dynamics-nav:devpreview-finus AS full
ENV ACCEPT_EULA Y
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]
COPY scripts c:/run/my
RUN .\Run\start.ps1

FROM microsoft/windowsservercore
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]
RUN mkdir c:\build
COPY --from=full c:/ForBuildStage/ c:/build
RUN Expand-Archive -Path (Get-ChildItem -Path c:\build -Filter "al*.zip")[0].FullName -DestinationPath c:\build