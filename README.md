Azure Devops Agent
==================

# Usage:

## Build the image

```bash
docker build -t thanhtunguet/azure-devops-agent:latest
```

## Start image

```bash
docker-compose up -d
```

## Environment variables

```env
AZP_URL=https://devops.rangdong2020.ml # Azure Devops Server URL
AZP_TOKEN= # Azure Devops Personal Access Token
AZP_AGENT_NAME=Dotnet Agent # Agent Name
AZP_POOL=Dev # Agent Pool
AZP_WORK=_work
AZP_TARGET_SERVER=dev.rangdong2020.ml # The target server which agent will ssh to
```
