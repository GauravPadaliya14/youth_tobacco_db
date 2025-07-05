-- Create the database
CREATE DATABASE youth_tobacco_db;
USE youth_tobacco_db;

-- Create the table
CREATE TABLE youth_tobacco_survey (
    id INT PRIMARY KEY AUTO_INCREMENT,
    state VARCHAR(100),
    area VARCHAR(20),
    ever_tob_use FLOAT,
    curr_tob_use FLOAT,
    ever_smoke FLOAT,
    curr_smoke FLOAT,
    ever_cig FLOAT,
    curr_cig FLOAT,
    ever_bidi FLOAT,
    curr_bidi FLOAT,
    ever_slt FLOAT,
    curr_slt FLOAT,
    ever_pm_tob FLOAT,
    suscept_cig FLOAT,
    age_init_cig VARCHAR(20),
    age_init_bidi VARCHAR(20),
    age_init_slt VARCHAR(20),
    e_cig_aware FLOAT,
    e_cig_ever FLOAT,
    quit_smoke_12mo FLOAT,
    tryquit_smoke_12mo FLOAT,
    wantquit_smoke FLOAT,
    quit_slt_12mo FLOAT,
    tryquit_slt_12mo FLOAT,
    wantquit_slt FLOAT,
    smoke_exposure FLOAT,
    smoke_home FLOAT,
    smoke_enclosed FLOAT,
    smoke_outdoor FLOAT,
    seen_smoke_school FLOAT,
    source_cig_store FLOAT,
    source_cig_paan FLOAT,
    source_bidi_store FLOAT,
    source_bidi_paan FLOAT,
    source_slt_store FLOAT,
    source_slt_paan FLOAT,
    bought_cig_loc FLOAT,
    bought_bidi_loc FLOAT,
    refused_cig_sale FLOAT,
    refused_bidi_sale FLOAT,
    refused_slt_sale FLOAT,
    cig_stick VARCHAR(20),
    bidi_stick FLOAT,
    seen_at_message FLOAT,
    seen_at_media FLOAT,
    seen_at_events FLOAT,
    seen_warnings FLOAT,
    seen_ads FLOAT,
    seen_use_media VARCHAR(20),
    seen_cig_ads_pos FLOAT,
    taught_tob_effects FLOAT,
    hard_to_quit FLOAT,
    shs_harmful FLOAT,
    ban_indoor FLOAT,
    ban_outdoor FLOAT,
    aware_cotpa FLOAT,
    fine_auth FLOAT,
    tobacco_free_guideline FLOAT,
    aware_board_policy FLOAT
);

-- 1. Top 5 states with highest current tobacco use
SELECT state, area, curr_tob_use
FROM youth_tobacco_survey
WHERE area = 'Total'
ORDER BY curr_tob_use DESC
LIMIT 5;

-- 2. Average tobacco use by area (Urban vs Rural)
SELECT area, 
       ROUND(AVG(curr_tob_use), 2) AS avg_current_use,
       ROUND(AVG(ever_tob_use), 2) AS avg_ever_use
FROM youth_tobacco_survey
GROUP BY area;

-- 3. States with low awareness about e-cigarettes
SELECT state, area, e_cig_aware
FROM youth_tobacco_survey
WHERE area = 'Total' AND e_cig_aware < 20
ORDER BY e_cig_aware;

-- 4. Correlation between tobacco use and education (taught tobacco effects)
SELECT state, area, curr_tob_use, taught_tob_effects
FROM youth_tobacco_survey
WHERE area = 'Total'
ORDER BY taught_tob_effects DESC;

-- 5. States above average usage
WITH avg_usage AS (
    SELECT AVG(curr_tob_use) AS avg_curr_use
    FROM youth_tobacco_survey
    WHERE area = 'Total'
)
SELECT y.state, y.curr_tob_use
FROM youth_tobacco_survey y, avg_usage a
WHERE y.area = 'Total' AND y.curr_tob_use > a.avg_curr_use;

-- 6. Creating a view to monitor all smoking-related fields
CREATE VIEW smoking_stats AS
SELECT state, area, ever_smoke, curr_smoke, age_init_cig
FROM youth_tobacco_survey;

-- 7. Rank states by tobacco use
SELECT state, area, curr_tob_use,
       RANK() OVER (PARTITION BY area ORDER BY curr_tob_use DESC) AS rank_in_area
FROM youth_tobacco_survey;

-- 8. States where more than 30% of youth want to quit smoking
SELECT state, area, wantquit_smoke
FROM youth_tobacco_survey
WHERE wantquit_smoke > 30
  AND area = 'Total'
ORDER BY wantquit_smoke DESC;

-- 9. Calculate average bidi usage across Urban and Rural areas
SELECT area,
       ROUND(AVG(curr_bidi), 2) AS avg_curr_bidi,
       ROUND(AVG(ever_bidi), 2) AS avg_ever_bidi
FROM youth_tobacco_survey
WHERE area IN ('Urban', 'Rural')
GROUP BY area;

-- 10. Show change from Ever to Current tobacco usage
SELECT state, area,
       ROUND(ever_tob_use - curr_tob_use, 2) AS decrease_rate
FROM youth_tobacco_survey
WHERE area = 'Total'
ORDER BY decrease_rate DESC;

-- 11. Find states with high awareness but also high usage
SELECT state, curr_tob_use, e_cig_aware
FROM youth_tobacco_survey
WHERE curr_tob_use > 10 AND e_cig_aware > 50
  AND area = 'Total';

-- 12. High smoking despite being taught tobacco effects
SELECT state, curr_smoke, taught_tob_effects
FROM youth_tobacco_survey
WHERE curr_smoke > 10 AND taught_tob_effects > 50
  AND area = 'Total'
ORDER BY curr_smoke DESC;

-- 13. Overall average awareness and usage across the nation
SELECT 
    ROUND(AVG(e_cig_aware), 2) AS avg_awareness,
    ROUND(AVG(curr_tob_use), 2) AS avg_current_use,
    ROUND(AVG(wantquit_smoke), 2) AS avg_quit_interest
FROM youth_tobacco_survey
WHERE area = 'Total';

-- 14. Top 3 states where tobacco-free guidelines are most followed
SELECT state, tobacco_free_guideline
FROM youth_tobacco_survey
WHERE area = 'Total'
ORDER BY tobacco_free_guideline DESC
LIMIT 3;

-- 15. Find states with the strictest indoor/outdoor bans
SELECT state, ban_indoor, ban_outdoor
FROM youth_tobacco_survey
WHERE area = 'Total'
ORDER BY (ban_indoor + ban_outdoor) DESC
LIMIT 5;

-- 16. Compare refusal of sale across cigarette, bidi, and SLT
SELECT state, refused_cig_sale, refused_bidi_sale, refused_slt_sale
FROM youth_tobacco_survey
WHERE area = 'Total'
ORDER BY refused_cig_sale DESC;

--  17. Distribution Channel Analysis
SELECT state, source_cig_store, source_cig_paan, source_bidi_store, source_bidi_paan
FROM youth_tobacco_survey
WHERE area = 'Total'
ORDER BY source_cig_store DESC;

















































