-- ============================================================
-- INSURANCE CLAIMS FRAUD & LOSS INTELLIGENCE MODEL
-- Business Analyst Portfolio Project
-- Dataset: Auto Insurance Claims (1,000 Claims)
-- ============================================================

-- ============================================================
-- PHASE 1: DATA FOUNDATION & CLEANING
-- ============================================================

CREATE TABLE insurance_claims_master AS
SELECT
    policy_number,
    age,
    months_as_customer,
    policy_state,
    policy_annual_premium,
    policy_deductable,
    incident_date,
    incident_type,
    incident_severity,
    incident_state,
    incident_hour_of_the_day,
    number_of_vehicles_involved,
    bodily_injuries,
    witnesses,
    police_report_available,
    total_claim_amount,
    injury_claim,
    property_claim,
    vehicle_claim,
    auto_make,
    auto_year,
    fraud_reported,
    CASE WHEN fraud_reported = 'Y' THEN 1 ELSE 0 END AS is_fraud
FROM raw_insurance_claims
WHERE policy_number IS NOT NULL;

-- ============================================================
-- PHASE 2: FRAUD RATE ANALYSIS
-- ============================================================

-- 2A: Overall fraud metrics
SELECT
    COUNT(*)                                        AS total_claims,
    SUM(is_fraud)                                   AS fraud_cases,
    ROUND(AVG(is_fraud) * 100, 1)                   AS fraud_rate_pct,
    SUM(total_claim_amount)                         AS total_claims_value,
    SUM(CASE WHEN is_fraud=1 THEN total_claim_amount ELSE 0 END) AS fraudulent_value,
    ROUND(SUM(CASE WHEN is_fraud=1 THEN total_claim_amount ELSE 0 END)
        * 100.0 / SUM(total_claim_amount), 1)       AS fraud_value_pct
FROM insurance_claims_master;

-- 2B: Fraud rate by incident type
SELECT
    incident_type,
    COUNT(*)                                        AS total_claims,
    SUM(is_fraud)                                   AS fraud_cases,
    ROUND(AVG(is_fraud) * 100, 1)                   AS fraud_rate_pct,
    ROUND(AVG(total_claim_amount), 0)               AS avg_claim_amount,
    SUM(total_claim_amount)                         AS total_claim_value
FROM insurance_claims_master
GROUP BY incident_type
ORDER BY fraud_rate_pct DESC;

-- 2C: Fraud rate by incident severity
SELECT
    incident_severity,
    COUNT(*)                                        AS total_claims,
    SUM(is_fraud)                                   AS fraud_cases,
    ROUND(AVG(is_fraud) * 100, 1)                   AS fraud_rate_pct,
    ROUND(AVG(total_claim_amount), 0)               AS avg_claim_amount
FROM insurance_claims_master
GROUP BY incident_severity
ORDER BY fraud_rate_pct DESC;

-- ============================================================
-- PHASE 3: LOSS RATIO ANALYSIS
-- ============================================================

-- 3A: Overall loss ratio
SELECT
    SUM(total_claim_amount)                         AS total_claims_paid,
    SUM(policy_annual_premium)                      AS total_premiums_collected,
    ROUND(SUM(total_claim_amount) * 100.0
        / SUM(policy_annual_premium), 1)            AS loss_ratio_pct,
    ROUND(AVG(total_claim_amount), 0)               AS avg_claim_amount,
    ROUND(AVG(policy_annual_premium), 0)            AS avg_premium
FROM insurance_claims_master;

-- 3B: Loss ratio by state
SELECT
    incident_state,
    COUNT(*)                                        AS claims,
    SUM(total_claim_amount)                         AS total_claims,
    SUM(policy_annual_premium)                      AS total_premiums,
    ROUND(SUM(total_claim_amount) * 100.0
        / NULLIF(SUM(policy_annual_premium), 0), 1) AS loss_ratio_pct,
    ROUND(AVG(is_fraud) * 100, 1)                   AS fraud_rate_pct
FROM insurance_claims_master
GROUP BY incident_state
ORDER BY fraud_rate_pct DESC;

-- 3C: Vehicle make fraud and loss analysis
SELECT
    auto_make,
    COUNT(*)                                        AS total_claims,
    SUM(is_fraud)                                   AS fraud_count,
    ROUND(AVG(is_fraud) * 100, 1)                   AS fraud_rate_pct,
    ROUND(AVG(total_claim_amount), 0)               AS avg_claim,
    SUM(total_claim_amount)                         AS total_claim_value
FROM insurance_claims_master
GROUP BY auto_make
ORDER BY fraud_rate_pct DESC;

-- ============================================================
-- PHASE 4: COMPOSITE FRAUD RISK SCORING
-- ============================================================

CREATE TABLE claim_risk_scores AS
SELECT
    policy_number,
    total_claim_amount,
    incident_severity,
    incident_type,
    witnesses,
    months_as_customer,
    is_fraud,
    ROUND((
        0.35 * CASE incident_severity
            WHEN 'Major Damage'   THEN 100
            WHEN 'Total Loss'     THEN 80
            WHEN 'Minor Damage'   THEN 30
            WHEN 'Trivial Damage' THEN 10
            ELSE 20 END +
        0.25 * CASE incident_type
            WHEN 'Single Vehicle Collision' THEN 90
            WHEN 'Multi-vehicle Collision'  THEN 70
            WHEN 'Vehicle Theft'            THEN 40
            WHEN 'Parked Car'               THEN 20
            ELSE 30 END +
        0.20 * (total_claim_amount * 100.0 / 80000) +
        0.10 * CASE WHEN months_as_customer < 12 THEN 100 ELSE 0 END +
        0.10 * CASE WHEN witnesses = 0 THEN 100 ELSE 0 END
    ), 1)                                           AS risk_score,
    CASE
        WHEN risk_score >= 70 THEN 'Critical'
        WHEN risk_score >= 50 THEN 'High'
        WHEN risk_score >= 30 THEN 'Medium'
        ELSE                       'Low'
    END                                             AS risk_category
FROM insurance_claims_master;

-- 4A: Risk category summary
SELECT
    risk_category,
    COUNT(*)                                        AS claim_count,
    SUM(is_fraud)                                   AS confirmed_fraud,
    ROUND(AVG(is_fraud) * 100, 1)                   AS fraud_rate_pct,
    SUM(total_claim_amount)                         AS total_exposure,
    ROUND(AVG(total_claim_amount), 0)               AS avg_claim
FROM claim_risk_scores
GROUP BY risk_category
ORDER BY CASE risk_category
    WHEN 'Critical' THEN 1 WHEN 'High' THEN 2
    WHEN 'Medium' THEN 3 ELSE 4 END;

-- ============================================================
-- PHASE 5: FINANCIAL IMPACT QUANTIFICATION
-- ============================================================

-- 5A: Complete financial summary
SELECT
    COUNT(*)                                        AS total_claims,
    SUM(is_fraud)                                   AS confirmed_fraud_cases,
    SUM(CASE WHEN is_fraud=1
        THEN total_claim_amount ELSE 0 END)         AS confirmed_fraud_value,
    SUM(CASE WHEN risk_category IN ('Critical','High') AND is_fraud=0
        THEN total_claim_amount * 0.15 ELSE 0 END)  AS suspected_fraud_exposure,
    SUM(CASE WHEN is_fraud=1 THEN total_claim_amount ELSE 0 END) +
    SUM(CASE WHEN risk_category IN ('Critical','High') AND is_fraud=0
        THEN total_claim_amount * 0.15 ELSE 0 END)  AS total_fraud_risk
FROM claim_risk_scores;

-- 5B: Investigation ROI model
WITH investigation AS (
    SELECT
        COUNT(*) FILTER (WHERE risk_category='Critical')    AS critical_claims,
        500                                                 AS cost_per_investigation,
        COUNT(*) FILTER (WHERE risk_category='Critical') * 500 AS total_cost,
        SUM(CASE WHEN risk_category='Critical'
            THEN total_claim_amount ELSE 0 END) * 0.60     AS expected_recovery
    FROM claim_risk_scores
)
SELECT
    critical_claims,
    total_cost,
    expected_recovery,
    ROUND(expected_recovery / total_cost, 0)            AS roi_multiple,
    expected_recovery - total_cost                      AS net_benefit
FROM investigation;

-- 5C: Monthly fraud trend
SELECT
    DATE_TRUNC('month', incident_date)                  AS month,
    COUNT(*)                                            AS total_claims,
    SUM(is_fraud)                                       AS fraud_cases,
    ROUND(AVG(is_fraud) * 100, 1)                       AS fraud_rate_pct,
    SUM(CASE WHEN is_fraud=1
        THEN total_claim_amount ELSE 0 END)             AS fraud_value
FROM insurance_claims_master
GROUP BY 1
ORDER BY 1;

-- ============================================================
-- PHASE 6: PRIORITY INVESTIGATION LIST
-- ============================================================

-- Top 20 critical risk claims for immediate investigation
SELECT
    m.policy_number,
    m.auto_make,
    m.incident_type,
    m.incident_severity,
    m.incident_state,
    m.total_claim_amount,
    r.risk_score,
    r.risk_category,
    m.witnesses,
    m.months_as_customer,
    m.police_report_available,
    m.is_fraud                                          AS confirmed_fraud
FROM claim_risk_scores r
JOIN insurance_claims_master m USING (policy_number)
WHERE r.risk_category = 'Critical'
    AND m.is_fraud = 0
ORDER BY r.risk_score DESC, m.total_claim_amount DESC
LIMIT 20;
