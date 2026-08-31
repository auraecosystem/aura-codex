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
