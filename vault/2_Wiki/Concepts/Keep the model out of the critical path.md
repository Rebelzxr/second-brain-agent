---
type: concept
tags: [automation, reliability, ai-agents]
sources: ["[[2024-12-19 - Anthropic - Building effective agents]]"]
updated: 2026-09-23
---

# Keep the model out of the critical path

**In one line:** the step an automation cannot live without should be plain code; the AI model should improve the result, not be required for it.

## Why it matters
A daily job that needs a model to produce anything stops completely the day the model is rate-limited, down or out of quota, and often nothing tells you. A job where plain code does the essential step still produces a result; it is just less polished that day.

## How to apply it
1. Ask of every automation: "what happens when the model is unavailable?"
2. Do the essential step in code: collect, filter, score, format.
3. Let the model polish: rewrite titles, summarise, classify the edge cases.
4. Check the model's output (length, schema, no new numbers) and fall back to the plain version on any failure.
5. Log which path ran, so you can see how often the fallback is used.

## Example
A news picker scores candidates with plain rules and publishes the top five. A model may rewrite the headlines; if the model call fails, the original headlines go out. See the [ai-news-picker](https://github.com/Rebelzxr/ai-news-picker) repo.

## Related
- [[2024-12-19 - Anthropic - Building effective agents]]: its advice to start with the simplest solution points the same way.
- [[Build, buy or skip an AI tool]]
