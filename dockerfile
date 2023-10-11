
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /app
#copy .csproj and restore as distinct layer
COPY "octagos-utility.csproj" "octagos-utility.csproj"
RUN dotnet restore "octagos-utility.csproj"
#copy everything else build
COPY . .
RUN dotnet build "octagos-utility.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "octagos-utility.csproj" -c Release -o /app/publish /p:UseAppHost=false

#build a runtime image
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT [ "dotnet", "octagos-utility.dll" ]