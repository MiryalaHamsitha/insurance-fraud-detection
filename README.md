Project Overview
End-to-end fraud detection and loss analysis model built on 1,000 auto insurance claims. Identifies $14.9M in fraudulent claims, scores every claim on a composite risk scorecard, and delivers a 131x ROI investigation framework.

Headline Numbers
MetricValueTotal Claims Analyzed1,000Confirmed Fraud Cases247 (24.7%)Fraudulent Claims Value$14,894,620Avg Claim Amount$52,762Loss Ratio4,199%Critical Risk Claims135Investigation ROI131xTarget Recovery$8.9M

Business Problem
An auto insurance company is experiencing unsustainable loss ratios driven by fraudulent claims. With 24.7% fraud rate and $14.9M in confirmed fraud — 28.2% of all claims paid — the business needs a data-driven framework to detect, score, and prioritize fraud investigations before financial exposure compounds.

6-Phase Analytical Approach
PhaseFocusOutput1Data Foundation & Cleaning1,000 clean claim records2Fraud Rate AnalysisFraud rates by type, severity, state, vehicle3Loss Ratio Analysis4,199% loss ratio quantified4Composite Risk ScoringEvery claim scored 0–1005Financial Impact$14.9M confirmed + $2.1M suspected6Strategic Recommendations4-phase action plan

Key Findings
1. Major Damage = 60.5% Fraud Rate
Claims reported as Major Damage are fraudulent 60.5% of the time — 6x the rate of Minor Damage claims (10.7%).
2. $14.9M in Confirmed Fraudulent Claims
247 confirmed fraud cases account for $14.9M — the business pays $1 in fraud for every $3 in legitimate claims.
3. Ohio, NC, SC = Highest Fraud States
OH (43.5%), NC (30.9%), SC (29.4%) carry significantly above-average fraud rates.
4. 131x Investigation ROI
Investing $67,500 to investigate 135 critical risk claims recovers an expected $8.9M — 131x return.
5. Single Vehicle Collisions = 29% Fraud
Hard-to-verify incidents with no other party carry nearly 3x the fraud rate of vehicle theft claims.

Fraud Risk Scorecard
FactorWeightLogicIncident Severity35%Major=100, Total Loss=80, Minor=30, Trivial=10Incident Type25%Single Vehicle=90, Multi-vehicle=70, Theft=40Claim Amount20%Normalized 0-100 against portfolio maxCustomer Tenure10%<12 months = 100 (new customer risk)Witness Count10%0 witnesses = 100 (no corroboration)
Risk Categories: Critical (≥70) · High (50-70) · Medium (30-50) · Low (<30)

Strategic Recommendations
PhaseTimelineAction10–30 DaysInvestigate 135 Critical risk claims immediately230–90 DaysDeploy scoring to all new claims; SIU team setup33–6 MonthsBuild ML fraud detection pipeline46–12 MonthsMonitor fraud rate monthly — target <15%

Repository Structure
insurance-fraud-intelligence/
├── README.md
├── case_study.pdf
├── data/
│   └── insurance_claims.csv
├── outputs/
│   ├── Insurance_Fraud_Intelligence_Model.xlsx
│   ├── ins_chart1_monthly.png
│   ├── ins_chart2_fraud_patterns.png
│   ├── ins_chart3_risk_scores.png
│   ├── ins_dash_p1_executive.png
│   ├── ins_dash_p2_fraud_patterns.png
│   ├── ins_dash_p3_risk_loss.png
│   └── ins_dash_p4_recommendations.png
└── sql/
    └── Insurance_Fraud_SQL_Model.sql

Tools & Skills
SQL Python pandas matplotlib Excel Risk Scoring Fraud Detection Loss Ratio Analysis Business Analysis

Dataset: Auto Insurance Claims — Kaggle | 1,000 records | 40 variables
