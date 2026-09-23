# ask-brain: a real answer

Run on 23 September 2026 by a fresh Claude (Sonnet) session with the `ask-brain` skill, on the example vault in this repo, no web search. Copied word for word.

## Question

When should I use an AI agent instead of a fixed workflow, and what should my automation do when the AI model is down?

## Answer

Use an agent only when the steps can't be fixed in advance; otherwise use a workflow. When the model is down, the automation's essential step should still produce a result in plain code — the model only polishes.

**Agent vs. workflow**
Most useful systems are workflows: fixed steps with an LLM inside. Reserve an agent for when the task's steps genuinely can't be known ahead of time and you're trusting the model's own judgment on what to do next. Start with the simplest workflow pattern that fits (chaining, routing, parallel, orchestrator/workers, evaluator/optimiser) and add complexity only when it measurably helps — [[2024-12-19 - Anthropic - Building effective agents]].

**When the model is down**
Do the essential step in plain code (collect, filter, score, format) so the automation still produces something without the model. Let the model only improve the result — rewrite, summarise, classify edge cases. Validate its output and fall back to the plain version on any failure, and log which path ran — [[Keep the model out of the critical path]].

Before building either, check [[Build, buy or skip an AI tool]] first.
