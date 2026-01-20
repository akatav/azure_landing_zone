## 📌 Project Intent
This repository represents a focused, honest implementation of Azure infrastructure fundamentals. I developed this project to bridge the gap between theoretical knowledge and the practical requirements of a **Platform Engineer** role. 

The goal was to build a "Secure-by-Default" environment using **Bicep** that mirrors enterprise standards for networking and automation.

---

🛠 Modular Architecture & Dependency Management

I utilized a Modular Bicep approach to separate concerns between the Core Network (Hub) and Application Workloads (Spoke).

Orchestration: main.bicep manages the lifecycle and ensures the Hub is fully provisioned before Spoke peering begins.

Data Flow: Used Bicep Outputs to pass Resource IDs between modules, ensuring a programmatic link rather than hardcoded strings.

"Features":

Centralized Observability: Log Analytics Workspace with Diagnostic Settings integration.

Elasticity: Implemented Auto-scale rules for PaaS workloads to handle traffic spikes.

## 🏗️ Architecture Diagram
This diagram illustrates the resource relationships and traffic flow defined in the Bicep modules.

```mermaid
graph TD
    subgraph "Azure Subscription"
        direction TB
        Hub[Hub VNet: Central Services]
        Spoke[Spoke VNet: App Workload]
        KV[Key Vault: Secrets]
        App[App Service: Web App]
        Log[Log Analytics Workspace]

        Hub <--> |VNet Peering| Spoke
        Spoke -.-> |VNet Integration| App
        App -.-> |Managed Identity| KV
        KV -.-> |Diagnostic Logs| Log
        App -.-> |Metrics| Log
    end