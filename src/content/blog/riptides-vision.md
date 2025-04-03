---
draft: false
title: "The Riptides Vision: Identity-First Infrastructure"
snippet: ""
image:
  {
    src: "https://images.unsplash.com/photo-1629904853893-c2c8981a1dc5?fit=crop&w=600&h=335",
    alt: "alt text",
  }
publishDate: "2025-04-03 11:00"
category: "Identity"
author: "Marton Sereg"
tags: [identity, spiffe, AI]
---
  
In modern digital infrastructure, non-human identities have exploded in both number and significance. But what is even a non-human identity? The terminology itself has sparked debates among people in the space, and for good reason. Even though we like to throw the term identity around, a non-human identity is usually just a credential for an application, workload, or device, allowing it to prove who it is when connecting to other systems. Today, these machine credentials far outnumber human users in most organizations. **Organizations now report machine-to-machine credentials outnumber human credentials by double-digit factors.**

**Cloud-native computing has multiplied non-human identities** in general. Applications are broken into microservices, deployed across hybrid and multi-cloud environments, and integrated with third-party APIs. The rise of autonomous AI agents is accelerating this shift even further. And the trend is clear: AI agents will operate with minimal oversight, accessing sensitive data and interact with a range of services across networks.

  
Securing these credentials will no longer be optional - each service account, token, or certificate is a potential entry point for attackers if compromised. The stakes are high: when non-human identities fail, we see everything from sensitive data exposure to chaotic outages. Clearly, the **importance of non-human identity** is no longer academic – it is a **central security concern** in the AI and cloud-native era.

This secret sprawl, coupled with the rise of autonomous software, demands a holistic solution: a unified identity fabric that can serve as the foundation for secure, scalable, machine-to-machine trust.  
  
## The Fragmentation Problem: Keys, Tokens, and Secrets Everywhere

Today, machine identity is fragmented and inconsistent. Most organizations lack a unified approach, instead relying on a patchwork of secrets and credentials spread across different systems. Consider a typical scenario: an application uses a cloud API key for one service, a database password for another, a TLS certificate for in-datacenter calls, and perhaps an OAuth token for a SaaS integration. Each credential is stored and issued in a different place: some in code or YAML configs, others in a secrets manager, others manually configured. Each system has its own method for proving identity, with little cohesion or governance.

This **scattered approach to key management** creates silos and complexity. Security teams struggle to maintain visibility and consistent policies when **credentials are managed by different owners and tools in isolation.** They have to navigate:


- **Secret Sprawl and Exposure:** With countless API keys, tokens, and certificates floating around, the attack surface expands, increasing the chance that one leaks or is stolen.
- **Operational Burden:** Managing and rotating all these disparate keys is burdensome and error-prone. Most organizations face frequent surprises like expired certs causing outages or forgotten tokens with excessive access.
- **Inconsistent Trust:** Each system might use a different trust model. This inconsistency makes it hard to **enforce any unified security policy** or to enable end-to-end encryption universally.
- **Over-Privileged Access:** Ad-hoc machine credentials often violate least privilege. For example, static tokens are commonly set with broad permissions and never expire.

Our current approach leaves us juggling a jungle of secrets without a central source of truth. **Machine-to-machine communications remain secured in a piecemeal fashion**, if at all. As workloads become more dynamic and AI agents more capable, this model doesn’t scale. We need an infrastructure-native way to establish trust that doesn’t rely on manually managing secrets.  
  
## A Unified Identity Solution
  
The Riptides approach is simple but powerful: assign each non-human actor a cryptographically verifiable identity, issued and rotated automatically, recognized across your environment. In practice, this means assigning each workload a X.509 certificate, or signed token that serves as its **identity “badge.”** This digital identity can then be trusted by any other workload or agent to verify who it’s talking to. Crucially, the issuance and rotation of these identities are handled automatically by Riptides, not by developers baking keys into code.

  
Think of it as an **“identity fabric”** woven through the infrastructure: rather than manually stitching together credentials between every pair of services, each service is born with an identity that can be universally verified. This unified approach yields several technical benefits:  
  
- Transparent Mutual Authentication — When every workload presents a verifiable identity, we can enforce mutual TLS authentication behind the scenes.  
- Secrets-Free Workflows — A unified identity system avoids the need for hard-coded secrets. Long-lived API keys and passwords can be phased out in favor of **short-lived cryptographic credentials** issued on the fly. We can issue certificates or tokens that are **ephemeral and automatically rotated.**  
- Unified Trust Anchors — Riptides leverages trusted Certificate Authorities (CAs) to issue identities for all services. This provides a single chain of trust. Instead of each team rolling their own keys, they all rely on the common identity service. It also enables federation: your domain’s identities can be recognized by a partner or cloud provider, extending trust without sharing raw secrets .  
- Improved Auditability and Governance — When every non-human actor authenticates with a trusted identity, it becomes easier to audit who did what. Policies can be written in terms of identities (“Workload A may talk to Service B”) rather than low-level constructs like IP addresses or ad hoc API keys.  
  
In essence, a unified identity solution **turns network security inside-out**: trust is attached to identities, not network locations, and security follows the workload wherever it runs. This is especially powerful for highly dynamic and scalable environments, - a container spinning up in Kubernetes, an agent calling an external MCP server, or a microservice handling payments can all use the same trusted foundation to authenticate and communicate.  


## From Theory to Practice: SPIFFE, Kernel-Level Integration, and Beyond
  
To bring this vision to life, we lean on standards like SPIFFE, which defines a uniform way to issue and verify workload identities across diverse environments. At its core, SPIFFE defines a format for *workload identities* (called SPIFFE IDs) and a method for issuing cryptographic identity credentials (like X.509 certificates or JWTs) to any workload that needs one.  
  
But we go further.  
  
At Riptides, we envision the identity fabric extending into the Linux kernel itself, enabling identity enforcement and propagation at the OS level. Through mechanisms like our Kernel driver, or eBPF, we can:  
  
- Attach verified identities directly to processes. It allows for fine-grained access control, where malicious processes can't hijack the identity of another workload, even if it runs on the same node, or in the same pod.  
- Enforce policies at the syscall level, for example, allowing only processes with verified identities to open outbound sockets, or initiate inter-process communication.  
- Automatically handle mutual TLS using the certificates proving machine identity at the socket layer, without developers needing to manage keys in user space.  
  
This makes identity enforcement fully transparent for both application developers and the network stack. No more TLS boilerplate. No more key management in user space. Just cryptographically backed trust, enforced in Kernel-space. By treating identity as a first-class primitive of the operating system, we make it universal, scalable, and invisible.  
  
## Summary
  
A strong identity fabric unlocks secure, scalable, and simple infrastructure. When every workload, microservice, or AI agent is born with a verifiable identity, we can **dramatically simplify network security**: every connection is mutually authenticated and authorized based on identity, not on brittle network trusts or shared secrets.  By adopting unified, cryptographic identities for workloads and agents, we can **secure communications across AI agents, data center services, and third-party integrations in a consistent, and transparent way.** This approach paves the way for true zero-trust connectivity at scale.  
  
Riptides is building the infrastructure that makes this possible. Because in a world where machines talk to machines, identity is everything.
