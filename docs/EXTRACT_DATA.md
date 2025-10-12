# 🧩 Step 1 – Data Extraction

## 🗂️ Overview

The **Data Extraction** phase represents the foundation of the project.  
Its goal is to take the original dataset — containing worldwide living cost indicators — and transform it into a **structured relational database** designed for efficient querying, consistency, and future scalability.

The raw dataset contained **city-level cost-of-living data** with hundreds of characteristics such as rent prices, food costs, utilities, and leisure expenses.  
Since this data was unstructured (flat CSV file), we designed a **normalized relational schema** to ensure data integrity and eliminate redundancy.

---


## 🧭 Column Mapping & Categorization

### 🧩 1. Mapping Columns
A manual **mapping file** (`mapping-columns.csv`) was created to assign meaningful names and categories to each raw column:
- `x1 → apartment_(1_bedroom)_in_city_centre_(usd)`
- `x2 → apartment_(1_bedroom)_outside_of_centre_(usd)`
- `x3 → meal_inexpensive_restaurant_(usd)`
- … and so on.

This mapping was stored in  
`data/processed/sql/characteristics_mapped.csv`,  
which associates each raw column with:
- **Characteristic name** (`descar`)
- **Category** (`descat`)
- **Unique characteristic ID** (`idcara`)

---

### 🗂️ 2. Categorization
To organize data consistently, all characteristics were grouped into **five main categories**:

| Category                      | Description                           |
|-------------------------------|---------------------------------------|
| **Apartments / Real Estate**  | Housing prices and rent               |
| **Food & Restaurants**        | Grocery and restaurant costs          |
| **Transportation**            | Public and private transport expenses |
| **Leisure & Sports**          | Entertainment and fitness activities  |
| **Utilities & Internet**      | Monthly utilities, internet, and bills|

Each characteristic in the dataset (`regcar`) was linked to one of these categories (`regcat`), ensuring hierarchical organization and simplifying analytical queries.

---

## 🏗️ Database Design

### 🧱 Database Technology
We used **MySQL 8.0**, running inside a **Docker container**, to guarantee reproducibility and easy deployment across environments.  
This approach isolates the database from the host system and allows version control through SQL schema files stored in the repository.

### 🗺️ ER Model

The relational model is based on **four main tables**, normalized to reduce redundancy and improve data consistency:

- **`regcit`** → Registry of cities and countries.  
- **`regcat`** → Registry of characteristic categories (e.g., *Food*, *Housing*, *Transport*).  
- **`regcar`** → Registry of characteristics (e.g., *apartment_rent_usd*, *meal_inexpensive_restaurant*).  
- **`valcar`** → Stores the actual numeric values for each city–characteristic pair.

Relationships:
- `regcar` → `regcat` via `idncat`
- `valcar` → `regcit` via `idncity`
- `valcar` → `regcar` via `idcara`

Each record in **`valcar`** represents a unique *value of a characteristic for a specific city*.

---

## ⚙️ ETL Workflow

The extraction and loading process was implemented through **Python notebooks** located in  
`/notebooks/database` and `scripts/utils.py`.

### 🪶 Steps

1. **Data Loading**  
   - Load raw `.csv` datasets from `data/raw/`.  
   - Clean and standardize column names and encodings.

2. **Mapping**  
   - Align dataset columns with database characteristics (`regcar`).  
   - Use mapping files stored in `data/processed/sql/`.

3. **Database Insertion**  
   - Insert data into normalized tables (`regcit`, `regcat`, `regcar`, `valcar`).  
   - Handle `AUTO_INCREMENT` and foreign keys manually for full control.  
   - Skip duplicates and maintain integrity through controlled insert logic.

4. **Validation**  
   - Query the database to confirm consistent row counts and foreign key relationships.  
   - Verify data alignment between CSV headers and database mappings.

---

## 🧮 Why a Relational Database?

Using a **MySQL relational schema** offers several advantages:

- ✅ **Data integrity** through primary and foreign keys.  
- ✅ **Scalability** for future updates (adding new cities or characteristics).  
- ✅ **Reproducibility** — anyone can rebuild the database by running the notebooks.  
- ✅ **Compatibility** with Power BI, allowing live connections for visualization.

---

## 📊 Output Summary

After running the extraction pipeline:

- **4,874 cities**  
- **44 standardized characteristics**  
- **~40,000 total value entries (`valcar`)**

All data are now structured and ready for **Step 2: Data Cleaning**, which is performed directly through SQL views (`vw_valcar` and `vw_valcar_cleaned`).

Step 2 - Data Cleaning: [`docs\CLEANING_DATA.md`](./CLEANING_DATA.md)
