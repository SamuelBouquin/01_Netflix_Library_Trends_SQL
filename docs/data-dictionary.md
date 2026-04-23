---
File:        data-dictionary.md
Project:     01_Netflix_Library_Trends
Database:    01_netflix_library_trends_db
Author:      Samuel Bouquin
Date:        April 2026
Description: Defines the columns and data types for the raw Netflix dataset. 
             Includes brief notes on why certain data types were chosen to make 
             the import process easier.
---

# Data Dictionary: `netflix_titles`

This table holds the raw Kaggle dataset. It provides a straightforward list of movies and TV shows available on Netflix.

| Column Name | Data Type | Description | Setup Notes |
| :--- | :--- | :--- | :--- |
| `show_id` | VARCHAR(10) | Unique ID for each title (e.g., 's1', 's2'). | **Primary Key.** |
| `type` | VARCHAR(20) | Content category. | Only contains 'Movie' or 'TV Show'. |
| `title` | VARCHAR(150) | Official title of the movie or show. | |
| `director` | VARCHAR(250) | Director(s) of the content. | Often contains multiple names separated by commas. |
| `cast_members` | TEXT | Actors in the movie or show. | Renamed from 'cast' to avoid conflicts with the SQL `CAST` keyword. Kept as `TEXT` for unlimited length. |
| `country` | VARCHAR(150) | Country of production. | Often has multiple countries. These were split during analysis for accurate counts. |
| `date_added` | VARCHAR(50) | Date the title was added to Netflix. | Kept as `VARCHAR` to ensure a successful CSV import despite inconsistent date formatting. |
| `release_year` | INT | Original release year. | Stored as an integer for easy numerical filtering. |
| `rating` | VARCHAR(15) | TV/Movie rating (e.g., PG-13, R). | |
| `duration` | VARCHAR(20) | Total length of the content. | Unit varies: 'min' for movies, 'Seasons' for shows. |
| `listed_in` | VARCHAR(150) | Genres the content belongs to. | Multi-value strings split during analysis using SQL functions. |
| `description` | TEXT | Brief summary of the content. | |

## Data Setup Notes

**Keeping it Simple:** For this project, I maintained the data in a single table to mirror the original CSV. Since the goal is descriptive analysis, a single-table (flat) structure is more efficient for generating quick insights than building a complex multi-table database.

**Handling Multi-Value Columns:** Columns like `country` and `listed_in` often pack several values into one cell. Rather than redesigning the entire database to fix this, I used PostgreSQL's `STRING_TO_ARRAY` and `UNNEST` functions. This allowed me to "expand" the data during the query process, ensuring that every country and genre was counted accurately without over-complicating the initial setup.