-- =========================================
-- DATABASE CREATION DOCUMENTATION
-- =========================================
-- This SQL file documents the creation of the database
-- for the Cost of Living project.
-- The database is intended to store datasets from the CSV
-- files with mapped and standardized columns.
-- Environment: MySQL in Docker container
-- =========================================

-- 1. Create the database
CREATE DATABASE IF NOT EXISTS cost_of_living_db
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

-- 2. Use the database
USE cost_of_living_db;

-- 3. Create tables
-- a. cities_registry table
CREATE TABLE IF NOT EXISTS regcit (
    idncity INT PRIMARY KEY AUTO_INCREMENT COMMENT 'Unique identifier for each city',
    namecit VARCHAR(100) NOT NULL COMMENT 'Name of the city',
    country VARCHAR(100) NOT NULL COMMENT 'Name of the country'
) COMMENT='Registry of cities and their respective countries';


-- b. categories_registry table
CREATE TABLE IF NOT EXISTS regcat (
    idncat INT PRIMARY KEY AUTO_INCREMENT COMMENT 'Unique ID for each category',
    descat VARCHAR(100) NOT NULL COMMENT 'Description of the category (e.g., Food, Transport)'
) COMMENT='Master table for characteristic categories';

-- c. caracteristics_registry table
CREATE TABLE IF NOT EXISTS regcar (
    idcara INT PRIMARY KEY AUTO_INCREMENT COMMENT 'Unique identifier for each characteristic',
    descar VARCHAR(255) NOT NULL COMMENT 'Description of the characteristic',
    idncat INT NOT NULL COMMENT 'References regcat.idncat',
    CONSTRAINT fk_catego FOREIGN KEY (idncat) REFERENCES regcat(idncat)
) COMMENT='Registry of characteristics for cities (columns of dataset)';

-- c.  city values tables
CREATE TABLE IF NOT EXISTS valcar (
    idnval INT PRIMARY KEY AUTO_INCREMENT COMMENT 'PK',
    idncity INT NOT NULL COMMENT 'City reference',
    idcara INT NOT NULL COMMENT 'Caracteristic reference',
    cvalue DECIMAL(12,2) COMMENT 'Caracteristic value for the city(USD)',
    CONSTRAINT fk_city
        FOREIGN KEY (idncity) REFERENCES regcit(idncity)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_idcara
        FOREIGN KEY (idcara) REFERENCES regcar(idcara)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) COMMENT='Values of characteristics for each city, grouped by category';

