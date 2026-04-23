/*
-----------------------------------------------------------------------------------------------
Script:      01_create_table.sql
Project:     01_Netflix_Library_Trends
Server:      PostgreSQL 18
Database:    01_netflix_library_trends_db
Author:      Samuel Bouquin
Date:        April 2026
Description: Creates the foundational table to hold the raw Netflix Kaggle dataset. 
             Data types are intentionally kept broad (VARCHAR) for the date_added column 
             to ensure a frictionless import process before analysis.
-----------------------------------------------------------------------------------------------
*/

-- Drop table if it already exists to allow for clean re-runs of this script without errors
DROP TABLE IF EXISTS netflix_titles;

-- Create the foundational table matching the Kaggle CSV structure
CREATE TABLE netflix_titles (
    show_id VARCHAR(10) PRIMARY KEY, -- Unique alphanumeric ID provided by Kaggle (e.g., 's1', 's2')
    type VARCHAR(20),                -- Content category: strictly 'Movie' or 'TV Show'
    title VARCHAR(150),              -- Official title of the content
    director VARCHAR(250),           -- Director(s); can contain multiple comma-separated names
    cast_members TEXT,               -- Stored as TEXT rather than VARCHAR due to highly variable length of cast lists
    country VARCHAR(150),            -- Country of production; frequently contains comma-separated values
    date_added VARCHAR(50),          -- Stored as VARCHAR to bypass PostgreSQL import errors caused by dirty date formatting in raw CSV
    release_year INT,                -- Original release year stored as a standard 4-digit integer
    rating VARCHAR(15),              -- TV/Movie rating standard (e.g., 'PG-13', 'TV-MA')
    duration VARCHAR(20),            -- Duration string (e.g., '90 min', '2 Seasons')
    listed_in VARCHAR(150),          -- Comma-separated list of genres the content falls under
    description TEXT                 -- Full text description/synopsis of the content
);

-- ==============================================================================================
-- POST-EXECUTION INSTRUCTIONS: 
-- Note: Use PostgreSQL pgAdmin 4 Import/Export option to load 'netflix_titles.csv' before running Script 02.
-- 1. Refresh the schema tree in pgAdmin 4.
-- 2. Right-click the 'netflix_titles' table -> Import/Export Data.
-- 3. Import 'netflix_titles.csv' with 'Header' set to 'Yes' and 'Delimiter' set to ',' (comma).
-- ==============================================================================================

