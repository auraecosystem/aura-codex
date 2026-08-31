# Aura Ecosystem Architecture

Aura is organized as interconnected layers:

1. AI — models, agents, memory, RAG and tool execution.
2. Web4 — identity, wallets, storage, ledger and SDKs.
3. Blockchain — AuraChain and compatible networks.
4. Developer Platform — CLI, Workbook, Worksheet and SDKs.
5. Knowledge — Wikixedia and synchronized technical documentation.
6. Infrastructure — CI/CD, containers, deployment and observability.

Repositories remain independently deployable while sharing versioned contracts, packages and engineering standards.
If you mean saving the script.god specification so Codex can use it on every project, the best approach is to save it as a project/global instruction file rather than only keeping it in chat.

For your LMLM repositories, I recommend this structure:

your-project/
├── AGENTS.md
├── script.god
├── docs/
│   └── SCRIPT-GOD.md
└── ...

Use the files for different purposes:

AGENTS.md → tells Codex how to behave in the repository.

script.god → the executable/declarative orchestration specification.

docs/SCRIPT-GOD.md → the detailed human-readable specification.

For the specification I just gave you, save the complete content as:

docs/SCRIPT-GOD.md

Then create a root AGENTS.md that tells Codex to treat it as authoritative:

# LMLM Codex Instructions
This repository uses SCRIPT.GOD as its orchestration language.
The canonical SCRIPT.GOD specification is:
docs/SCRIPT-GOD.md
Before implementing orchestration, agent coordination, model routing,
multi-agent execution, or verification workflows, read and follow
the canonical SCRIPT.GOD specification.
SCRIPT.GOD defines orchestration semantics.
The GOD Protocol defines communication and execution transport.
LMLM Core provides the runtime.
Models and tools are execution capabilities and must remain behind
provider-neutral interfaces whenever practical.
Never replace SCRIPT.GOD semantics with provider-specific behavior
without an explicit architectural reason.
For every task:
1. Inspect the repository.
2. Read relevant architecture documentation.
3. Read docs/SCRIPT-GOD.md when orchestration is involved.
4. Plan the change.
5. Implement it.
6. Test it.
7. Verify runtime behavior.
8. Update documentation when architecture changes.
9. Report exactly what was changed and verified.
Never claim successful execution without verification.
Never expose credentials or secrets.
Never overwrite unrelated user changes.

Then, if you want Codex to use the same rules across ALL your projects, put your universal version in your Codex global instructions as well.

The strongest setup for you is:

                 CODEX
                   │
                   ▼
        Global Codex Instructions
                   │
                   ▼
             Project AGENTS.md
                   │
          ┌────────┴────────┐
          ▼                 ▼
     SCRIPT.GOD        Project Rules
          │
          ▼
    GOD Protocol
          │
          ▼
      LMLM Runtime
          │
     ┌────┼────┐
     ▼    ▼    ▼
    NIM  Cloud Local

If you want an actual script.god file rather than just documentation, save a machine-readable canonical version separately:

script.god

For example:

SCRIPT.GOD VERSION "1.0"
REGISTER LMLM {
    type: orchestrator
}
REGISTER MODEL "nvidia-llama-3.1-70b" {
    provider: nvidia
    runtime: nim
}
REGISTER MODEL "openai-general" {
    provider: openai
}
CAPABILITIES "nvidia-llama-3.1-70b" {
    text
    reasoning
    instruction-following
}
TASK example {
    CONTEXT {
        repository
        architecture
    }
    ROUTE {
        capability: reasoning
    }
    INSTRUCT {
        objective: "Analyze the project"
    }
    VERIFY {
        completeness
        correctness
    }
    RESULT
}

One important distinction: don’t put your NVIDIA API key into script.god. Credentials belong in the runtime’s secret-management layer, not the orchestration language.

If you’re using GitHub, commit these files to the repository:

git add AGENTS.md script.god docs/SCRIPT-GOD.md
git commit -m "docs: establish SCRIPT.GOD orchestration specification"
git push

Then Codex can pick up the architecture directly from the repository instead of you having to paste the specification into every conversation.
