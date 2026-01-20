🛠 Modular Architecture & Dependency Management

I utilized a Modular Bicep approach to separate concerns between the Core Network (Hub) and Application Workloads (Spoke).

Orchestration: main.bicep manages the lifecycle and ensures the Hub is fully provisioned before Spoke peering begins.

Data Flow: Used Bicep Outputs to pass Resource IDs between modules, ensuring a programmatic link rather than hardcoded strings.