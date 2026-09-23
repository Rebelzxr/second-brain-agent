---
type: digest
source: https://www.anthropic.com/engineering/building-effective-agents
source_date: 2024-12-19
digested: 2026-09-23
tags: [ai-agents, workflows, architecture]
---

# Digest: Building effective agents (Anthropic)

## TL;DR
- Most useful AI systems are **workflows** (fixed steps with an LLM inside), not free-roaming **agents**. Use an agent only when the steps cannot be known in advance.
- The article names five workflow patterns: prompt chaining, routing, parallelisation, orchestrator and workers, and evaluator and optimiser.
- Start with the simplest thing that works, and add complexity only when it measurably helps.

## What it says
The authors describe what they saw working with teams that build with LLMs. The successful systems were usually simple and composable rather than built on heavy frameworks. They separate workflows, where code controls the path, from agents, where the model decides its own next step and tool use. Agents trade cost and predictability for flexibility, so they suit open-ended problems where you can trust the model's judgment and check its results.

## Distilled knowledge
| Pattern | Use it when |
|---|---|
| Prompt chaining | The task splits cleanly into fixed steps; add checks between steps |
| Routing | Inputs fall into clear types that need different handling |
| Parallelisation | Independent parts can run at once, or several attempts can be compared |
| Orchestrator and workers | The subtasks are not known in advance and must be decided per input |
| Evaluator and optimiser | There are clear criteria and feedback measurably improves the result |

Their advice on tools: design the tool interface as carefully as a prompt, with clear names, examples and formats the model finds natural.

## Fact-check pass
- Checked on 23 Sep 2026 against the original page: the date (19 December 2024), the five pattern names, the workflow and agent definitions, the "simplest solution first" advice and the section on designing tool interfaces. Everything above is paraphrased, not quoted.

## How this affects me
| Area | Change | Impact | Action |
|---|---|---|---|
| Automations | Default to a workflow with fixed steps | Fewer surprise failures | Before building, write the steps down; only use an agent if you cannot |
| Reviews | Add an evaluator step where quality matters | Better output, visible checks | Pair a builder with a separate reviewer |

## Steal
- The five-pattern table as a design checklist.
- "Simplest solution first, measure before adding complexity."

## Ignore
- Nothing here needs ignoring; the article is framework-neutral.

## Questions
- Which of my current automations is really an agent that should be a workflow?

## Related
- [[Keep the model out of the critical path]]
