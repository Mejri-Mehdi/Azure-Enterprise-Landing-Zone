# How to Request an Environment

## Option 1: GitHub Issue (Recommended)
1. Go to Issues → New Issue → Request Environment
2. Fill in the template
3. The platform team will review and trigger the deployment

## Option 2: Manual Trigger (Platform Team Only)
1. Go to Actions → Provision Environment
2. Select environment (dev/test/prod)
3. Click Run workflow
4. For prod: requires approval from platform lead

## What You Get
- Resource Group: `rg-nexgen-{env}`
- App Service: `app-nexgen-{env}.azurewebsites.net`
- SQL Server: `sql-nexgen-{env}.database.windows.net`
- Storage Account: `stnexgen{env}001`

## Rules
- All resources are tagged automatically
- No public IPs on VMs
- All data traffic stays inside VNet
- Budget alert at $50 (dev) / $100 (test)
- Auto-shutdown tag on dev resources  