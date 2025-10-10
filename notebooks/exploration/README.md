# 🧹 Data Cleaning & Exploration

## Overview
After building the database and mapping all characteristics, a deep **data cleaning** phase was performed directly on SQL views.  
The goal was to ensure **data consistency**, remove **invalid or missing values**, and prepare a **reliable analytical base** for further transformations and Power BI visualization.

### Cleaning process included:
- Removing null and negative values from the dataset  
- Standardizing city and country names (proper case formatting)  
- Normalizing characteristic names (underscores replaced with spaces, currency tags removed)  
- Filtering out duplicates and empty text fields  

All cleaned data are now accessible through the SQL view:

`vw_valcar_cleaned`

This view provides a unified dataset combining:
- City and Country  
- Characteristic (parameter)  
- Category  
- Mean Price (numerical value)

---

## 🧾 Dataset Summary After Cleaning
- **Total records:** ~40,000  
- **Distinct cities:** 910  
- **Distinct characteristics:** 44  
- **Distinct categories:** 6  

The dataset is now **clean**, **relationally consistent**, and **ready for analysis and visualization**.

---

## 📊 Distribution by Category

The following chart represents the **distribution of cleaned records by category** (number of data points per category).  
It provides a first overview of how balanced the dataset is after the cleaning process.

![Category Distribution Histogram](docs/images/DistributionByCategory.png)

---

## 💡 Next Steps
1. Further exploration of cleaned data (`09_explore_cleaned_data.ipynb`)  
2. Data transformation and KPI computation (Step 3 of pipeline)  
3. Integration with Power BI for advanced analysis and dashboarding  
