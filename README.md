---
File:        README.md
Project:     01_Netflix_Library_Trends_SQL
Author:      Samuel Bouquin
Date:        April 2026
Description: Project overview, technical highlights, and key insights for the 
             Netflix library audit.
---

# Netflix Library Trends: SQL Audit

## Project Overview
This project performs a high-level audit of the Netflix content library using a dataset from Kaggle. The goal was to practice the full "Data Ingestion to Insight" pipeline using PostgreSQL. 

The analysis focuses on content distribution, geographic production trends, and genre popularity. A key part of this project was handling "messy" data—specifically, columns containing multiple values separated by commas—without over-complicating the database structure.

## Key Insights
Based on the SQL analysis of the library:

* **Content Split:** The library is significantly weighted toward cinema, with **Movies** making up **69.62%** of the catalog, while **TV Shows** account for **30.38%**.
* **Top Producers:** The **United States** leads production (3,690 titles), followed by **India** (1,046) and the **United Kingdom** (806).
* **Genre Trends:** **International Movies** and **Dramas** are the most frequent genres on the platform, indicating a heavy focus on global cinematic content.

## Data Source
The dataset used in this project is the **Netflix Movies and TV Shows** dataset, which is publicly available on Kaggle. It contains a listing of all the movies and TV shows available on Netflix as of 2021.

* **Source:** [Kaggle - Netflix Movies and TV Shows](https://www.kaggle.com/datasets/shivamb/netflix-shows)
* **Dataset Author:** Shivam Bansal

## Technical Decisions & Troubleshooting
To keep the project practical and effective for a beginner portfolio, I made the following choices:

* **Date Formatting:** In `01_create_table.sql`, I imported the `date_added` column as a `VARCHAR`. This prevented the import from crashing due to inconsistent date strings in the raw CSV.
* **Data Normalization:** Rather than building a complex multi-table database with bridge tables, I used PostgreSQL functions like `STRING_TO_ARRAY` and `UNNEST`. This allowed me to split comma-separated genres and countries "on the fly" to get accurate counts while keeping the database simple.
* **Naming Conventions:** I renamed the original 'cast' column to `cast_members` to avoid conflicts with the SQL `CAST` keyword, ensuring the scripts are stable and error-free.

## Project Structure
```text
01_Netflix_Library_Trends_SQL/
├── data/
│   └── netflix_titles.csv           # Raw source data (Kaggle)
├── docs/
│   └── data-dictionary.md           # Schema definitions & logic notes
├── images/
│   ├── pgadmin_schema_tree.png      # Database architecture proof
│   ├── query_01_distribution.png    # SQL execution proof (Distro)
│   ├── query_02_countries.png       # SQL execution proof (Countries)
│   └── query_03_genres.png          # SQL execution proof (Genres)
├── results/
│   ├── 01_content_distribution.csv  # Exported findings
│   ├── 02_top_10_countries.csv      # Exported findings
│   └── 03_top_10_genres.csv         # Exported findings
├── scripts/
│   ├── 01_create_table.sql          # DDL Script
│   └── 02_descriptive_analysis.sql  # DML/Analysis Script
├── .gitignore                       # File exclusion rules
└── LICENSE                          # MIT License
```
* **`data/`**: Contains the raw `netflix_titles.csv` source file.
* **`docs/`**: Includes the `data-dictionary.md` which defines all columns and data types.
* **`images/`**: Screenshots of the pgAdmin 4 schema and the execution of all three queries.
* **`results/`**: Final CSV exports of the analysis for easy viewing without a database tool.
* **`scripts/`**: The SQL files used to create the table and perform the descriptive analysis.
* **`.gitignore` & `LICENSE`**: Standard repository files to manage workspace cleanliness and usage rights.

## Prerequisites
To run the scripts in this repository, you will need:
* **PostgreSQL (v15 or higher):** The database engine used to store and query the data.
* **pgAdmin 4:** The management tool used to run scripts and import CSV files.

## How to Use This Project
1.  **Setup:** Create a database in pgAdmin 4 titled `01_netflix_library_trends_db`.
2.  **Table Creation:** Run `scripts/01_create_table.sql` to build the schema.
3.  **Import:** Use the pgAdmin Import/Export tool to load `data/netflix_titles.csv` into the new table (ensure "Header" is toggled ON).
4.  **Analysis:** Execute `scripts/02_descriptive_analysis.sql` to generate the library insights.

## Project Limitations
While this project successfully provides a high-level audit, there are a few limitations to keep in mind:
* **Dataset Currency:** The data is a snapshot from 2021. It does not reflect Netflix’s current library, recent content acquisitions, or the introduction of ad-supported tiers.
* **Flat Data Structure:** For simplicity, the data was kept in a single table. In a production environment, this data would ideally be normalized into separate tables (e.g., Genres, Countries, and Directors) to reduce redundancy and improve data integrity.
* **Data Completeness:** Several entries in the director and cast_members columns contain null or missing values, which can slightly skew totals for those specific categories.

## Future Improvements & Learnings
This project served as a foundational exercise in SQL data ingestion and analysis. Future iterations or similar projects could include:
* **Advanced Analytics:** Implementing window functions to analyze trends over time, such as the growth of specific genres year-over-year.
* **Database Normalization:** Rebuilding the database into 3rd Normal Form (3NF) to practice more complex table relationships and JOIN operations.
* **Dashboard Integration:** Connecting this PostgreSQL database to a visualization tool like Power BI or Tableau to turn these static results into an interactive business dashboard.
* **Key Learning:** A major takeaway from this project was the importance of data types during the ingestion phase. Handling inconsistent date strings by initially importing them as VARCHAR saved significant troubleshooting time and taught me the value of a flexible staging process.

## Contact Info
**Email:** sambouquin@gmail.com

Distributed under the MIT License. See LICENSE for more information.