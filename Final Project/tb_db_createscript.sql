/*
  607 Final Project tb database create script
*/

DROP SCHEMA IF EXISTS tb_prediction;
CREATE SCHEMA tb_prediction;
USE tb_prediction;

DROP TABLE IF EXISTS tb;
DROP TABLE IF EXISTS tb_rates;
DROP TABLE IF EXISTS cn_lookup;
DROP TABLE IF EXISTS life_exp;
DROP TABLE IF EXISTS percap_hc;
DROP TABLE IF EXISTS percap_gni;
DROP TABLE IF EXISTS perc_e_acc;
DROP TABLE IF EXISTS hdr_c_lookup;
DROP TABLE IF EXISTS yrs_school;

/*****************************************************************
 Create table to store original tb data as loaded via INFILE command
******************************************************************/
CREATE TABLE tb 
(
  country varchar(100) NOT NULL,
  year int NOT NULL,
  sex varchar(6) NOT NULL,
  child int NULL,
  adult int NULL,
  elderly int NULL
);

SELECT * FROM tb;

LOAD DATA INFILE 'c:/SQLData/tb.csv' 
INTO TABLE tb
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
(country, year, sex, @child, @adult, @elderly)
SET
child = nullif(@child,-1),
adult = nullif(@adult,-1),
elderly = nullif(@elderly,-1)
;

SELECT * FROM tb WHERE elderly IS NULL;
SELECT COUNT(*) FROM tb;


/*****************************************************************
 Create table to store tb rates once they are calculated in R
 
******************************************************************/

CREATE TABLE tb_rates 
(
  country varchar(100) NOT NULL,
  year int NOT NULL,
  rate float
);

/* TRUNCATE TABLE tb_rates; */

SELECT * FROM tb_rates;
SELECT COUNT(*) FROM tb_rates;


/****************************************************************
 Create lookup table for World Bank country names

*****************************************************************/

CREATE TABLE cn_lookup 
(
  tb_country varchar(100) NOT NULL,
  wb_country varchar(100) NOT NULL
);

/* TRUNCATE TABLE cn_lookup; */

/* Insert lookup data for World Bank country names */
INSERT INTO cn_lookup ( tb_country, wb_country ) 
VALUES 
('Bolivia (Plurinational State of)', 'Bolivia'),
('China, Hong Kong SAR', 'Hong Kong SAR, China'),
('Congo', 'Congo, Rep.'),
('Côte d\'Ivoire', 'Cote d\'Ivoire'),
('Democratic People\'s Republic of Korea', 'Korea, Dem. People\’s Rep.'),
('Democratic Republic of the Congo', 'Congo, Dem. Rep.'),
('Egypt', 'Egypt, Arab Rep.'),
('Iran (Islamic Republic of)', 'Iran, Islamic Rep.'),
('Kyrgyzstan', 'Kyrgyz Republic'),
('Lao People\'s Democratic Republic', 'Lao PDR'),
('Republic of Korea', 'Korea, Rep.'),
('Republic of Moldova', 'Moldova'),
('United Kingdom of Great Britain and Northern Ireland', 'United Kingdom'),
('United Republic of Tanzania', 'Tanzania'),
('United States of America', 'United States'),
('Venezuela (Bolivarian Republic of)', 'Venezuela, RB'),
('Viet Nam', 'Vietnam'),
('Yemen', 'Yemen, Rep.');


SELECT * FROM cn_lookup;
SELECT COUNT(*) FROM cn_lookup;

/*****************************************************************
 Create table to store life expectancies
 
******************************************************************/

CREATE TABLE life_exp 
(
  country varchar(100) NOT NULL,
  year int NOT NULL,
  life_exp float
);

/* TRUNCATE TABLE life_exp; */

SELECT * FROM life_exp;
SELECT COUNT(*) FROM life_exp;

/*****************************************************************
 Create table to store per capital healthcare spending
 
******************************************************************/

CREATE TABLE percap_hc 
(
  country varchar(100) NOT NULL,
  year int NOT NULL,
  percap_hc float
);

/* TRUNCATE TABLE percap_hc; */

SELECT * FROM percap_hc;
SELECT COUNT(*) FROM percap_hc;


/*****************************************************************
 Create table to store per capital gross national income
 
******************************************************************/

CREATE TABLE percap_gni 
(
  country varchar(100) NOT NULL,
  year int NOT NULL,
  percap_gni float
);

/* TRUNCATE TABLE percap_gni; */

SELECT * FROM percap_gni;
SELECT COUNT(*) FROM percap_gni;


/*****************************************************************
 Create table to store percentage of population w/ access to electricity
 
******************************************************************/

CREATE TABLE perc_e_acc
(
  country varchar(100) NOT NULL,
  year int NOT NULL,
  perc_e_acc float
);

/* TRUNCATE TABLE perc_e_acc; */

SELECT * FROM perc_e_acc;
SELECT COUNT(*) FROM perc_e_acc;

/****************************************************************
 Create lookup table for UN data set country names

*****************************************************************/

CREATE TABLE hdr_c_lookup 
(
  tb_country varchar(100) NOT NULL,
  hdr_country varchar(100) NOT NULL
);

/* TRUNCATE TABLE hdr_c_lookup; */

/* Insert lookup data for UN country names */
INSERT INTO hdr_c_lookup ( tb_country, hdr_country ) 
VALUES 
('China, Hong Kong SAR', 'Hong Kong, China (SAR)'),
('Democratic People\'s Republic of Korea', 'Korea (Democratic People\'s Rep. of)'),
('Democratic Republic of the Congo', 'Congo (Democratic Republic of the)'),
('Republic of Korea', 'Korea (Republic of)'),
('Republic of Moldova', 'Moldova (Republic of)'),
('United Kingdom of Great Britain and Northern Ireland', 'United Kingdom'),
('United Republic of Tanzania', 'Tanzania (United Republic of)'),
('United States of America', 'United States');


SELECT * FROM hdr_c_lookup;
SELECT COUNT(*) FROM hdr_c_lookup;

/*****************************************************************
 Create table to store mean years of school data
 
******************************************************************/

CREATE TABLE yrs_school
(
  country varchar(100) NOT NULL,
  year int NOT NULL,
  yrs_school float
);

/* TRUNCATE TABLE yrs_school; */

SELECT * FROM yrs_school;
SELECT COUNT(*) FROM yrs_school;

/****************************************************************
 Create lookup table for R's geoplotting country names

*****************************************************************/
DROP TABLE IF EXISTS rmap_lookup;

CREATE TABLE rmap_lookup 
(
  tb_country varchar(100) NOT NULL,
  rmap_country varchar(100) NOT NULL
);

/* TRUNCATE TABLE rmap_lookup; */

/* Insert lookup data for World Bank country names */
INSERT INTO rmap_lookup ( tb_country, rmap_country ) 
VALUES 
('Bolivia (Plurinational State of)', 'Bolivia'),
('China, Hong Kong SAR', 'Hong Kong'),
('Congo', 'Republic of Congo'),
('Côte d\'Ivoire', 'Ivory Coast'),
('Democratic People\'s Republic of Korea', 'North Korea'),
('Iran (Islamic Republic of)', 'Iran'),
('Lao People\'s Democratic Republic', 'Laos'),
('Republic of Korea', 'South Korea'),
('Republic of Moldova', 'Moldova'),
('Russian Federation', 'Russia'),
('Syrian Arab Republic', 'Syria'),
('United Kingdom of Great Britain and Northern Ireland', 'UK'),
('United Republic of Tanzania', 'Tanzania'),
('United States of America', 'USA'),
('Venezuela (Bolivarian Republic of)', 'Venezuela'),
('Viet Nam', 'Vietnam');



SELECT * FROM rmap_lookup;
SELECT COUNT(*) FROM rmap_lookup;
