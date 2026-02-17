# GitOps Infrastructure

This repository contains the declarative infrastructure and application state
for my Kubernetes clusters, managed via [Flux CD](https://fluxcd.io/) and
[Kustomize](https://kustomize.io/).

## Prerequisites

This project uses [Nix](https://nixos.org/) to manage development dependencies
to ensure a consistent environment.

1. **Install Nix:**

You can find the instructions for your OS here:
[Install Nix the package manager](https://nixos.org/download/)

2. **Enable Direnv (Recommended):** If you have `direnv` installed, simply run:

```bash
direnv allow
```

This will automatically load `kubectl`, `fluxcd`, `opentofu`, and other tools
into your shell.

## Repository Structure

- **`kubernetes/apps/`**: Base configurations for applications (e.g., Zitadel).
- **`kubernetes/infra/`**: Base configurations for system infrastructure (e.g.,
  Traefik, Cert-Manager).
- **`kubernetes/clusters/`**: Per-cluster configuration entry points.

## Clusters

### 1. Apollo

The primary cluster.

**Deployment Structure:**

- **Flux System**: Manages the synchronization.
- **Infra Layer** (Defined in `clusters/apollo/infra`):
- **Traefik**: Ingress Controller (LoadBalancer).
- **Cert-Manager**: SSL management (Let's Encrypt Production + Cloudflare DNS
  Solver).
- **External DNS**: Syncs Ingress/Service IPs to Cloudflare DNS (`*.trai.ch`).
- **External Secrets**: Syncs secrets from 1Password.
- **CNPG Operator**: CloudNativePG for managing Postgres clusters.

- **App Layer** (Defined in `clusters/apollo/apps`):
- **Zitadel**: Identity Provider (HA setup with CNPG backend).

---

## Bootstrap & Manual Steps

While Flux automates deployment, the initial bootstrapping and secret injection
must be done manually. This example is for the apollo cluster - commands may
vary for others.

### 1. Connect Secrets (1Password)

This infrastructure uses **External Secrets** with the **1Password** provider.
Flux will deploy the operator, but you must manually supply the authentication
token so the operator can talk to 1Password.

1. **Create the 1Password Connect Token:**

- _Note: This is required for `cluster-secret-store.yaml` to function._

```bash
kubectl create namespace flux-system
kubectl -n flux-system create secret generic onepassword-secret \
  --from-literal=token=$(op read "op://apollo/onepassword-service-acoount/credential")
```

### 2. Bootstrap Flux

Initialize Flux on the cluster and link it to this repository.

```bash
flux bootstrap git \
  --url=ssh://git@github.com/drlucaa/gitops-infra \
  --branch=main \
  --path=kubernetes/clusters/apollo \
```

### 3. Verification

Once bootstrapped and the secret is created, check the status of the Flux
Kustomizations:

```bash
flux get kustomizations --watch
```

Ensure `infra` becomes `Ready`, followed by `apps`.

---

## Roadmap

### Security & Access Control

- [ ] **RBAC**: Implement Role-Based Access Control.
- Integrate with **Zitadel** (OIDC) for user authentication.
- Define granular `ClusterRole` and `RoleBinding` resources for different user
  groups (e.g., Admins, Developers, Viewers).

### Networking & VPN

- [ ] **Netbird**: Deploy the full management stack.
- Management Dashboard
- Management API
- Signal Server
- Relay Server
- Netbird Operator

### Observability Stack

- [ ] **Vector** (by Datadog): For log and metric aggregation.
- [ ] **ClickHouse**: For high-performance storage of logs/metrics.
- [ ] **Prometheus**: For metrics collection.
- [ ] **Grafana**: For visualization and dashboards.

### Cluster Management

- [ ] **Headlamp**: Kubernetes Web UI.
- [ ] Configure **FluxCD Plugin** for Headlamp to visualize GitOps state.

### Configuration Management

- [ ] **OpenTofu**:
- [ ] Configure **Zitadel** (Realms, Clients, Users).
- [ ] Configure **Netbird** (Setup keys, policies, and routes).
