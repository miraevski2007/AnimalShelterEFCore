-- ============================================================
-- Скрипт 2: Заполнение справочников (не менее 500 записей в сумме)
-- ============================================================

USE AnimalShelter;
GO

-- Виды (10 записей)
INSERT INTO Species (name) VALUES
(N'Кошка'), (N'Собака'), (N'Кролик'), (N'Хомяк'), (N'Морская свинка'),
(N'Попугай'), (N'Черепаха'), (N'Хорёк'), (N'Крыса'), (N'Ёж');
GO

-- Статусы (4)
INSERT INTO Statuses (name) VALUES
(N'Карантин'), (N'Доступен'), (N'Зарезервирован'), (N'Пристроен');
GO

-- Типы вольеров (5)
INSERT INTO VolierTypes (name, capacity) VALUES
(N'Обычный',     2),
(N'Большой',     5),
(N'Карантинный', 1),
(N'Кошачий',     3),
(N'Собачий',     4);
GO

-- Породы (генерируем для каждого вида по 50 пород = 500 всего)
DECLARE @species_id INT, @i INT;
DECLARE cur CURSOR FOR SELECT id FROM Species;
OPEN cur;
FETCH NEXT FROM cur INTO @species_id;
WHILE @@FETCH_STATUS = 0
BEGIN
    SET @i = 1;
    WHILE @i <= 50
    BEGIN
        INSERT INTO Breeds (species_id, name)
        VALUES (@species_id, CONCAT(N'Порода ', @species_id, N'-', @i));
        SET @i = @i + 1;
    END
    FETCH NEXT FROM cur INTO @species_id;
END
CLOSE cur;
DEALLOCATE cur;
GO

-- Вольеры: 100 штук
DECLARE @i INT = 1;
DECLARE @type_id INT;
WHILE @i <= 100
BEGIN
    SET @type_id = ((@i - 1) % 5) + 1;
    INSERT INTO Voliers (volier_type_id, number, capacity)
    VALUES (@type_id, CONCAT(N'V-', RIGHT('000' + CAST(@i AS NVARCHAR), 3)), 
            (SELECT capacity FROM VolierTypes WHERE id = @type_id));
    SET @i = @i + 1;
END
GO

-- Владельцы: 500 записей
DECLARE @i INT = 1;
WHILE @i <= 500
BEGIN
    INSERT INTO Owners (full_name, address, phone, housing_conditions, has_other_animals)
    VALUES (
        CONCAT(N'Владелец ', @i),
        CONCAT(N'г. Гомель, ул. Улица ', @i, N', д. ', (@i % 100) + 1),
        CONCAT(N'+37529', RIGHT('0000000' + CAST(@i AS NVARCHAR), 7)),
        CASE (@i % 3) 
            WHEN 0 THEN N'Квартира'
            WHEN 1 THEN N'Частный дом'
            ELSE N'Дом с участком'
        END,
        CASE WHEN @i % 2 = 0 THEN 1 ELSE 0 END
    );
    SET @i = @i + 1;
END
GO

PRINT 'Справочники заполнены.';
SELECT 
    (SELECT COUNT(*) FROM Species)     AS Species,
    (SELECT COUNT(*) FROM Breeds)      AS Breeds,
    (SELECT COUNT(*) FROM Statuses)    AS Statuses,
    (SELECT COUNT(*) FROM VolierTypes) AS VolierTypes,
    (SELECT COUNT(*) FROM Voliers)     AS Voliers,
    (SELECT COUNT(*) FROM Owners)      AS Owners;
GO