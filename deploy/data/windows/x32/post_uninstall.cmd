set AmneziaPath=%~dp0
echo %AmneziaPath%

"%AmneziaPath%\VPNNaruzhu.exe" -c
timeout /t 1
sc stop VPNNaruzhu-service
sc delete VPNNaruzhu-service
sc stop AmneziaWGTunnel$VPNNaruzhu
sc delete AmneziaWGTunnel$VPNNaruzhu
taskkill /IM "VPNNaruzhu-service.exe" /F
taskkill /IM "VPNNaruzhu.exe" /F
exit /b 0
