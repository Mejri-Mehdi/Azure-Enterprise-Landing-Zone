# Management Group Hierarchy

## Current State

```

Tenant Root Group
└── mg-nexgen-root
├── mg-nexgen-prod
├── mg-nexgen-nonprod
└── mg-nexgen-sandbox

```

## Why This Structure?
- **mg-nexgen-root** – Top-level container for all NexGen subscriptions. Policies applied here cascade to all environments.
- **mg-nexgen-prod** – Production workloads. Strictest policies, resource locks, and budget alerts live here.
- **mg-nexgen-nonprod** – Development, testing, staging. Relaxed policies but still governed.
- **mg-nexgen-sandbox** – Experimentation and learning. Separated to prevent accidental production impact.

## What’s Next
- Apply Azure Policies at each level (e.g., required tags, allowed regions).
- Assign custom RBAC roles.

## Screenshots

---
![alt text](<Screenshot 2026-08-02 140014.png>)
---
![alt text](<Screenshot 2026-08-02 140326.png>)
---
![alt text](<Screenshot 2026-08-02 140329.png>)
---
