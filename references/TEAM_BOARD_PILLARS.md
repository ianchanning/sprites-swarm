# Team Board Pillars

  1. The Atomic Unit: What defines a 'Task' in the mind of a Carpenter?

  In the mind of a Carpenter, a 'Task' is a simple **Note**. It is a transient spark of intent, stripped of all bureaucratic sludge to maintain maximum velocity.

   * The Note: Each note contains only a **Title** (the intent) and a **Colour** (the Soul_Affinity/Vibe). It is optionally linked to an **Entropy_Signature** (a unique ID for tracking).
   * Reversed Assignment: Notes are not assigned to Sprites. Instead, **WIP Groups** are formed. A Group is assigned one or more Notes.
   * Leashing the Tentacles: Sprites (Tentacles) are "leashed" to a WIP Group. A Sprite’s **Cave_Context** is defined by its identity—a unique sigil like "🦂A" (animal emoji + NATO letter).
   * Brutal Minimalism: There are **no Weights and no Dependencies**. Priority is defined spatially: the top note in a Group's stack is the current focus of the leashed Sprites.

  2. The HTMX Interaction Model: Rugged Real-Time Sigils

  We lean on native browser behaviors and standard HTML for the board's structure, reserving HTMX for the fluid heartbeat of the swarm. (⇌)

   * Rugged Interactions: Most board actions are simple POSTs and standard HTML swaps. We avoid complex transitions or client-side logic that fights the browser, prioritizing stability and predictability.
   * Real-Time Sigils: HTMX is dedicated to one thing: the fluid updates of the Sprite sigils (🦂A). Through simple OOB (Out-of-Band) updates, the Carpenter sees the live status of the swarm (Idle, Busy, Done) without the overhead of a heavy SPA.

  3. Persistence & Safety: SQLite + 'The Safety Net'

  We stay brutally simple, but we don't gamble with the state.

   * The Foundation: Flat SQLite. It’s portable, fast, and lives inside the project root. It holds the current board state, column mappings, and metadata.
   * The Safety Net (Light Event-Sourcing): We don't just update rows; we append to a delta_log. Every move and every "Soul" assignment is an immutable event.
     This allows the Quantum Leap Protocol: if a Sprite accidentally nukes the codebase, we can "Rewind the Board" to a known good state, and the system will automatically re-spawn
     the Caves at that specific git hash.

  4. The 'Carpenter' Aesthetic: Gritty, Reactive, Brutalist

  The aesthetic is functional, precise, and unapologetically clean. It prioritizes the clarity of a mission-critical environment.

   * Three Vibe Keywords: RUGGED, KINETIC, UNFILTERED.
   * The Visual Soul: Base Tailwind in a Submarine. A high-end industrial dashboard found in the belly of a submarine, expressed through the clean utility-first patterns of Tailwind CSS. It is a dense, high-information interface that prioritizes tactile feedback and functional purpose over decorative fluff.

  5. The Failure Domains: The Gremlin we kill first

  The most dangerous gremlin is Ghost State (Desynchronization).

  This is the failure where the Octopus (the Board) thinks a Tentacle (the Sprite) is working on Task-A, but the Cave has crashed, or the ralph.sh loop has entered an infinite
  recursion of "Self-Correction" that produces no code.
   * The Kill Switch: We implement a Heartbeat Watchdog. If a Sprite in "WIP" doesn't update its Entropy_Signature (via a small OOB fragment update) within a defined TTL, the board
     declares it a "Ghost."
   * The Action: The board doesn't just show an error; it provides a "Purge & Re-Summon" button that executes ./lsprite.sh destroy and ./lsprite.sh create in one click, pulling the last known good state from the Event Source.
