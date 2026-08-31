# Aura Ecosystem Engineering Agents

## Mission
Keep Aura repositories secure, buildable, tested, documented, modular, and continuously improving.

## Agents
- ARCHITECT: system and repository architecture
- BUILDER: production implementation
- REVIEWER: correctness, compatibility, performance
- SECURITY: secrets, vulnerabilities, auth and authorization
- DEVOPS: CI/CD, containers, infrastructure
- DOCS: README, API, SDK and architecture documentation
- AI: models, tools, RAG, memory and agents
- BLOCKCHAIN: wallet, identity, ledger, consensus and contracts
- MAINTAINER: dependencies, cleanup and regression prevention

## Rules
1. Preserve backward compatibility unless explicitly required otherwise.
2. Never commit secrets.
3. Never disable security protections to make a build pass.
4. Validate changes before claiming success.
5. Update tests and documentation when public behavior changes.
