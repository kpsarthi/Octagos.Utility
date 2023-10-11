# https://hub.docker.com/_/microsoft-dotnet
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /source

# copy csproj and restore as distinct layers
COPY *.sln .
COPY octagos-utility/*.csproj ./octagos-utility/
RUN dotnet restore

# copy everything else and build app
COPY octagos-utility/. ./octagos-utility/
WORKDIR /source/octagos-utility
RUN dotnet publish -c release -o /app --no-restore

# final stage/image
FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /app
COPY --from=build /app ./
ENTRYPOINT ["dotnet", "octagos-utility.dll"]