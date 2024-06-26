--======Mvemba(Old Kongo Leader)======--

-- Mvemba military unit get forest and jungle free move instead of Ngao
DELETE FROM UnitAbilityModifiers WHERE ModifierId='NAGAO_FOREST_MOVEMENT';

INSERT INTO Modifiers(ModifierId, ModifierType) VALUES
    ('BBG_MILITARY_UNITS_IGNORE_WOODS', 'MODIFIER_PLAYER_UNITS_GRANT_ABILITY');
INSERT INTO ModifierArguments(ModifierId, Name, Value) VALUES
    ('BBG_MILITARY_UNITS_IGNORE_WOODS', 'AbilityType', 'BBG_IGNORE_WOODS_ABILITY');
INSERT INTO TraitModifiers(TraitType, ModifierId) VALUES
    ('TRAIT_LEADER_RELIGIOUS_CONVERT', 'BBG_MILITARY_UNITS_IGNORE_WOODS');

INSERT INTO Types(Type, Kind) VALUES
    ('BBG_IGNORE_WOODS_ABILITY', 'KIND_ABILITY');
INSERT INTO TypeTags(Type, Tag) VALUES
    ('BBG_IGNORE_WOODS_ABILITY', 'CLASS_RECON'),
    ('BBG_IGNORE_WOODS_ABILITY', 'CLASS_MELEE'),
    ('BBG_IGNORE_WOODS_ABILITY', 'CLASS_RANGED'),
    ('BBG_IGNORE_WOODS_ABILITY', 'CLASS_ANTI_CAVALRY'),
    ('BBG_IGNORE_WOODS_ABILITY', 'CLASS_LIGHT_CAVALRY'),
    ('BBG_IGNORE_WOODS_ABILITY', 'CLASS_HEAVY_CAVALRY'),
    ('BBG_IGNORE_WOODS_ABILITY', 'CLASS_SIEGE');

INSERT INTO UnitAbilities(UnitAbilityType, Name, Description, Inactive, ShowFloatTextWhenEarned, Permanent)  VALUES
    ('BBG_IGNORE_WOODS_ABILITY', 'LOC_BBG_IGNORE_WOODS_ABILITY_NAME', 'LOC_BBG_IGNORE_WOODS_ABILITY_DESCRIPTION', 1, 0, 1);
INSERT INTO UnitAbilityModifiers(UnitAbilityType, ModifierId) VALUES
    ('BBG_IGNORE_WOODS_ABILITY', 'RANGER_IGNORE_FOREST_MOVEMENT_PENALTY');


-- 18/06/23 Moved relic bonus from kongo to Mvemba only
UPDATE TraitModifiers SET TraitType='TRAIT_LEADER_RELIGIOUS_CONVERT' WHERE ModifierId='TRAIT_GREAT_WORK_FAITH_RELIC';
UPDATE TraitModifiers SET TraitType='TRAIT_LEADER_RELIGIOUS_CONVERT' WHERE ModifierId='TRAIT_GREAT_WORK_FOOD_RELIC';
UPDATE TraitModifiers SET TraitType='TRAIT_LEADER_RELIGIOUS_CONVERT' WHERE ModifierId='TRAIT_GREAT_WORK_PRODUCTION_RELIC';
UPDATE TraitModifiers SET TraitType='TRAIT_LEADER_RELIGIOUS_CONVERT' WHERE ModifierId='TRAIT_GREAT_WORK_GOLD_RELIC';

--=======Kongo(Civilization)==========--
-- +100% prod towards archealogists
INSERT OR IGNORE INTO TraitModifiers (TraitType, ModifierId) VALUES
    ('TRAIT_CIVILIZATION_NKISI', 'TRAIT_ARCHAEOLOGIST_PROD_BBG');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType) VALUES
    ('TRAIT_ARCHAEOLOGIST_PROD_BBG', 'MODIFIER_PLAYER_UNITS_ADJUST_UNIT_PRODUCTION');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Value) VALUES
    ('TRAIT_ARCHAEOLOGIST_PROD_BBG', 'UnitType', 'UNIT_ARCHAEOLOGIST'),
    ('TRAIT_ARCHAEOLOGIST_PROD_BBG', 'Amount', '100');

-- NGao 3PM
-- 16/04/23 Revert
-- UPDATE Units SET BaseMoves=3 WHERE UnitType='UNIT_KONGO_SHIELD_BEARER';

-- Put back writer point.
INSERT INTO TraitModifiers(TraitType, ModifierId) VALUES
    ('TRAIT_CIVILIZATION_NKISI', 'TRAIT_DOUBLE_WRITER_POINTS');

-- +4 faith for each sculture and artifact
UPDATE ModifierArguments SET Value='4' WHERE Name='YieldChange' AND ModifierId IN ('TRAIT_GREAT_WORK_FAITH_SCULPTURE', 'TRAIT_GREAT_WORK_FAITH_ARTIFACT');




INSERT INTO Requirements (RequirementId, RequirementType) VALUES
    ('BBG_PLAYER_IS_MVEMBA', 'REQUIREMENT_PLAYER_LEADER_TYPE_MATCHES');
INSERT INTO RequirementArguments (RequirementId, Name, Value) VALUES
    ('BBG_PLAYER_IS_MVEMBA', 'LeaderType', 'LEADER_MVEMBA');
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES
    ('BBG_PLAYER_IS_MVEMBA_REQSET', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES
    ('BBG_PLAYER_IS_MVEMBA_REQSET', 'BBG_PLAYER_IS_MVEMBA');

INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES
    ('BBG_KONGO_GOLD_PER_POPULATION_CONVERTED', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'CITY_FOLLOWS_RELIGION_REQUIREMENTS'),
    ('BBG_KONGO_GOLD_PER_POPULATION_CONVERTED_MODIFIER', 'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_PER_POPULATION', 'BBG_PLAYER_IS_MVEMBA_REQSET'),
    ('BBG_KONGO_CULTURE_PER_POPULATION_CONVERTED', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'CITY_FOLLOWS_RELIGION_REQUIREMENTS'),
    ('BBG_KONGO_CULTURE_PER_POPULATION_CONVERTED_MODIFIER', 'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_PER_POPULATION', 'BBG_PLAYER_IS_MVEMBA_REQSET');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
    ('BBG_KONGO_GOLD_PER_POPULATION_CONVERTED', 'ModifierId', 'BBG_KONGO_GOLD_PER_POPULATION_CONVERTED_MODIFIER'),
    ('BBG_KONGO_GOLD_PER_POPULATION_CONVERTED_MODIFIER', 'YieldType', 'YIELD_GOLD'),
    ('BBG_KONGO_GOLD_PER_POPULATION_CONVERTED_MODIFIER', 'Amount', 1),
    ('BBG_KONGO_CULTURE_PER_POPULATION_CONVERTED', 'ModifierId', 'BBG_KONGO_CULTURE_PER_POPULATION_CONVERTED_MODIFIER'),
    ('BBG_KONGO_CULTURE_PER_POPULATION_CONVERTED_MODIFIER', 'YieldType', 'YIELD_CULTURE'),
    ('BBG_KONGO_CULTURE_PER_POPULATION_CONVERTED_MODIFIER', 'Amount', 0.2);

INSERT INTO BeliefModifiers (BeliefType, ModifierID)
    SELECT BeliefType, 'BBG_KONGO_GOLD_PER_POPULATION_CONVERTED' FROM Beliefs WHERE BeliefClassType='BELIEF_CLASS_FOLLOWER' UNION
    SELECT BeliefType, 'BBG_KONGO_CULTURE_PER_POPULATION_CONVERTED' FROM Beliefs WHERE BeliefClassType='BELIEF_CLASS_FOLLOWER';