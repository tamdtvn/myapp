# =========================

# Stage 1 — Build

# =========================

FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src

# copy solution

COPY *.sln .

# copy project files

COPY src/ ./src/

# restore dependencies

RUN dotnet restore

# build project

RUN dotnet build -c Release --no-restore

# publish app

RUN dotnet publish -c Release -o /app/publish --no-build

# =========================

# Stage 2 — Runtime

# =========================

FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS runtime
WORKDIR /app

# copy published output

COPY --from=build /app/publish .

# expose port

EXPOSE 80

# run application

ENTRYPOINT ["dotnet", "MyApp.dll"]