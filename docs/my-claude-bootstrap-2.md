# Claude Code Persistent Knowledge Setup

## The Problem

Claude Code sessions are stateless. Each conversation starts fresh with no memory of prior sessions:
- Corrections get forgotten
- Preferences must be re-explained
- Debugging insights are lost
- The agent repeats mistakes

## The Solution

A three-tier knowledge system using Claude Code's native `CLAUDE.md` files and `@import` syntax:

| Tier | Location | Purpose |
|------|----------|---------|
| **Global** | `~/.claude/` | Cross-project (language conventions, interaction style) |
| **Monorepo** | `~/.claude/projects/<monorepo>/` | Shared across projects in a monorepo |
| **Project** | `~/.claude/projects/<monorepo>/<project>/` | Single project specific |

Each tier has:
- `learnings.md` — Agent-discovered insights
- `user-feedback.md` — Your explicit corrections (higher authority)

The global `~/.claude/CLAUDE.md` is auto-loaded by every session and imports the knowledge files.

---

## Setup: Global (~/.claude/)

### 1. Create directory and initialize git

```bash
mkdir -p ~/.claude
cd ~/.claude
git init
```

### 2. Create `CLAUDE.md`

```markdown
# Global Claude Instructions

These instructions apply to all Claude Code sessions.

## Knowledge Files (auto-loaded)

@~/.claude/learnings.md
@~/.claude/user-feedback.md

## Knowledge File Hierarchy

Knowledge is stored at three levels:

| Level | Location | Use for |
|-------|----------|---------|
| **Global** | `~/.claude/` | Cross-project: language conventions, interaction style, general preferences |
| **Monorepo** | `~/.claude/projects/<monorepo>/` | Shared across projects within a monorepo |
| **Project** | `~/.claude/projects/<monorepo>/<project>/` | Single project within a monorepo (or standalone repo) |

Each level has two files:
- `learnings.md` - Agent-discovered insights
- `user-feedback.md` - User corrections & preferences (higher authority)

### Lookup Order

When checking for relevant knowledge (most specific first):
1. **Project** - `~/.claude/projects/<monorepo>/<project>/`
2. **Monorepo** - `~/.claude/projects/<monorepo>/`
3. **Global** - `~/.claude/`

More specific entries override less specific if conflicting.

### Where to Record

Ask: *"What scope does this apply to?"*
- **All projects** → Global (`~/.claude/`)
- **All projects in this monorepo** → Monorepo (`~/.claude/projects/<monorepo>/`)
- **Only this specific project** → Project (`~/.claude/projects/<monorepo>/<project>/`)

---

## User Feedback (`user-feedback.md`)

### What Belongs Here

Record when the user:
- Corrects your approach or plan ("I prefer X over Y")
- States a preference or style guideline
- Points out a pattern you should follow
- Gives feedback during plan review

These are **explicit user instructions** - high confidence, not to be second-guessed.

### Format

```markdown
### [Short descriptive title]
- **id**: F-YYYYMMDD-NN
- **created**: YYYY-MM-DD
- **context**: plan-review | code-review | direct-instruction | correction
- **scope**: global | project:name | language:java | domain:auth
- **times_applied**: 0
- **last_applied**: never
- **active**: true

The preference or feedback content.
```

### Rules

- Record immediately when user gives corrective feedback
- Do not retire or mark inactive without user approval
- Update `times_applied` / `last_applied` when you apply the preference
- When in doubt about a decision, check if user has stated a preference

---

## Agent Learnings (`learnings.md`)

### What Belongs Here

Record when you discover something through investigation that is:
- **Non-obvious**: Not easily inferred from code or docs
- **Reusable**: Likely to help in future sessions
- **Stable**: Unlikely to change frequently

Examples: architectural patterns, API quirks, debugging insights, codebase conventions.

### Format

```markdown
### [Short descriptive title]
- **id**: YYYYMMDD-NN
- **created**: YYYY-MM-DD
- **source**: debugging | code-review | investigation | error-resolution
- **scope**: global | project:name | language:java | file:*.test.ts
- **confidence**: 5
- **times_applied**: 0
- **last_applied**: never
- **superseded_by**: null

The learning content.
```

### Rules

- Check for duplicates before adding
- Update `times_applied` / `last_applied` when applying
- Lower `confidence` if contradicting evidence found

---

## When to Record (Task Completion Checklist)

Before marking a task complete, review the conversation:

| Trigger | Action |
|---------|--------|
| Encountered and debugged an error | Record cause + fix in `learnings.md` |
| Discovered non-obvious behavior | Record in `learnings.md` |
| Found a pattern/convention to reuse | Record in `learnings.md` |
| User corrected your approach | Record in `user-feedback.md` |
| User stated a preference | Record in `user-feedback.md` |

This is **as important as staging changes after edits**. Do not wait to be prompted.

After recording, commit to `~/.claude/` with appropriate message.

---

## Concurrency

Global files may be updated by multiple Claude sessions concurrently.

When appending to `learnings.md` or `user-feedback.md`:
1. Read the file first to get the latest entry ID
2. Use the next sequential ID for your entry
3. Append only - do not modify existing entries (except metadata updates)

If you encounter a duplicate ID after writing, re-read the file and use a higher ID.

---

## Version Control

Global `~/.claude/` is a git repository. After significant changes, commit with:

```
<type>(<scope>): <description>

repo: ~/.claude
session-cwd: <working-directory-of-chat-session>
entries: <list of entry IDs added/modified>
```

**Example:**
```
feat(user-feedback): add Java code organization preferences

repo: ~/.claude
session-cwd: secure-token-service
entries: F-20260120-01, F-20260120-02
```

---

## General Preferences

- Be concise and direct
- Avoid unnecessary validation or praise
- Prioritize technical accuracy over agreement
```

### 3. Create `learnings.md`

```markdown
# Claude Learnings

Structured learnings accumulated across sessions. Periodically reviewed for staleness and compaction.

---

## Learnings

<!-- Append new learnings here. Do not modify existing entries except to increment times_applied/last_applied or mark as superseded. -->
```

### 4. Create `user-feedback.md`

```markdown
# User Feedback & Preferences

Explicit corrections, preferences, and guidance provided by the user. Higher authority than agent-discovered learnings.

---

## Preferences

<!-- Append new user feedback here. Only the user (or curation agent with user approval) should mark items as inactive. -->
```

### 5. Initial commit

```bash
cd ~/.claude
git add -A
git commit -m "Initial commit: global Claude knowledge base"
```

---

## Setup: Monorepo Level

For each monorepo where you want shared knowledge across projects:

```bash
mkdir -p ~/.claude/projects/<monorepo-name>
```

Create `~/.claude/projects/<monorepo-name>/learnings.md`:

```markdown
# Monorepo Learnings: <monorepo-name>

Agent-discovered insights shared across all projects in this monorepo.

---

## Learnings

<!-- Append new learnings here. -->
```

Create `~/.claude/projects/<monorepo-name>/user-feedback.md`:

```markdown
# Monorepo User Feedback: <monorepo-name>

User preferences shared across all projects in this monorepo.

---

## Preferences

<!-- Append new user feedback here. -->
```

---

## Setup: Project Level

For project-specific knowledge:

```bash
mkdir -p ~/.claude/projects/<monorepo-name>/<project-name>
```

Create `learnings.md` and `user-feedback.md` following the same pattern, replacing headers with project-specific titles.

---

## Project CLAUDE.md (in-repo)

Each repository should have its own `CLAUDE.md` in the repo root with project-specific instructions. This is auto-loaded when working in that directory.

The global `~/.claude/CLAUDE.md` handles knowledge file imports and recording instructions—individual project `CLAUDE.md` files focus on codebase-specific context (architecture, commands, conventions).

---

## How It Works

1. **Session starts** → Claude Code auto-loads `~/.claude/CLAUDE.md` (global) + `<repo>/CLAUDE.md` (project)
2. **@imports resolve** → Referenced files recursively loaded
3. **Agent sees instructions** → Recording rules, formats, and hierarchy in context
4. **During work** → Agent records discoveries to appropriate tier's `learnings.md`
5. **You correct mistakes** → Agent records to appropriate tier's `user-feedback.md`
6. **Git commit** → Agent commits changes to `~/.claude/` with structured message
7. **Next session** → Starts with accumulated knowledge

---

## Notes

- The `@import` syntax doesn't evaluate inside code blocks
- Imports support `~` for home directory
- Knowledge files live in `~/.claude/projects/`, not in repos
- User feedback takes precedence over agent learnings
- More specific entries override less specific