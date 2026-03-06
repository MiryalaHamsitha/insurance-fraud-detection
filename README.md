# Insurance Claims Fraud Detection & Loss Analysis
**Business Analyst Portfolio Project**

## Project Overview
End-to-end fraud detection and loss analysis model built on 1,000 auto insurance claims. Identifies $14.9M in fraudulent claims, scores every claim on a composite risk scorecard, and delivers a 131x ROI investigation framework.

---

## Headline Numbers

| Metric | Value |
|---|---|
| Total Claims Analyzed | 1,000 |
| Confirmed Fraud Cases | 247 (24.7%) |
| Fraudulent Claims Value | $14,894,620 |
| Avg Claim Amount | $52,762 |
| Loss Ratio | 4,199% |
| Critical Risk Claims | 135 |
| Investigation ROI | 131x |
| Target Recovery | $8.9M |

---

## Business Problem
An auto insurance company is experiencing unsustainable loss ratios driven by fraudulent claims. With a 24.7% fraud rate and $14.9M in confirmed fraud — 28.2% of all claims paid — the business needs a data-driven framework to detect, score, and prioritize fraud investigations before financial exposure compounds.

---

## Key Business Questions
- Which claim types and severities have the highest fraud rates?
- How much financial exposure exists from confirmed and suspected fraud?
- Which claims should be immediately flagged for investigation?
- What is the ROI of a targeted fraud investigation program?
- Which states and vehicle makes carry the highest fraud concentration?

---

## 6-Phase Analytical Approach

| Phase | Focus | Output |
|---|---|---|
| 1 | Data Foundation & Cleaning | 1,000 clean claim records |
| 2 | Fraud Rate Analysis | Fraud rates by type, severity, state, vehicle |
| 3 | Loss Ratio Analysis | 4,199% loss ratio quantified |
| 4 | Composite Risk Scoring | Every claim scored 0–100 |
| 5 | Financial Impact | $14.9M confirmed + $2.1M suspected |
| 6 | Strategic Recommendations | 4-phase action plan |

---

## Key Findings

**1. Major Damage = 60.5% Fraud Rate**
Claims reported as Major Damage are fraudulent 60.5% of the time — 6x the rate of Minor Damage claims (10.7%).

**2. $14.9M in Confirmed Fraudulent Claims**
247 confirmed fraud cases account for $14.9M — the business pays $1 in fraud for every $3 in legitimate claims.

**3. Ohio, NC, SC = Highest Fraud States**
OH (43.5%), NC (30.9%), SC (29.4%) carry significantly above-average fraud rates.

**4. 131x Investigation ROI**
Investing $67,500 to investigate 135 critical risk claims recovers an expected $8.9M — 131x return.

**5. Single Vehicle Collisions = 29% Fraud**
Hard-to-verify incidents with no other party carry nearly 3x the fraud rate of vehicle theft claims (8.5%).

---

## Fraud Risk Scorecard

| Factor | Weight | Logic |
|---|---|---|
| Incident Severity | 35% | Major=100, Total Loss=80, Minor=30, Trivial=10 |
| Incident Type | 25% | Single Vehicle=90, Multi-vehicle=70, Theft=40 |
| Claim Amount | 20% | Normalized 0-100 against portfolio max |
| Customer Tenure | 10% | <12 months = 100 (new customer risk) |
| Witness Count | 10% | 0 witnesses = 100 (no corroboration) |

**Risk Categories:** Critical (≥70) · High (50–70) · Medium (30–50) · Low (<30)

---

## Strategic Recommendations

| Phase | Timeline | Action |
|---|---|---|
| 1 | 0–30 Days | Investigate 135 Critical risk claims immediately |
| 2 | 30–90 Days | Deploy scoring to all new claims; set up SIU team |
| 3 | 3–6 Months | Build ML fraud detection pipeline |
| 4 | 6–12 Months | Monitor fraud rate monthly — target <15% |

---

## Repository Structure
