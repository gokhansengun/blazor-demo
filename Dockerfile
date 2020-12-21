FROM mcr.microsoft.com/dotnet/sdk:5.0-focal AS builder

WORKDIR /app

COPY BlazorApp/BlazorApp.csproj BlazorApp/

RUN dotnet restore BlazorApp

COPY . .

RUN dotnet publish -c Release BlazorApp -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:5.0-buster-slim AS runner

WORKDIR /app
COPY --from=builder /app/publish /app

EXPOSE 80

CMD [ "dotnet", "BlazorApp.dll"]
