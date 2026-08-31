SCRIPT.GOD VERSION "1.0"

REGISTER LMLM {
    type: orchestrator
}

REGISTER MODEL "nvidia-llama-3.1-70b" {
    provider: nvidia
    runtime: nim
}

REGISTER MODEL "codexlmlm" {
    provider: lmlm
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
