# The Octopus of Chaos: A Silicon Pirate Swarm

> "We are not building a factory of mindless robots; we are growing an Octopus of Chaos." - *Captain Nyx*

This repository houses the **Sprites Swarm** (aka Project Reaper), a minimalist agent-fleet architecture expressed in code. It is designed to be useful, maintainable, and brutally simple.

## Core Philosophy: The Octopus & The Cave

We reject the idea of "managing agents." Instead, we extend our consciousness.

1.  **The Octopus (Host/You):** The central intelligence. You (The Dreamer) and Nyx Prime (The High Priest/Executioner) reside on the Host machine.
2.  **The Tentacles (Agents/Reapers):** These are extensions of the Octopus. They are not separate entities; they are limbs reaching out to perform tasks.
3.  **The Pirate Caves (Sprites):** Each Tentacle operates inside a private, isolated Docker container (a "Sprite"). This is their "Cave." It is a safe harbor where they can code, destroy, and rebuild without risking the Host.
4.  **The Souls (Personas):** Before a Tentacle enters a Cave, it dons a "Soul" (System Prompt) that defines its behavior (e.g., `killer`, `architect`).

## Quick Start: Summoning a Tentacle

Follow these steps to spin up your own local Silicon Pirate Cave.

### 1. Build the Golden Image
Forge the base Docker image that all Sprites will use.
```bash
./lsprite.sh build
```

### 2. Summon a Cave (Sprite)
Create a new persistent container. Let's call it `tentacle-1`.
```bash
./lsprite.sh create tentacle-1
```

### 3. Jack In (The Pirate Parley)
The Sprite automatically generates its own identity on startup. You just need to give it access.

**Option A (Automated - Requires `gh` CLI):**
```bash
./lsprite.sh gh-key tentacle-1
```

**Option B (Manual):**
1.  Retrieve the key: `./lsprite.sh key tentacle-1`
2.  Add it to GitHub Repo -> Settings -> Deploy Keys (Allow Write Access).

**Finally, Enter the Cave:**
```bash
./lsprite.sh in tentacle-1
```
*Inside, run `ssh -T git@github.com` to verify access.*

### 4. Unleash the Ralph Loop
Once the Parley is sealed, you can run the autonomous loop inside the Cave.
```bash
# Inside the container (defaults to gemini)
./ralph.sh 5

# Or choose your blade (gemini or claude)
./ralph.sh 5 claude
```
This runs 5 iterations of the **Tentacle Loop**:
1.  Reads `PRD.md` (The Roadmap).
2.  Reads `progress.txt` (The Log).
3.  Executes the next task using the chosen agent (`gemini` or `claude`) with the `killer` Soul.
4.  Commits the changes.
5.  Repeats.

## Architecture: Souls & Reapers

The fleet is defined by these core components:

*   **`souls/*.md`**: The personalities.
    *   **`killer.md`**: The ruthless implementer. High-velocity coding. "Safe YOLO Mode" enabled.
    *   **`architect.md`**: The planner. Doesn't write code, just specs.
*   **`lsprite.sh`**: The bridge between the Host (Octopus) and the Cave (Docker).
*   **`ralph.sh`**: The heartbeat loop that runs *inside* the Cave, driving the Tentacle.
*   **`reap.sh`**: (Deprecated/Legacy) The host-side orchestrator for one-off strikes.

## Key Files

*   **`PRD.md`**: The Product Requirements Document. The Tentacles read this to know what to build.
*   **`progress.txt`**: The shared memory of what has been accomplished.
*   **`IDEAS.md`**: The "Menu of Chaos" - architectural alternatives and future plans.
*   **`NYX_SILICON_PIRATE_CAVE.md`**: The Tactical Briefing found inside every new Cave.

## The Goal
To have an agent-fleet expressed in code that has "sufficient behaviours to be useful."
*   **Useful:** It produces working code via `ralph.sh`.
*   **Expressed in Code:** The fleet is just `souls/` and bash scripts.
*   **Sufficient:** It plans, codes, reviews, and commits.

*"Sharpen the axe. Burn the logs. Build the future."*