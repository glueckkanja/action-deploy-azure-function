# action-deploy-azure-function

This reusable action simplifies automated azure function deployments especially if they are using NuGet packages.

## Deploy Azure Function

Builds and publishes a .NET project, logs in to Azure with OpenID Connect (OIDC), and deploys the published output to an Azure Function App.

### Calling the action

```yaml
# action.yml in a consumer repository
name: Deploy Azure Function

on:
  push:
    branches:
      - main

jobs:
  example-workflow-run:
    runs-on: ubuntu-latest
    permissions:
      id-token: write
      contents: read
      packages: read
    environment: production
    steps:
      - name: Run Example of Workflow
        uses: glueckkanja/action-deploy-azure-function@sha-hash # v1.2.3
        with:
          dotnet_version: "10.x" # required: version of .NET SDK to use
          tenant_id: "00000000-0000-0000-0000-000000000000" # required: of the tenant id
          subscription_id: "00000000-0000-0000-0000-000000000000" # required: of the subscription id
          client_id: "00000000-0000-0000-0000-000000000000" # required: of the client id of the specific function
          function_app_name: "my-function-app" # required: name of the function app
          environment: "production" # optional: deployment environment (e.g., 'staging', 'production')
          funcignore: false # optional: respect the .funcignore file during deployment
          nuget_source_name: "nuget-src" # optional: if you have configured a nuget.config
          github_pat: ${{ secrets.GITHUB_TOKEN }} # optional: required when nuget_source_name is set
          project_path: "./src/MyFunction/MyFunction.csproj" # required: relative path to the .csproj file to build and publish
```

### Permissions

- `id-token: write` – required by Azure Login for OpenID Connect authentication.
- `contents: read` – required by the checkout step.
- `packages: read` – required when restoring packages from GitHub Packages.

### Inputs

- `dotnet_version` _(string, required)_ – Version of .NET SDK to use.
- `tenant_id` _(string, required)_ – Azure Tenant ID.
- `subscription_id` _(string, required)_ – Azure Subscription ID.
- `client_id` _(string, required)_ – Azure Client ID used for OIDC login.
- `function_app_name` _(string, required)_ – Name of the Azure Function App to deploy.
- `environment` _(string, optional)_ – Deployment environment (e.g., 'staging', 'production')
- `project_path` _(string, required)_ – Relative path to the `.csproj` file to build and publish.
- `funcignore` _(string, optional)_ – Whether to respect `.funcignore`. Defaults to `false`.
- `nuget_source_name` _(string, optional)_ – NuGet package source name. Defaults to an empty value.
- `github_pat` _(string, optional)_ – GitHub Personal Access Token used for NuGet authentication when `nuget_source_name` is set. **Never use this in clear text** - Create a repository secret variable for this.

### Outputs

This action has no outputs.
