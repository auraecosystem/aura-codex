SCRIPT.GOD

LMLM Universal Agent Orchestration Language

Specification v1.0

SCRIPT.GOD

script.god is the declarative orchestration language used by LMLM to coordinate models, agents, tools, memory, execution environments, verification systems, and external services.

It is not itself a language model.

It is the control language through which LMLM describes:

WHO
WHAT
WHY
WHERE
WHEN
HOW
WITH WHAT CAPABILITIES
UNDER WHICH POLICY
WITH WHICH CONTEXT
AND HOW THE RESULT IS VERIFIED

The fundamental execution chain is:

SCRIPT.GOD
    ↓
GOD PROTOCOL
    ↓
LMLM COORDINATOR
    ↓
TASK ROUTER
    ↓
MODEL / AGENT / TOOL
    ↓
EXECUTION
    ↓
VERIFICATION
    ↓
RESULT

⸻

1. DESIGN PRINCIPLES

script.god MUST be:

deterministic where possible
machine-readable
human-readable
provider-agnostic
model-agnostic
tool-agnostic
state-aware
permission-aware
verifiable
recoverable
extensible

It MUST NOT assume that intelligence comes from one particular model.

The execution target may be:

LLM
SLM
multimodal model
NVIDIA NIM
OpenAI
local CUDA model
agent
tool
API
database
container
browser
human approval

⸻

2. IDENTITY

Every participant has an identity.

REGISTER agent {
    id: "lmlm-coordinator"
    type: "orchestrator"
    version: "1.0"
}

A model:

REGISTER model {
    id: "nvidia-llama-3.1-70b"
    provider: "nvidia"
    runtime: "nim"
    model: "meta/llama-3.1-70b-instruct"
}

A tool:

REGISTER tool {
    id: "github"
    type: "external-service"
}

⸻

3. CAPABILITIES

Participants declare capabilities.

CAPABILITIES "nvidia-llama-3.1-70b" {
    text-generation
    reasoning
    instruction-following
    long-context
}

A multimodal model:

CAPABILITIES "vision-model" {
    text
    image
    OCR
    visual-reasoning
}

Tools:

CAPABILITIES "github" {
    repository-read
    repository-write
    issue-management
    pull-request-management
}

Capabilities are used by the router.

⸻

4. POLICY

Every execution operates under a policy.

POLICY production {
    permissions:
        read-repository
        write-source
        run-tests
    deny:
        expose-secrets
        destructive-git
        production-database-delete
}

Policies can be attached to tasks:

TASK build-dashboard {
    POLICY production
}

⸻

5. TASK

A task is the fundamental unit of work.

TASK build-lmlm-dashboard {
    objective:
        "Create the LMLM control-plane dashboard"
    priority: high
    deadline: none
    POLICY production
}

A task may contain subtasks:

TASK build-system {
    DECOMPOSE {
        frontend
        backend
        model-registry
        deployment
        verification
    }
}

⸻

6. ROUTE

ROUTE determines where work should execute.

ROUTE {
    task: "reasoning"
    capability: "text"
    policy: "production"
}

The router evaluates:

capability
model availability
latency
cost
priority
context window
hardware
policy
reliability
current load

Example:

NVIDIA NIM      score 92
OpenAI          score 87
Local CUDA      score 74

The highest eligible candidate is selected unless policy specifies otherwise.

⸻

7. INSTRUCT

INSTRUCT sends an authoritative instruction to an execution target.

INSTRUCT "nvidia-llama-3.1-70b" {
    TASK: "Analyze the architecture"
    OUTPUT: "architecture-report"
}

The model must not be expected to understand internal implementation details that are outside its assigned context.

⸻

8. CONTEXT

Context is explicitly managed.

CONTEXT task {
    repository
    architecture
    requirements
    previous-results
    relevant-files
}

Context can be scoped:

CONTEXT frontend {
    files:
        src/
        package.json
        vite.config.ts
        tailwind.config.ts
}

Sensitive context must be excluded:

CONTEXT frontend {
    DENY:
        secrets
        private-keys
        production-credentials
}

⸻

9. SHARE

Agents can exchange relevant information.

SHARE architecture-report
    FROM architect
    TO frontend-agent

Sharing should be explicit rather than automatically exposing every agent’s context.

⸻

10. PROGRESS

Long-running tasks emit progress.

PROGRESS {
    task: build-dashboard
    stage: "implementation"
    completed: 65
    message: "Dashboard components implemented"
}

⸻

11. ACK

Every authoritative task may be acknowledged.

ACK {
    task: build-dashboard
    agent: frontend-agent
    status: accepted
}

Possible states:

accepted
rejected
deferred
blocked

⸻

12. RESULT

Successful execution returns a structured result.

RESULT {
    task: build-dashboard
    status: success
    artifacts:
        dashboard
        tests
        documentation
    verification:
        build: passed
        tests: passed
}

⸻

13. ERROR

Errors are structured.

ERROR {
    task: build-dashboard
    code: BUILD_FAILURE
    stage: verification
    message:
        "TypeScript compilation failed"
    recoverable: true
}

Errors must not be silently swallowed.

⸻

14. BLOCKED

A task is explicitly marked blocked when execution cannot safely continue.

BLOCKED {
    task: deploy-nim
    reason:
        "GPU node unavailable"
    required:
        "NVIDIA GPU node"
}

Blocked does not mean failed.

⸻

15. VERIFY

Verification is a first-class operation.

VERIFY build-dashboard {
    typecheck
    lint
    tests
    build
}

For frontend:

VERIFY dashboard {
    route: "/lmlm"
    browser: true
    console-errors: false
}

For an AI response:

VERIFY response {
    factuality
    schema
    policy
    safety
}

No task should be considered complete merely because a model produced output.

⸻

16. STATE

The coordinator maintains explicit state.

STATE task {
    id
    status
    owner
    progress
    dependencies
    context
    result
    verification
}

Possible states:

CREATED
QUEUED
ROUTING
ASSIGNED
RUNNING
WAITING
VERIFYING
COMPLETED
FAILED
BLOCKED
CANCELLED
ROLLED_BACK

⸻

17. EVENT

Important transitions generate events.

EVENT {
    type: TASK_STARTED
    task: build-dashboard
    timestamp: now
}

Other events:

MODEL_REGISTERED
MODEL_HEALTH_CHANGED
TASK_CREATED
TASK_ROUTED
TASK_ASSIGNED
TASK_STARTED
TASK_PROGRESS
TASK_COMPLETED
TASK_FAILED
VERIFICATION_STARTED
VERIFICATION_PASSED
VERIFICATION_FAILED
SYNC_COMPLETED

⸻

18. SYNC

Synchronize distributed state.

SYNC {
    scope: task
    task: build-dashboard
}

Synchronization may include:

task state
agent state
context state
memory state
model registry
verification state

⸻

19. CANCEL

Tasks can be cancelled.

CANCEL {
    task: build-dashboard
    reason: "user-request"
}

Cancellation should propagate to dependent operations where appropriate.

⸻

20. ROLLBACK

Recover from failed changes where possible.

ROLLBACK {
    task: deploy-nim
    target: previous-known-good
}

Rollback policy should be explicit.

⸻

21. DEPENDENCIES

Tasks may depend on other tasks.

TASK deploy-dashboard {
    DEPENDS_ON build-dashboard
}

Execution:

build-dashboard
      ↓
verify-dashboard
      ↓
deploy-dashboard

A dependent task must not execute before required dependencies are satisfied.

⸻

22. PARALLEL EXECUTION

Independent tasks may execute concurrently.

TASK project {
    PARALLEL {
        frontend
        backend
        documentation
        tests
    }
}

The coordinator is responsible for synchronization.

⸻

23. SEQUENTIAL EXECUTION

Some operations require ordering.

SEQUENCE {
    REGISTER models
    DISCOVER capabilities
    ROUTE task
    INSTRUCT agent
    EXECUTE
    VERIFY
    RESULT
}

⸻

24. MODEL REGISTRY

Models are registered independently from orchestration logic.

REGISTER model {
    id: "nvidia-llama-3.1-70b"
    provider: nvidia
    runtime: nim
    capabilities:
        text
        reasoning
        instruction-following
    protocol:
        openai-compatible
    endpoint:
        internal
}

The same orchestration task can therefore be routed to another model without changing the task definition.

⸻

25. MODEL ADAPTERS

Every model provider should implement a common conceptual interface:

IDENTITY
CAPABILITIES
HEALTH
INFERENCE
STREAM
CANCEL

Example:

ADAPTER nvidia-nim {
    PROVIDER: nvidia
    RUNTIME: nim
    PROTOCOL: openai-compatible
}

The adapter hides provider-specific details from LMLM.

⸻

26. TOOL EXECUTION

Tools are treated as capabilities.

TASK inspect-repository {
    ROUTE capability: repository-read
}

The router may select:

GitHub
filesystem
container
browser
database

depending on available capabilities and policy.

⸻

27. HUMAN APPROVAL

Sensitive operations may require explicit human approval.

APPROVAL deploy-production {
    required: true
    scope:
        production-deployment
}

The task becomes:

WAITING_FOR_APPROVAL

until approval is received.

⸻

28. MEMORY

Memory should be explicitly scoped.

MEMORY task {
    read:
        relevant-history
    write:
        task-result
        architectural-decision
}

Long-term memory should not automatically receive sensitive or irrelevant context.

⸻

29. SECURITY

Every task operates within a security boundary.

SECURITY task {
    least-privilege
    no-secret-exposure
    audit-events
    tool-permissions
}

External model output must be considered untrusted.

A model must not automatically gain additional permissions merely because it requested them.

⸻

30. OBSERVABILITY

The runtime should expose:

METRICS {
    latency
    throughput
    token-usage
    errors
    model-selection
    verification-rate
}

For NVIDIA NIM:

GPU utilization
GPU memory
model loading time
inference latency
tokens/second
request concurrency
queue depth

⸻

31. FAILURE RECOVERY

When an execution target fails:

failure
   ↓
classify
   ↓
recoverable?
   ├── yes → retry / reroute
   └── no  → BLOCKED / ERROR

Example:

ON_FAILURE nvidia-nim {
    RETRY 2
    THEN ROUTE {
        capability: reasoning
        exclude: nvidia-nim
    }
}

This allows LMLM to fail over to another provider.

⸻

32. COMPLETE EXAMPLE

REGISTER model {
    id: "nvidia-llama-3.1-70b"
    provider: nvidia
    runtime: nim
}
REGISTER model {
    id: "openai-general"
    provider: openai
}
CAPABILITIES "nvidia-llama-3.1-70b" {
    text
    reasoning
    instruction-following
}
CAPABILITIES "openai-general" {
    text
    reasoning
    general
}
POLICY production {
    deny:
        secret-exposure
        destructive-git
}
TASK analyze-project {
    POLICY production
    CONTEXT {
        repository
        architecture
        requirements
    }
    ROUTE {
        capability: reasoning
    }
    INSTRUCT {
        objective:
            "Analyze the repository architecture"
        output:
            structured-report
    }
    VERIFY {
        schema
        completeness
    }
    RESULT
}

The runtime transforms that into:

REGISTER
    ↓
CAPABILITIES
    ↓
TASK
    ↓
CONTEXT
    ↓
ROUTE
    ↓
INSTRUCT
    ↓
EXECUTE
    ↓
VERIFY
    ↓
RESULT

⸻

33. LMLM MASTER EXECUTION LOOP

The canonical LMLM loop is:

                ┌──────────────┐
                │     TASK     │
                └──────┬───────┘
                       ↓
                ┌──────────────┐
                │   DECOMPOSE  │
                └──────┬───────┘
                       ↓
                ┌──────────────┐
                │   CONTEXT    │
                └──────┬───────┘
                       ↓
                ┌──────────────┐
                │    ROUTE     │
                └──────┬───────┘
                       ↓
                ┌──────────────┐
                │   INSTRUCT   │
                └──────┬───────┘
                       ↓
                ┌──────────────┐
                │   EXECUTE    │
                └──────┬───────┘
                       ↓
                ┌──────────────┐
                │   VERIFY     │
                └──────┬───────┘
                       ↓
                 ┌─────┴─────┐
                 │           │
               PASS        FAIL
                 │           │
                 ↓           ↓
              RESULT      RECOVER
                             │
                    ┌────────┴────────┐
                    ↓                 ↓
                  RETRY             ROUTE
                                      │
                                      ↓
                                  EXECUTE

⸻

34. CANONICAL COMMAND SET

The core script.god vocabulary is:

REGISTER
CAPABILITIES
POLICY
TASK
DECOMPOSE
DEPEND
PARALLEL
SEQUENCE
ROUTE
INSTRUCT
CONTEXT
SHARE
MEMORY
CONNECT
ACK
PROGRESS
RESULT
ERROR
BLOCKED
VERIFY
STATE
EVENT
SYNC
APPROVAL
CANCEL
ROLLBACK
METRICS

Future commands must preserve backward compatibility.

⸻

35. FUNDAMENTAL RULE

script.god does not determine which model is intelligent.

It determines:

which capability is required
which execution target is eligible
what context it receives
what it is allowed to do
what it must produce
how its work is coordinated
how its output is verified
what happens when it fails

Therefore:

MODEL ≠ ORCHESTRATOR
MODEL = EXECUTION CAPABILITY
SCRIPT.GOD = ORCHESTRATION CONTROL LANGUAGE
LMLM = INTELLIGENT RUNTIME
GOD PROTOCOL = COMMUNICATION / EXECUTION PROTOCOL

Together:

SCRIPT.GOD
     +
GOD PROTOCOL
     +
LMLM CORE
     +
MODEL REGISTRY
     +
MODEL ADAPTERS
     +
TOOLS
     +
MEMORY
     +
VERIFICATION
     =
LMLM INTELLIGENCE FABRIC
