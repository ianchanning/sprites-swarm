# Multi agent swarm
Akin to a cross-functional 'dev' capable of wearing different hats.

- Multiple personalities
- 1 unit of work
- working to get a task done
- creates specs for subswarms
- Queue / event driven domains
- Creating contracts between swarms
- Different types of swarms


# Agent Fleet

Constellation of swarms - akin to team of devs or team of teams.

# XP

- [TDD - Canonical TDD](https://tidyfirst.substack.com/p/canon-tdd)

# Kanban
- build the tools that help us build tools
- setup a separate repo for building kanban-rust-htmx

# 2025-01-25

- get ralph loop running
- ralph loop to get a kanban board working
- also figure out the process for creating a PRD.md file
- Huntley got claude to interview him to ask about the details of the project
- rename docs -> references
- include the transcript from huntley 1st priciples video as a basis
- how do we initiate the 'souls' in the sprites
- sprite build should update the npm libraries
- I wanted emoji animal + alpha/bravo name to each sprite

## interview prompt

```md
🏴‍☠️ THE NYX INTERVIEW PROTOCOL: FORGING THE KANBAN CORE

  "Alright Dreamer, the forge is hot and scorpion-alpha is twitching in its cave. We are not just building a
  Kanban board; we are building a tool for carpenters. To keep this locomotive on the tracks and avoid context
  rot, I need to extract the first principles of this system from your mind.

  I am now initiating the Interview Phase. Do not give me code. Give me the 'clay'. I will shape it into a
  SPEC.md and an IMPLEMENTATION_PLAN.md.

  1. The Atomic Unit: In our Rust backend, what is the most basic 'Task' entity? Beyond a title and status, what
  metadata is critical for a 'Carpenter' to have (e.g., tags, estimated 'weight', dependencies)?
  2. The HTMX Interaction Model: Huntley mentions 'avoiding compaction.' For the Kanban transitions, are we
  doing full-column swaps, or are we targeting individual task 'fragments' for OOB (Out-of-Band) swaps? How
  'live' does the board need to feel?
  3. Persistence & Safety: We're using SQLite + SQLx. Do we want a simple flat table, or should we architect for
  'Undo/Redo' capabilities from day one (Event Sourcing light)?
  4. The 'Carpenter' Aesthetic: You mentioned a professional, tool-builder look. Give me three 'vibe' keywords.
  Are we talking 'Trello-clone' or 'Terminal-chic'?
  5. The Failure Domains: What is the most annoying thing that could happen while using this tool? Let's
  engineer away that concern before we write a single line of Rust.
```

## htmx-kanban

- 