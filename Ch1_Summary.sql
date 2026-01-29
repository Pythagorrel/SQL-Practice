-- ==========================================
-- CHAPTER 1: SINGLE TABLE BASICS
-- Goal: Master CRUD (Create, Read, Update, Delete)
-- ==========================================

-- 1. SETUP: Creating the Table
-- 'IF NOT EXISTS' prevents errors if you run the script twice.
CREATE TABLE IF NOT EXISTS inventory (
    chemical_name TEXT,
    bottles INTEGER,
    hazard_level INTEGER
);

-- 2. CREATE: Adding Data (INSERT)
INSERT INTO inventory VALUES ('Acetone', 5, 2);
INSERT INTO inventory VALUES ('HCl', 2, 3); -- Note: SQL is sensitive to string casing!
INSERT INTO inventory VALUES ('Water', 10, 0);

-- 3. READ: Viewing Data (SELECT)
-- The asterisk (*) acts as a wildcard for "All Columns"
SELECT * FROM inventory;

-- 4. UPDATE: Modifying Data
-- ALWAYS include a WHERE clause, or you will overwrite the entire table!
UPDATE inventory
SET bottles = 4
WHERE chemical_name = 'Acetone';

-- 5. DELETE: Removing Data
DELETE FROM inventory
WHERE chemical_name = 'Water';

-- Check status after modifications
SELECT * FROM inventory;

-- Advanced Update: Mathematical operations inside a query
-- "Set the new bottle count equal to the old count plus 5"
UPDATE inventory
SET bottles = bottles + 5
WHERE chemical_name = 'HCl'; 

-- ==========================================
-- DATA POPULATION FOR ANALYSIS
-- ==========================================
INSERT INTO inventory VALUES ('Methanol', 12, 3);
INSERT INTO inventory VALUES ('Ethanol', 8, 2);
INSERT INTO inventory VALUES ('Sulfuric Acid', 3, 3);
INSERT INTO inventory VALUES ('Sodium Hydroxide', 5, 3);
INSERT INTO inventory VALUES ('Distilled Water', 20, 0);
INSERT INTO inventory VALUES ('Saline Solution', 5, 0);

-- ==========================================
-- LOGIC & FILTERING
-- ==========================================

-- Logical Operators (AND / OR)
-- Both conditions must be true
SELECT * FROM inventory
WHERE hazard_level >= 3 AND bottles < 5;

-- Pattern Matching (LIKE)
-- % matches any sequence of characters
-- _ matches exactly one character
SELECT * FROM inventory 
WHERE chemical_name LIKE '%Acid%'; -- Contains "Acid" anywhere

SELECT * FROM inventory
WHERE chemical_name LIKE '%ol'; -- Ends with "ol" (e.g., Ethanol)

-- Sorting (ORDER BY)
-- ASC = Ascending (default), DESC = Descending
SELECT * FROM inventory
ORDER BY hazard_level DESC;

-- Multi-level Sorting
-- Sort by hazard first. If hazards are equal, break tie with name.
SELECT * FROM inventory
ORDER BY hazard_level DESC, chemical_name ASC;

-- Limiting Results
-- Useful for "Top N" lists
SELECT * FROM inventory
ORDER BY bottles DESC
LIMIT 3;

-- Range Filtering (BETWEEN / IN)
SELECT * FROM inventory
WHERE bottles BETWEEN 5 AND 10; -- Inclusive range

SELECT * FROM inventory
WHERE chemical_name IN ('Methanol', 'Ethanol', 'Distilled Water');

-- ==========================================
-- AGGREGATION & MATH
-- ==========================================

-- Basic Math Functions (SUM, AVG, MIN, MAX, COUNT)
-- 'AS' renames the output column (Aliasing)
SELECT SUM(bottles) AS Total_Inventory
FROM inventory;

SELECT AVG(hazard_level) AS Average_Hazard_Level
FROM inventory;

-- ==========================================
-- ADVANCED GROUPING (The Pivot Table)
-- ==========================================

-- DISTINCT
-- Returns unique values only (removes duplicates)
SELECT DISTINCT hazard_level
FROM inventory;

-- GROUP BY
-- Collapses rows sharing a value and applies math to them
SELECT hazard_level, SUM(bottles) AS Total_Bottles
FROM inventory
GROUP BY hazard_level;

-- GROUP BY with HAVING
-- WHERE filters rows BEFORE grouping.
-- HAVING filters groups AFTER math is done.
SELECT hazard_level, SUM(bottles) AS Total_Bottles
FROM inventory
GROUP BY hazard_level
HAVING SUM(bottles) > 20;

-- Complex Query Combination
-- 1. Filter rows (WHERE hazard > 0)
-- 2. Group them by hazard level
-- 3. Count chemicals in each group
-- 4. Sort the groups
SELECT hazard_level, COUNT(chemical_name) AS No_of_Chemicals
FROM inventory
WHERE hazard_level > 0
GROUP BY hazard_level
ORDER BY hazard_level DESC;