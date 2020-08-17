Azure Devops Agent
==================
# Prerequisites
- Docker installed

# Usage:
## Build the image
```bash
docker build -t thanhtunguet/azure-devops-agent:latest .
```

## Start image
```bash
docker-compose up -d
```

## Environment variables
```env
AZP_URL=
AZP_TOKEN=
AZP_AGENT_NAME=
AZP_POOL=
AZP_WORK=_work
```

&copy; 2020 thanhtunguet <ht@thanhtunguet.info>
