-- ============================================================
-- Скрипт 3: Заполнение оперативных таблиц
-- Животные: 20000, Ветмероприятия: ~20000, Заявки: ~5000
-- ============================================================

USE AnimalShelter;
GO

-- Животные: 20 000 записей
DECLARE @i INT = 1;
DECLARE @species_count INT = (SELECT COUNT(*) FROM Species);
DECLARE @status_count  INT = (SELECT COUNT(*) FROM Statuses);
DECLARE @volier_count  INT = (SELECT COUNT(*) FROM Voliers);

WHILE @i <= 20000
BEGIN
    DECLARE @sp_id INT = ((@i - 1) % @species_count) + 1;
    DECLARE @br_id INT = (SELECT TOP 1 id FROM Breeds WHERE species_id = @sp_id ORDER BY id);
    DECLARE @st_id INT = ((@i - 1) % @status_count) + 1;
    DECLARE @vl_id INT = ((@i - 1) % @volier_count) + 1;

    INSERT INTO Animals (name, species_id, breed_id, gender, age, color, special_marks,
                         arrival_date, arrival_source, status_id, volier_id)
    VALUES (
        CONCAT(N'Животное ', @i),
        @sp_id,
        @br_id,
        CASE WHEN @i % 2 = 0 THEN N'М' ELSE N'Ж' END,
        (@i % 15) + 1,
        CASE (@i % 5)
            WHEN 0 THEN N'Рыжий'
            WHEN 1 THEN N'Чёрный'
            WHEN 2 THEN N'Белый'
            WHEN 3 THEN N'Серый'
            ELSE N'Трёхцветный'
        END,
        CASE (@i % 4)
            WHEN 0 THEN N'Без особых примет'
            WHEN 1 THEN N'Белое пятно на груди'
            WHEN 2 THEN N'Куцый хвост'
            ELSE N'Шрам на ухе'
        END,
        DATEADD(DAY, -(@i % 1000), CAST(GETDATE() AS DATE)),
        CASE (@i % 4)
            WHEN 0 THEN N'Отлов'
            WHEN 1 THEN N'Сдан владельцем'
            WHEN 2 THEN N'Передан из другого приюта'
            ELSE N'Найден на улице'
        END,
        @st_id,
        @vl_id
    );
    SET @i = @i + 1;
END
GO

-- Ветмероприятия: 20 000 записей
DECLARE @i INT = 1;
WHILE @i <= 20000
BEGIN
    INSERT INTO VetProcedures (animal_id, procedure_date, procedure_type,
                               description, doctor, cost)
    VALUES (
        ((@i - 1) % 20000) + 1,
        DATEADD(DAY, -(@i % 500), CAST(GETDATE() AS DATE)),
        CASE (@i % 4)
            WHEN 0 THEN N'Осмотр'
            WHEN 1 THEN N'Вакцинация'
            WHEN 2 THEN N'Стерилизация'
            ELSE N'Лечение'
        END,
        CONCAT(N'Описание мероприятия ', @i),
        CONCAT(N'Врач ', (@i % 20) + 1),
        ((@i % 100) + 10) * 1.5
    );
    SET @i = @i + 1;
END
GO

-- Заявки: 5000 записей
DECLARE @i INT = 1;
WHILE @i <= 5000
BEGIN
    INSERT INTO Applications (owner_id, animal_id, application_date, status, interview_result)
    VALUES (
        ((@i - 1) % 500) + 1,
        ((@i * 3 - 1) % 20000) + 1,
        DATEADD(DAY, -(@i % 300), CAST(GETDATE() AS DATE)),
        CASE (@i % 4)
            WHEN 0 THEN N'На рассмотрении'
            WHEN 1 THEN N'Одобрена'
            WHEN 2 THEN N'Отклонена'
            ELSE N'Завершена'
        END,
        CASE (@i % 3)
            WHEN 0 THEN N'Собеседование пройдено'
            WHEN 1 THEN N'Требуется повторное собеседование'
            ELSE N'Отказ'
        END
    );
    SET @i = @i + 1;
END
GO

-- Договоры передачи: 1000 записей (только для одобренных заявок)
INSERT INTO AdoptionContracts (application_id, contract_date, control_visit_date, visit_result)
SELECT TOP 1000 
    id,
    DATEADD(DAY, 7, application_date),
    DATEADD(DAY, 60, application_date),
    N'Контрольный визит успешен'
FROM Applications
WHERE status = N'Завершена'
ORDER BY id;
GO

PRINT 'Оперативные таблицы заполнены.';
SELECT 
    (SELECT COUNT(*) FROM Animals)           AS Animals,
    (SELECT COUNT(*) FROM VetProcedures)     AS VetProcedures,
    (SELECT COUNT(*) FROM Applications)      AS Applications,
    (SELECT COUNT(*) FROM AdoptionContracts) AS Contracts;
GO