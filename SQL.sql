INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_vigneron', 'vigneron', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_vigneron', 'vigneron', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES 
 	('society_vigneron', 'vigneron', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('vigneron', 'vigneron')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('vigneron', 0, 'stage', 'Stagiare', 0, '{}', '{}'),
	('vigneron', 1, 'novice', 'Vigneron', 0, '{}', '{}'),
	('vigneron', 2, 'gerant','Gérant', 0, '{}', '{}'),  
	('vigneron', 3, 'boss', 'Patron', 0, '{}', '{}')
;