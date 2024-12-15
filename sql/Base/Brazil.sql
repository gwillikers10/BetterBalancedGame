-- Author: iElden

-- Carnivals don't require population
UPDATE Districts SET RequiresPopulation=0 WHERE DistrictType IN ('DISTRICT_STREET_CARNIVAL', 'DISTRICT_WATER_STREET_CARNIVAL');

-- Up Minas by +5/+5 to match battleship up
-- 19/12/23 Nerf Minas by 5/5
-- 27/11/24 melee reduced to 60 (from 70)
-- 15/12/24 ranged reduced to 70 (from 80)
UPDATE Units SET Combat=60, RangedCombat=70 WHERE UnitType='UNIT_BRAZILIAN_MINAS_GERAES';

-- 15/12/24 gets +10 at refining
INSERT INTO Tags (Tag, Vocabulary) VALUES
    ('CLASS_MINAS', 'ABILITY_CLASS');
INSERT INTO Types (Type, Kind) VALUES
    ('BBG_ABILITY_MINAS_COMBAT_REFINING', 'KIND_ABILITY');
INSERT INTO TypeTags (Type, Tag) VALUES
    ('UNIT_BRAZILIAN_MINAS_GERAES', 'CLASS_MINAS'),
    ('BBG_ABILITY_MINAS_COMBAT_REFINING', 'CLASS_MINAS');
INSERT INTO UnitAbilities (UnitAbilityType, Name, Description, Inactive) VALUES
    ('BBG_ABILITY_MINAS_COMBAT_REFINING', 'LOC_BBG_ABILITY_MINAS_COMBAT_REFINING_NAME', 'LOC_BBG_ABILITY_MINAS_COMBAT_REFINING_DESC', 1);
INSERT INTO UnitAbilityModifiers (UnitAbilityType, ModifierId) VALUES
    ('BBG_ABILITY_MINAS_COMBAT_REFINING', 'BBG_MINAS_COMBAT_REFINING_MODIFIER');
INSERT INTO Modifiers (ModifierId, ModifierType, OwnerRequirementSetId) VALUES
    ('BBG_MINAS_COMBAT_REFINING_GIVER', 'MODIFIER_PLAYER_UNITS_GRANT_ABILITY', 'BBG_UTILS_PLAYER_HAS_TECH_REFINING'),
    ('BBG_MINAS_COMBAT_REFINING_MODIFIER', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', NULL);
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
    ('BBG_MINAS_COMBAT_REFINING_GIVER', 'AbilityType', 'BBG_ABILITY_MINAS_COMBAT_REFINING'),
    ('BBG_MINAS_COMBAT_REFINING_MODIFIER', 'Amount', 10);
INSERT INTO TraitModifiers (TraitType, ModifierId) VALUES
    ('TRAIT_CIVILIZATION_AMAZON', 'BBG_MINAS_COMBAT_REFINING_GIVER');
INSERT INTO ModifierStrings (ModifierId, Context, Text) VALUES
    ('BBG_MINAS_COMBAT_REFINING_MODIFIER', 'Preview', 'LOC_BBG_ABILITY_MINAS_COMBAT_REFINING_DESC');

-- 19/12/23 Extra procution on unimproved jungle
INSERT INTO RequirementSets(RequirementSetId, RequirementSetType) VALUES
    ('BBG_PLOT_HAS_UNIMPROVED_JUNGLE_CONSTRUCTION', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements(RequirementSetId, RequirementId) VALUES
    ('BBG_PLOT_HAS_UNIMPROVED_JUNGLE_CONSTRUCTION', 'PLOT_IS_JUNGLE_REQUIREMENT'),
    ('BBG_PLOT_HAS_UNIMPROVED_JUNGLE_CONSTRUCTION', 'REQUIRES_PLOT_HAS_NO_IMPROVEMENT'),
    ('BBG_PLOT_HAS_UNIMPROVED_JUNGLE_CONSTRUCTION', 'BBG_UTILS_PLAYER_HAS_TECH_CONSTRUCTION_REQUIREMENT');
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES
    ('BBG_TRAIT_BRAZIL_PROD_ON_UNIMPROVED_JUNGLE', 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD', 'BBG_PLOT_HAS_UNIMPROVED_JUNGLE_CONSTRUCTION');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
    ('BBG_TRAIT_BRAZIL_PROD_ON_UNIMPROVED_JUNGLE', 'YieldType', 'YIELD_PRODUCTION'),
    ('BBG_TRAIT_BRAZIL_PROD_ON_UNIMPROVED_JUNGLE', 'Amount', '1');

INSERT INTO TraitModifiers(TraitType, ModifierId) VALUES
    ('TRAIT_CIVILIZATION_AMAZON', 'BBG_TRAIT_BRAZIL_PROD_ON_UNIMPROVED_JUNGLE');

-- New UI : Serraria
--INSERT INTO Types(Type, Kind) VALUES
--    ('BBG_TRAIT_IMPROVEMENT_SERRARIA', 'KIND_TRAIT'),
--    ('BBG_IMPROVEMENT_SERRARIA', 'KIND_IMPROVEMENT');
--INSERT INTO Traits(TraitType) VALUES
--    ('BBG_TRAIT_IMPROVEMENT_SERRARIA');
--INSERT INTO CivilizationTraits(CivilizationType, TraitType) VALUES
--    ('CIVILIZATION_BRAZIL', 'BBG_TRAIT_IMPROVEMENT_SERRARIA');
--
--CREATE TEMPORARY TABLE tmp
--    AS SELECT * FROM Improvements WHERE ImprovementType='IMPROVEMENT_LUMBER_MILL';
--UPDATE tmp SET ImprovementType='BBG_IMPROVEMENT_SERRARIA', TraitType='BBG_TRAIT_IMPROVEMENT_SERRARIA', Name='LOC_BBG_IMPROVEMENT_SERRARIA_NAME', Description='LOC_BBG_IMPROVEMENT_SERRARIA_DESC';
--INSERT INTO Improvements SELECT * from tmp;
--DROP TABLE tmp;
--
--INSERT INTO Improvement_ValidBuildUnits VALUES
--    ('BBG_IMPROVEMENT_SERRARIA', 'UNIT_BUILDER', 1, 0);
--INSERT INTO Improvement_ValidFeatures (ImprovementType, FeatureType) VALUES
--    ('BBG_IMPROVEMENT_SERRARIA', 'FEATURE_JUNGLE');
--INSERT INTO Improvement_YieldChanges (ImprovementType, YieldType, YieldChange) VALUES
--    ('BBG_IMPROVEMENT_SERRARIA', 'YIELD_PRODUCTION', 1);
--INSERT INTO Improvement_BonusYieldChanges (Id, ImprovementType, YieldType, BonusYieldChange, PrereqTech, PrereqCivic) VALUES
--    (3020, 'BBG_IMPROVEMENT_SERRARIA', 'YIELD_PRODUCTION', 1, NULL, 'CIVIC_MERCANTILISM'),
--    (3021, 'BBG_IMPROVEMENT_SERRARIA', 'YIELD_PRODUCTION', 1, 'TECH_STEEL', NULL),
--    (3022, 'BBG_IMPROVEMENT_SERRARIA', 'YIELD_PRODUCTION', 1, 'TECH_CYBERNETICS', NULL);
--INSERT INTO Adjacency_YieldChanges (ID, Description, YieldType, YieldChange, TilesRequired, AdjacentImprovement) VALUES
--    ('BBG_SerrariaIZProduction', 'LOC_BBG_DISTRICT_SERRARIA_PRODUCTION', 'YIELD_PRODUCTION', 1, 1, 'BBG_IMPROVEMENT_SERRARIA');
--INSERT INTO District_Adjacencies VALUES ('DISTRICT_INDUSTRIAL_ZONE', 'BBG_SerrariaIZProduction');