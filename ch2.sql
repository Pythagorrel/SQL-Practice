-- ==========================================
-- CHAPTER 2, PART 1: RELATIONAL BASICS
-- Concepts: Primary Keys (PK), Foreign Keys (FK), and JOINs
-- ==========================================

-- 0. SAFETY FIRST
-- By default, SQLite allows you to break links between tables.
-- We turn this ON to ensure data integrity (ACID compliance).
PRAGMA foreign_keys = ON;

-- ==========================================
-- 1. PARENT TABLE (The Reference)
-- ==========================================
-- This table holds the "Scientific Truths."
-- The 'cas_number' is our PRIMARY KEY (PK).
-- CONCEPT: The PK is the unique ID for a row. It acts as an "address"
-- that other tables can point to. It often stays hidden in the backend
-- while we use it to link data.

CREATE TABLE IF NOT EXISTS chemical_properties (
    cas_number TEXT PRIMARY KEY, -- Implicitly NOT NULL and UNIQUE
    name TEXT NOT NULL,          -- Must have a name
    formula TEXT,                -- Optional
    molar_mass REAL              -- Optional
);

-- ==========================================
-- 2. CHILD TABLE (The Inventory)
-- ==========================================
-- This table holds the "Physical Items."
-- It uses a FOREIGN KEY (FK) to point back to the Parent table.

CREATE TABLE IF NOT EXISTS lab_inventory (
    inventory_id INTEGER PRIMARY KEY, -- Auto-incrementing ID for the bottle itself
    cas_number TEXT NOT NULL,         -- The Link (Foreign Key)
    bottles INTEGER CHECK (bottles >= 0),
    location TEXT,

    -- THE HANDSHAKE (Constraint)
    -- This line ensures we cannot add a chemical that doesn't exist in our reference.
    FOREIGN KEY (cas_number) REFERENCES chemical_properties(cas_number)
);

-- ==========================================
-- 3. BULK INSERT (The "New Method")
-- ==========================================
-- Instead of writing "INSERT INTO..." three separate times,
-- we can list multiple value groups separated by commas.
-- This is faster and cleaner.

INSERT INTO chemical_properties (cas_number, name, formula, molar_mass)
VALUES 
    ('67-64-1', 'Acetone', 'C3H6O', 58.08),
    ('7647-01-0', 'Hydrochloric Acid', 'HCl', 36.46),
    ('7732-18-5', 'Water', 'H2O', 18.015);

-- Populating the child table using the CAS keys
INSERT INTO lab_inventory (cas_number, bottles, location)
VALUES 
    ('67-64-1', 5, 'Flammables Cabinet'),
    ('67-64-1', 10, 'Store Room'),        -- Note: Same CAS, different location
    ('7647-01-0', 2, 'Acids Cabinet'),
    ('7732-18-5', 20, 'General Shelf');

-- ==========================================
-- 4. THE GRAND UNIFIED QUERY (JOIN)
-- ==========================================
-- Goal: See the Name (from Parent) and Location (from Child) together.
-- METHOD: We use the shared 'cas_number' to stitch rows together.

SELECT 
    chemical_properties.name,
    lab_inventory.location,
    lab_inventory.bottles,
    -- We can perform math across tables!
    (lab_inventory.bottles * chemical_properties.molar_mass) AS total_mass_grams
FROM lab_inventory
JOIN chemical_properties USING (cas_number); 

-- NOTE ON 'USING':
-- Because we named the column 'cas_number' in BOTH tables, we can use 
-- the shortcut 'USING (cas_number)' instead of the longer 
-- 'ON lab_inventory.cas_number = chemical_properties.cas_number'.