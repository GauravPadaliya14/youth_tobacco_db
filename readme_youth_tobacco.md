
![tobacco](https://github.com/user-attachments/assets/5af56ac8-7c6a-48d2-a4d0-3543d8d2bf91)



# Youth Tobacco Survey SQL Project

This project analyzes data from a comprehensive survey on youth tobacco usage across Indian states. It leverages a wide range of SQL queries to uncover insights into smoking habits, awareness, policy enforcement, and tobacco product exposure.

---

## 📁 Database Name

`youth_tobacco_db`

## 📦 Table Name

`youth_tobacco_survey`

---

## 🧱 Table Columns Overview

- `state` – Indian state name
- `area` – Area type: Total / Urban / Rural
- `curr_tob_use` – Current tobacco usage (%)
- `ever_tob_use` – Ever used tobacco (%)
- `curr_smoke`, `ever_smoke`, `curr_cig`, `curr_bidi` – Smoking indicators
- `e_cig_aware`, `taught_tob_effects` – Awareness levels
- `ban_indoor`, `ban_outdoor`, `aware_cotpa` – Policy indicators
- ... and 50+ more insightful fields

---

## 🧪 Sample Queries and Insights

### 1. **Top 5 States by Current Tobacco Use**

```sql
SELECT state, area, curr_tob_use FROM youth_tobacco_survey
WHERE area = 'Total' ORDER BY curr_tob_use DESC LIMIT 5;
```

> 🔍 *Identifies regions with highest youth tobacco use for targeted intervention.*

### 2. **Average Tobacco Use by Area**

```sql
SELECT area, AVG(curr_tob_use), AVG(ever_tob_use) FROM youth_tobacco_survey GROUP BY area;
```

> 📊 *Compares usage across Urban vs Rural vs Total populations.*

### 3. **Low E-Cigarette Awareness States**

```sql
SELECT state, e_cig_aware FROM youth_tobacco_survey WHERE area = 'Total' AND e_cig_aware < 20;
```

> ⚠️ *Pinpoints states needing awareness campaigns.*

### 4. **Correlation: Education vs Usage**

```sql
SELECT state, curr_tob_use, taught_tob_effects FROM youth_tobacco_survey WHERE area = 'Total';
```

> 🎓 *Explores whether anti-tobacco education influences behavior.*

### 5. **Above-Average Tobacco Use**

```sql
WITH avg_use AS (
  SELECT AVG(curr_tob_use) AS avg_curr FROM youth_tobacco_survey WHERE area = 'Total')
SELECT state, curr_tob_use FROM youth_tobacco_survey, avg_use
WHERE area = 'Total' AND curr_tob_use > avg_curr;
```

> 🧠 *Highlights states with usage above national average.*

### 6. **Create View: Smoking Stats**

```sql
CREATE VIEW smoking_stats AS
SELECT state, area, ever_smoke, curr_smoke, age_init_cig FROM youth_tobacco_survey;
```

> 🗃️ *Reusable summary view for smoking-focused analysis.*

### 7. **Rank States by Tobacco Use (Window Function)**

```sql
SELECT state, area, curr_tob_use,
RANK() OVER (PARTITION BY area ORDER BY curr_tob_use DESC) AS rank_in_area
FROM youth_tobacco_survey;
```

> 🏆 *Ranks each state within its area group.*

### 8. **Desire to Quit Smoking > 30%**

```sql
SELECT state, wantquit_smoke FROM youth_tobacco_survey WHERE wantquit_smoke > 30;
```

> ❤️ *Shows positive intent to quit among youth.*

### 9. **Difference: Ever vs Current Tobacco Use**

```sql
SELECT state, (ever_tob_use - curr_tob_use) AS diff FROM youth_tobacco_survey;
```

> 📉 *Reveals drop-off in continued usage — potential for prevention.*

### 10. **Distribution Channels**

```sql
SELECT state, source_cig_store, source_bidi_store FROM youth_tobacco_survey;
```

> 🛒 *Understand common purchase points of tobacco.*

### 11. **Strictest Ban States**

```sql
SELECT state, ban_indoor, ban_outdoor FROM youth_tobacco_survey
ORDER BY (ban_indoor + ban_outdoor) DESC LIMIT 5;
```

> 🛑 *Recognizes states with highest policy enforcement.*

---

## 📈 Project Potential

- Integrate with **Tableau/Power BI** for interactive dashboards
- Use data storytelling to show **impact of education, awareness, and enforcement**
- Deploy as a portfolio SQL project on **GitHub**

---

## ✅ Tech Used

- MySQL 8.0+
- SQL Views, CTEs, Aggregates, Filtering, Joins, Ranking Functions

---

## 📎 License

MIT License

---

## 📬 Author

*Gaurav – Aspiring Data Analyst*

Feel free to fork this repo and extend it with new analysis, visualizations, or datasets.

