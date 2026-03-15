FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src

COPY *.sln .
COPY MyApp/*.csproj ./MyApp/
RUN dotnet restore

COPY . .
RUN dotnet publish MyApp/MyApp.csproj -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:10.0
WORKDIR /app

COPY --from=build /app/publish .

ENTRYPOINT ["dotnet","MyApp.dll"]