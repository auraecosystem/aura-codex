SCRIPT.GOD VERSION "1.0"

SYSTEM LMLM {
    type: orchestrator
}

REGISTER MODEL "nvidia-llama-3.1-70b" {
    provider: nvidia
    runtime: nim

    CAPABILITIES {
        text
        reasoning
        instruction-following
        code-analysis
    }
}

REGISTER MODEL "codexlmlm" {
    provider: lmlm
    runtime: local

    CAPABILITIES {
        code
        implementation
        testing
        verification
    }
}

TASK "project-analysis" {

    CONTEXT {
        repository
        architecture
    }

    ROUTE {
        capability: reasoning
        model: "nvidia-llama-3.1-70b"
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
