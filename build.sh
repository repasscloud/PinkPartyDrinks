#!/usr/bin/env bash

dotnet publish PinkPartyDrinks.csproj -c Release -o release --nologo
sed -i 's/<base href="\/" \/>/<base href="\/PinkPartyDrinks\/" \/>/g' release/wwwroot/index.html
cp release/wwwroot/index.html release/wwwroot/404.html
touch release/wwwroot/.nojekyll
zip -r ./wwwroot.zip ./release/wwwroot/*