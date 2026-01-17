# Project Reaper: The Minimalist Agent Fleet ("Pirates with Katanas")

This document outlines a strategy to build an "agent-fleet expressed in code" that is useful, maintainable, and brutally simple. We strip away the complexity of traditional orchestration frameworks in favor of a disposable, container-based "Soul" architecture.

## 1. Core Philosophy: "The Reaper Pattern"

Instead of maintaining long-running, stateful agents, we treat agents as **disposable execution units**. This prevents state drift and ensures a clean environment for every task.

*   **Reference:** *The Design & Implementation of Sprites* (Ptacek): "Sprites are ball-point disposable computers... The whole point is that there’s no reason to parcel them out... You just make a new one."
*   **Application:** Our fleet is a collection of "Souls" (System Prompts). To run an agent, we spawn a generic container (a local Sprite), inject a Soul, execute the task, and move on.

## 2. Architecture: "Souls" and "The Reaper"

The entire "Fleet" consists of only two components committed to the repository:

### A. The Souls (`/souls/*.md`)
These are the definitions of our agents. Each Markdown file contains the system prompt and operational constraints for a specific persona.

*   **`souls/killer.md` (The Implementer):**
    *   **Role:** High-velocity coding. "Safe YOLO Mode" enabled.
    *   **Reference:** *Claude Code Best Practices* ("Safe YOLO mode"): "Letting Claude run arbitrary commands... in a container... works well for workflows like fixing lint errors or generating boilerplate code."
    *   **Behavior:** Takes a file path and a bug report. Fixes it. No chatter.

### B. The Reaper Script (`reap.sh`)
A tiny shell script that acts as the "Orchestrator." It handles the lifecycle of the local Sprite (a "Fat Container").

*   **Mechanism:** `./reap.sh <soul> <task>`
    1.  **Spawn:** Ensures a local Docker container (Sprite) is running with the repository mounted at `/workspace`.
    2.  **Inject:** Pipes the content of `souls/<soul>.md` (System Prompt) into the container's CLI tool.
    3.  **Execute:** Runs the task inside the isolated environment using headless mode.
*   **Reference:** *Claude Code Best Practices* ("Headless Mode"): "Use the -p flag with a prompt to enable headless mode... for non-interactive contexts like CI... and automation."

## 3. Why This is "Sufficient" and "Useful"

The goal is a fleet with "sufficient behaviours to be useful." By decomposing the work into specialized "Souls," we achieve utility through focus:

*   **Behavior 1: Isolated Execution (Safety)**
    *   **Source:** *Demystifying evals*: "Each trial should be 'isolated' by starting from a clean environment."
    *   **Implementation:** Every task runs in a fresh container. If an agent deletes the filesystem, the host is protected.

*   **Behavior 2: Specialized Context (Efficiency)**
    *   **Source:** *Claude Code Best Practices*: "Claude Code’s success rate improves significantly with more specific instructions... giving clear directions upfront reduces the need for course corrections."
    *   **Implementation:** We don't ask one agent to be an architect AND a coder. We use `souls/architect.md` for planning and `souls/killer.md` for coding.

*   **Behavior 3: "Infrastructure as Code" (Reproducibility)**
    *   **Source:** *SuperClaude*: "Transform Claude Code into a Structured Development Platform... through behavioral instruction injection."
    *   **Implementation:** The entire behavior of the fleet is version-controlled in the `/souls` directory. Improving the fleet means editing a Markdown file.

## 4. The "Eval" Strategy (Verification)

We verify utility using the "Eval" concept but stripped to the bone.

*   **The "Gauntlet":** A test script that runs a `killer` agent against a known bug.
*   **Reference:** *Demystifying evals*: "Start with what you already test manually... 20-50 simple tasks drawn from real failures."
*   **Implementation:** 
    1. Create a branch with a broken test.
    2. Run `./reap.sh killer "Fix the failing test"`.
    3. Run the test suite. If it passes, the agent is "Useful."

## 5. Future Expansion (The "Swarm")

The skeleton can evolve into more complex behaviors:

*   **The "Factory" Pattern:** A script `assemble.sh` that chains `./reap.sh architect` -> `./reap.sh killer` -> `./reap.sh reviewer`.
*   **Reference:** *Claude Code Best Practices* ("Multi-Claude workflows"): "Have one Claude write code; use another Claude to verify... This separation often yields better results."
