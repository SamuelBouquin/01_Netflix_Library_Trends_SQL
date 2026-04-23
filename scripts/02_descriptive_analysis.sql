/*
-----------------------------------------------------------------------------------------------
Script:      02_descriptive_analysis.sql
Project:     01_Netflix_Library_Trends_SQL
Server:      PostgreSQL 18
Database:    01_netflix_library_trends_db
Author:      Samuel Bouquin
Date:        April 2026
Description: Performs a high-level audit of the Netflix library. This script utilizes 
             STRING_TO_ARRAY and UNNEST functions to normalize comma-separated strings 
             (like countries and genres) to extract accurate, aggregated insights.
             Aliases are formatted in Proper Case so the exported CSVs are easy for non-technical users to read.
-----------------------------------------------------------------------------------------------
*/

-- ============================================================================
-- 1. Content Distribution: Movies vs. TV Shows
-- ============================================================================
-- Calculates the absolute volume and relative percentage of each content type.
SELECT 
    type AS "Content Type", 
    COUNT(*) AS "Total Count",
    -- Calculates percentage dynamically by dividing the group count by the total table count.
    -- Multiplying by 100.0 implicitly casts the integer to a decimal to prevent rounding errors.
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM netflix_titles), 2) AS "Percentage"
FROM netflix_titles
GROUP BY type
ORDER BY "Total Count" DESC;


-- ============================================================================
-- 2. Top 10 Contributing Countries
-- ============================================================================
-- The 'country' column often contains multiple countries separated by commas (e.g., "United States, India").
-- This query normalizes that data on the fly to ensure co-productions are counted individually.
SELECT 
    -- STRING_TO_ARRAY splits the string by comma into an array.
    -- UNNEST expands that array into individual rows.
    -- TRIM removes any lingering leading/trailing whitespace left after the split.
    TRIM(UNNEST(STRING_TO_ARRAY(country, ','))) AS "Country Name", 
    COUNT(*) AS "Content Count"
FROM netflix_titles
-- Filter out NULL values prior to aggregation to maintain data integrity.
WHERE country IS NOT NULL
GROUP BY "Country Name"
ORDER BY "Content Count" DESC
LIMIT 10;


-- ============================================================================
-- 3. Genre Popularity (Top 10)
-- ============================================================================
-- Similar to the country query, the 'listed_in' column contains comma-delimited genre tags.
-- Normalizing this allows us to see the true frequency of individual genres across the platform.
SELECT 
    TRIM(UNNEST(STRING_TO_ARRAY(listed_in, ','))) AS "Genre", 
    COUNT(*) AS "Genre Count"
FROM netflix_titles
WHERE listed_in IS NOT NULL
GROUP BY "Genre"
ORDER BY "Genre Count" DESC
LIMIT 10;