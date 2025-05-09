--===========================================================
--                     Policies
--===========================================================
-- fascism attack bonus working for GDR
INSERT OR IGNORE INTO TypeTags (Type, Tag) VALUES ('ABILITY_FASCISM_ATTACK_BUFF', 'CLASS_GIANT_DEATH_ROBOT');
INSERT OR IGNORE INTO TypeTags (Type, Tag) VALUES ('ABILITY_FASCISM_LEGACY_ATTACK_BUFF', 'CLASS_GIANT_DEATH_ROBOT');
-- retinues policy card is 50% of resource cost for produced and upgrade units
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType)
    VALUES ('PROFESSIONAL_ARMY_RESOURCE_DISCOUNT_MODIFIER_CPLMOD', 'MODIFIER_CITY_ADJUST_STRATEGIC_RESOURCE_REQUIREMENT_MODIFIER');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Value)
    VALUES ('PROFESSIONAL_ARMY_RESOURCE_DISCOUNT_MODIFIER_CPLMOD', 'Amount', '50');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType)
    VALUES ('PROFESSIONAL_ARMY_RESOURCE_DISCOUNT_CPLMOD', 'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Value)
    VALUES ('PROFESSIONAL_ARMY_RESOURCE_DISCOUNT_CPLMOD', 'ModifierId', 'PROFESSIONAL_ARMY_RESOURCE_DISCOUNT_MODIFIER_CPLMOD');
INSERT OR IGNORE INTO PolicyModifiers (PolicyType, ModifierId)
    VALUES
    ('POLICY_RETINUES', 'PROFESSIONAL_ARMY_RESOURCE_DISCOUNT_CPLMOD'),
    ('POLICY_FORCE_MODERNIZATION', 'PROFESSIONAL_ARMY_RESOURCE_DISCOUNT_CPLMOD');
-- get +1 resource when revealed (niter and above only)
-- Ressources cards give flat ressources in addition to 1 extra per mine.
INSERT INTO Modifiers(ModifierId, ModifierType, SubjectRequirementSetId) VALUES
    ('BBG_POLICY_GIVE_FREE_HORSE', 'MODIFIER_PLAYER_ADJUST_FREE_RESOURCE_IMPORT_EXTRACTION', 'BBG_PLAYER_CAN_SEE_HORSES'),
    ('BBG_POLICY_GIVE_FREE_IRON', 'MODIFIER_PLAYER_ADJUST_FREE_RESOURCE_IMPORT_EXTRACTION', 'BBG_PLAYER_CAN_SEE_IRON'),
    ('BBG_POLICY_GIVE_FREE_NITER', 'MODIFIER_PLAYER_ADJUST_FREE_RESOURCE_IMPORT_EXTRACTION', 'BBG_PLAYER_CAN_SEE_NITER'),
    ('BBG_POLICY_GIVE_FREE_COAL', 'MODIFIER_PLAYER_ADJUST_FREE_RESOURCE_IMPORT_EXTRACTION', 'BBG_PLAYER_CAN_SEE_COAL'),
    ('BBG_POLICY_GIVE_FREE_ALUMINUM', 'MODIFIER_PLAYER_ADJUST_FREE_RESOURCE_IMPORT_EXTRACTION', 'BBG_PLAYER_CAN_SEE_ALUMINUM'),
    ('BBG_POLICY_GIVE_FREE_OIL', 'MODIFIER_PLAYER_ADJUST_FREE_RESOURCE_IMPORT_EXTRACTION', 'BBG_PLAYER_CAN_SEE_OIL');
INSERT INTO ModifierArguments(ModifierId, Name, Value) VALUES
    ('BBG_POLICY_GIVE_FREE_HORSE', 'ResourceType', 'RESOURCE_HORSES'),
    ('BBG_POLICY_GIVE_FREE_HORSE', 'Amount', '2'),
    ('BBG_POLICY_GIVE_FREE_IRON', 'ResourceType', 'RESOURCE_IRON'),
    ('BBG_POLICY_GIVE_FREE_IRON', 'Amount', '2'),
    ('BBG_POLICY_GIVE_FREE_NITER', 'ResourceType', 'RESOURCE_NITER'),
    ('BBG_POLICY_GIVE_FREE_NITER', 'Amount', '2'),
    ('BBG_POLICY_GIVE_FREE_COAL', 'ResourceType', 'RESOURCE_COAL'),
    ('BBG_POLICY_GIVE_FREE_COAL', 'Amount', '2'),
    ('BBG_POLICY_GIVE_FREE_ALUMINUM', 'ResourceType', 'RESOURCE_ALUMINUM'),
    ('BBG_POLICY_GIVE_FREE_ALUMINUM', 'Amount', '2'),
    ('BBG_POLICY_GIVE_FREE_OIL', 'ResourceType', 'RESOURCE_OIL'),
    ('BBG_POLICY_GIVE_FREE_OIL', 'Amount', '2');
INSERT INTO PolicyModifiers(PolicyType, ModifierId) VALUES
    ('POLICY_EQUESTRIAN_ORDERS', 'BBG_POLICY_GIVE_FREE_HORSE'),
    ('POLICY_EQUESTRIAN_ORDERS', 'BBG_POLICY_GIVE_FREE_IRON'),
    ('POLICY_DRILL_MANUALS', 'BBG_POLICY_GIVE_FREE_NITER'),
    ('POLICY_DRILL_MANUALS', 'BBG_POLICY_GIVE_FREE_COAL'),
    ('POLICY_RESOURCE_MANAGEMENT', 'BBG_POLICY_GIVE_FREE_ALUMINUM'),
    ('POLICY_RESOURCE_MANAGEMENT', 'BBG_POLICY_GIVE_FREE_OIL');

-- 06/07/24 Fixed bug in the "Strategic Air Force" policy card.
-- Now boosts production for Atomic-era air fighters/bombers and modern-era air fighters.
INSERT INTO Modifiers(ModifierId, ModifierType) VALUES
    ('BBG_ATOMIC_AIRFIGHTER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION'),
    ('BBG_ATOMIC_AIRBOMBER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION'),
    ('BBG_MODERN_AIRFIGHTER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION');
INSERT INTO ModifierArguments(ModifierId, Name, Value) VALUES
    ('BBG_ATOMIC_AIRFIGHTER_PRODUCTION', 'UnitPromotionClass', 'PROMOTION_CLASS_AIR_FIGHTER'),
    ('BBG_ATOMIC_AIRFIGHTER_PRODUCTION', 'EraType', 'ERA_ATOMIC'),
    ('BBG_ATOMIC_AIRFIGHTER_PRODUCTION', 'Amount', '50'),
    ('BBG_ATOMIC_AIRBOMBER_PRODUCTION', 'UnitPromotionClass', 'PROMOTION_CLASS_AIR_BOMBER'),
    ('BBG_ATOMIC_AIRBOMBER_PRODUCTION', 'EraType', 'ERA_ATOMIC'),
    ('BBG_ATOMIC_AIRBOMBER_PRODUCTION', 'Amount', '50'),
    ('BBG_MODERN_AIRFIGHTER_PRODUCTION', 'UnitPromotionClass', 'PROMOTION_CLASS_AIR_FIGHTER'),
    ('BBG_MODERN_AIRFIGHTER_PRODUCTION', 'EraType', 'ERA_MODERN'),
    ('BBG_MODERN_AIRFIGHTER_PRODUCTION', 'Amount', '50');
INSERT INTO PolicyModifiers(PolicyType, ModifierId) VALUES
    ('POLICY_STRATEGIC_AIR_FORCE', 'BBG_ATOMIC_AIRFIGHTER_PRODUCTION'),
    ('POLICY_STRATEGIC_AIR_FORCE', 'BBG_ATOMIC_AIRBOMBER_PRODUCTION'),
    ('POLICY_STRATEGIC_AIR_FORCE', 'BBG_MODERN_AIRFIGHTER_PRODUCTION');


-- 30/03/25 +7 late game card now works on planes
INSERT INTO TypeTags (Type, Tag) VALUES
    ('ABILITY_GLOBAL_COALITION_FRIENDLY_TERRITORY', 'CLASS_AIR_FIGHTER'),
    ('ABILITY_GLOBAL_COALITION_FRIENDLY_TERRITORY', 'CLASS_AIR_BOMBER');