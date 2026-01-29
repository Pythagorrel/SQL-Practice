
--Basic Single Table Operations (Create,Read,Update,Delete)

CREATE TABLE IF NOT EXISTS inventory(
chemical_name TEXT,
bottles INTEGER,
hazard_level INTEGER
);

INSERT INTO inventory VALUES ('Acetone',5,2);
INSERT INTO inventory VALUES ('HCL',2,3);
INSERT INTO inventory VALUES ('Water',10,0); 

SELECT*FROM inventory;

SELECT*FROM inventory
WHERE hazard_level>1;

UPDATE inventory
SET bottles = 4
WHERE chemical_name = 'Acetone';

SELECT*FROM inventory; 

DELETE FROM inventory
WHERE chemical_name = 'Water';

SELECT*FROM inventory; 

UPDATE inventory
SET bottles = bottles+5
WHERE chemical_name = 'HCL'; --updates a value of a specfic cell in the table

SELECT*FROM inventory;

INSERT INTO inventory VALUES ('Methanol', 12,3); --Adds news rows to the table under the column headings
INSERT INTO inventory VALUES ('Ethanol',8,2);
INSERT INTO inventory VALUES ('Sulfuric Acid',3,3);
INSERT INTO inventory VALUES ('Sodium Hydroxide',5,3);
INSERT INTO inventory VALUES ('Distilled Water',20,0);
INSERT INTO inventory VALUES ('Saline Solution',5,0); 

SELECT*FROM inventory; --Shows all rows 

-- Basic Single Table Logic and Math Operations-- 

SELECT*FROM inventory
WHERE hazard_level >=3 AND bottles < 5; --All rows that fulfil both conditions

SELECT*FROM inventory 
WHERE chemical_name LIKE '%Acid%'; --Shows all rows where name has 'Acid'

SELECT*FROM inventory
WHERE chemical_name LIKE '%ol'; --Shows all rows with name ending in -ol

SELECT*FROM inventory
ORDER BY hazard_level DESC; --Shows all rows from inventory ordered by descending hazard numbers

SELECT*FROM inventory
ORDER BY hazard_level DESC, chemical_name ASC; --all rows ordered first by descending hazard number, and where hazard numbers are equal, alphabetical order

SELECT*FROM inventory
ORDER BY bottles DESC
LIMIT 3; --returns top three results 

SELECT SUM(bottles) AS Total_Inventory
FROM inventory; --sums column and renames output from SUM(bottles) to Total_Inventory

SELECT AVG(hazard_level) AS Average_Hazard_Level
FROM inventory; 

SELECT*FROM inventory
WHERE bottles BETWEEN 5 AND 10; 

SELECT*FROM inventory
WHERE chemical_name IN ('Methanol','Ethanol','Distilled Water'); --only shows the rows with these chemical names 

SELECT*FROM inventory
WHERE hazard_level = 3 AND bottles<10
ORDER BY bottles ASC;

--Distinct and Group By 

SELECT DISTINCT hazard_level
FROM inventory; --returns the unique values, eliminates redundancy and shows categories rather than individual numbers

SELECT hazard_level, SUM(bottles) AS Total_Bottles
FROM inventory
GROUP BY hazard_level; --chooses column, math, from table_name. Groups by column

SELECT hazard_level, SUM(bottles) AS Total_Bottles
FROM inventory
GROUP BY hazard_level
HAVING SUM(bottles) >20; --'HAVING' filters GROUPED ROWS; 'WHERE' filters individual rows BEFORE grouping

SELECT hazard_level, COUNT(chemical_name) AS No_of_Chemicals
FROM inventory
WHERE hazard_level>0
GROUP BY hazard_level
ORDER BY hazard_level DESC; 