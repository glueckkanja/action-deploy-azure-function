$ErrorActionPreference = 'Stop'

if ($env:NUGET_SOURCE_NAME) {
    if (-not $env:NUGET_PASSWORD) {
        throw "NUGET_PASSWORD is required when NUGET_SOURCE_NAME is set. Please provide a GitHub Personal Access Token with appropriate permissions."
    }
    $credentials = "Username=$($env:NUGET_USERNAME);Password=$($env:NUGET_PASSWORD)"
    Set-Item -Path "Env:NuGetPackageSourceCredentials_$($env:NUGET_SOURCE_NAME)" -Value $credentials
}
dotnet publish "$env:PROJECT_PATH" --configuration Release --output ./publish
