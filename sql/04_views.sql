-- ============================================================
-- Скрипт 4: Представления (VIEW)
-- ============================================================

USE AnimalShelter;
GO

-- 1. Каталог животных, доступных к пристройству
CREATE OR ALTER VIEW vw_AvailableAnimals AS
SELECT 
    a.id              AS AnimalId,
    a.name            AS AnimalName,
    s.name            AS Species,
    b.name            AS Breed,
    a.gender,
    a.age,
    a.color,
    a.special_marks,
    a.arrival_date,
    st.name           AS Status,
    v.number          AS VolierNumber,
    DATEDIFF(DAY, a.arrival_date, GETDATE()) AS DaysInShelter
FROM Animals a
JOIN Species  s  ON a.species_id = s.id
LEFT JOIN Breeds b ON a.breed_id = b.id
JOIN Statuses st ON a.status_id = st.id
LEFT JOIN Voliers v ON a.volier_id = v.id
WHERE st.name = N'Доступен';
GO

-- 2. Карточка животного: поступление, вольер, ветеринарные мероприятия
CREATE OR ALTER VIEW vw_AnimalCard AS
SELECT 
    a.id              AS AnimalId,
    a.name            AS AnimalName,
    s.name            AS Species,
    b.name            AS Breed,
    a.gender,
    a.age,
    a.color,
    a.arrival_date,
    a.arrival_source,
    st.name           AS Status,
    v.number          AS VolierNumber,
    vp.procedure_date,
    vp.procedure_type,
    vp.description    AS ProcedureDescription,
    vp.doctor,
    vp.cost
FROM Animals a
JOIN Species  s  ON a.species_id = s.id
LEFT JOIN Breeds b ON a.breed_id = b.id
JOIN Statuses st ON a.status_id = st.id
LEFT JOIN Voliers v ON a.volier_id = v.id
LEFT JOIN VetProcedures vp ON vp.animal_id = a.id;
GO

-- 3. Отчёт о поступлении и пристройстве животных за период
CREATE OR ALTER VIEW vw_AdoptionReport AS
SELECT 
    a.id              AS AnimalId,
    a.name            AS AnimalName,
    s.name            AS Species,
    a.arrival_date,
    ap.application_date,
    ap.status         AS ApplicationStatus,
    o.full_name       AS OwnerName,
    ac.contract_date,
    ac.control_visit_date,
    ac.visit_result,
    DATEDIFF(DAY, a.arrival_date, ac.contract_date) AS DaysBeforeAdoption
FROM Animals a
JOIN Species s ON a.species_id = s.id
LEFT JOIN Applications ap ON ap.animal_id = a.id
LEFT JOIN Owners o ON ap.owner_id = o.id
LEFT JOIN AdoptionContracts ac ON ac.application_id = ap.id
WHERE ac.contract_date IS NOT NULL;
GO

PRINT 'Представления созданы.';
GO

-- Проверка
SELECT TOP 10 * FROM vw_AvailableAnimals;
SELECT TOP 10 * FROM vw_AnimalCard;
SELECT TOP 10 * FROM vw_AdoptionReport;
GO