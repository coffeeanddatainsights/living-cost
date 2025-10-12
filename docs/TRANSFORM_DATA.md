## 📊 Transform & KPI Calculation

In this phase, we created derived views and calculated KPIs to compare the cost of living across cities and categories. All transformations use the cleaned view `vw_valcar_cleaned` as the source of truth.

### Main View: `vw_valcar_transformed`

This view contains all cleaned columns and calculated KPIs:

| Column             | Description                                                                                      |
|--------------------|--------------------------------------------------------------------------------------------------|
| CityName           | Name of the city                                                                                 |
| Country            | Country of the city                                                                              |
| Category           | Category of the characteristic (e.g., Food, Transport, Utilities)                                |
| Parameter          | Description of the specific characteristic (e.g., Milk, Rent)                                    |
| MeanPrice          | Average price of the characteristic (USD)                                                        |
| NormalizedPrice    | Price normalized relative to the category average: `MeanPrice / AVG(MeanPrice)`                  |
| CategoryRank       | Ranking of the city within the same category (cheaper city = rank 1)                             |
| WeightedPrice      | Category-weighted price: `MeanPrice * weight`, where `weight` is defined in `weicat`             |
| CityCostIndex      | Synthetic index of the city’s cost of living: sum of `WeightedPrice` per city                    |

### Technical Notes

- The view uses **window functions** (`AVG() OVER`, `RANK() OVER`) to calculate `NormalizedPrice` and `CategoryRank`.  
- The `CityCostIndex` column is a weighted sum of prices by category.  
- Category weights are defined in the `weicat` table and allow emphasizing certain categories in the overall cost of living assessment.  
- All transformations are **idempotent** and do not modify the raw data in `valcar`.

### Generated Artifacts

- **SQL View:** `database/sql/views/vw_valcar_transformed.sql`