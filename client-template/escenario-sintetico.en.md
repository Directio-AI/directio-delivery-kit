# Synthetic scenario

When the client has not sent data yet, we don't wait: we build a scenario with invented data that mimics their process and test the pilot there. That way we arrive at the next meeting with something working and with much more concrete questions.

## Rules

1. **Everything invented.** No real name, price, document number or person from the client or third parties. Fictitious companies and people, with names that are clearly fictitious.
2. **Labeled.** Every file carries `SINTÉTICO` (synthetic) in the folder name and in its first line or column. It is never mixed with real data in the same folder.
3. **True to the shape, not the numbers.** We copy the structure the client described (which fields, which formats, which steps), not their figures. Figures are of a reasonable order of magnitude and nothing more.
4. **Include the mess.** Easy cases prove nothing. Each scenario has incomplete, duplicate, ambiguous or misclassified cases, in the proportion the client mentioned or, if they did not, about one in four.
5. **Comes with an answer key.** For each case we know the correct answer in advance. Without a key nothing can be measured.
6. **Never presented as the client's result.** It is for testing the method and showing what it would look like. Pilot numbers come only from real data.

## What the `escenario-SINTETICO/` folder contains

| File | What it is |
|---|---|
| `LEEME.md` (read me) | Which process it mimics, which assumptions we made and where each assumption came from (meeting, quote, inference). |
| Reference data | What the person looks up while working: catalog, history, rates, policy wordings. CSV or Markdown. |
| Input cases | What arrives at the process: requests, invoices, emails. One per file or one per row. |
| `clave-respuestas.csv` (answer key) | The correct answer for each case and which trap it contains. |
| `prueba.md` (test) | The protocol: what the AI is given, what it is asked, how it is scored and which number comes out. |

## How to build it

1. Take the chosen process from the profile and write in `LEEME.md` the steps as the client told them.
2. List the fields that come in and go out. If you don't know them, infer them and mark them **[I]**: that is a question for the next meeting.
3. Generate the reference data with a fixed-seed script so it can be regenerated identically.
4. Write the cases by hand or with the script, mixing easy, medium and trap cases.
5. Write the key before running the test, not after.
6. Run the test in a tool approved for the layer you are in (see `policy/data-classification.en.md`). With synthetic data the backbone layer is enough; with real data, the client's account.

## How it is scored

- **Accuracy:** cases where the output matches the key, over the total.
- **Traps caught:** trap cases where the AI flagged the trap or asked for the missing data, over the total traps. This number matters more than accuracy: an AI that invents what is missing is worse than one that asks.
- **Time:** minutes per case with the AI plus human review, against the client's estimate of current time.
- **Serious errors:** any output that would have reached the end customer wrong. The goal is zero.

## When real data arrives

Run the same `prueba.md` with 5 to 20 real cases in the client's account. Compare with the synthetic result: if the real one is much worse, the scenario did not reflect the process well, and that is a finding too.
