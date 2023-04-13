FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
COPY [ "PinkPartyDrinks.csproj", "./" ]
RUN dotnet restore "PinkPartyDrinks.csproj"
COPY . ./
RUN dotnet build "PinkPartyDrinks.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "PinkPartyDrinks.csproj" -c Release -o /app/publish

FROM nginx:alpine AS final
WORKDIR /usr/share/nginx/html
COPY --from=publish /app/publish/wwwroot .
COPY [ "nginx.conf", "/etc/nginx/nginx.conf" ]
EXPOSE 80