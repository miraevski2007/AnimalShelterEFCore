-- ============================================================
-- Скрипт 5: Хранимые процедуры
-- ============================================================

USE AnimalShelter;
GO

-- 1. Добавление нового животного
CREATE OR ALTER PROCEDURE sp_AddAnimal
    @name           NVARCHAR(100),
    @species_id     INT,
    @breed_id       INT = NULL,
    @gender         NCHAR(1),
    @age            INT = NULL,
    @color          NVARCHAR(50) = NULL,
    @special_marks  NVARCHAR(500) = NULL,
    @arrival_date   DATE,
    @arrival_source NVARCHAR(200) = NULL,
    @status_id      INT,
    @volier_id      INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO Animals (name, species_id, breed_id, gender, age, color,
                         special_marks, arrival_date, arrival_source, status_id, volier_id)
    VALUES (@name, @species_id, @breed_id, @gender, @age, @color,
            @special_marks, @arrival_date, @arrival_source, @status_id, @volier_id);
    SELECT SCOPE_IDENTITY() AS NewAnimalId;
END
GO

-- 2. Изменение статуса животного
CREATE OR ALTER PROCEDURE sp_UpdateAnimalStatus
    @animal_id INT,
    @new_status_id INT
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE Animals
    SET status_id = @new_status_id
    WHERE id = @animal_id;
END
GO

-- 3. Регистрация ветеринарного мероприятия
CREATE OR ALTER PROCEDURE sp_RegisterVetProcedure
    @animal_id      INT,
    @procedure_date DATE,
    @procedure_type NVARCHAR(50),
    @description    NVARCHAR(500) = NULL,
    @doctor         NVARCHAR(200) = NULL,
    @cost           DECIMAL(10,2) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO VetProcedures (animal_id, procedure_date, procedure_type,
                               description, doctor, cost)
    VALUES (@animal_id, @procedure_date, @procedure_type,
            @description, @doctor, @cost);
    SELECT SCOPE_IDENTITY() AS NewProcedureId;
END
GO

-- 4. Подача заявки на пристройство
CREATE OR ALTER PROCEDURE sp_SubmitApplication
    @owner_id         INT,
    @animal_id        INT,
    @application_date DATE,
    @status           NVARCHAR(50) = N'На рассмотрении',
    @interview_result NVARCHAR(500) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO Applications (owner_id, animal_id, application_date, status, interview_result)
    VALUES (@owner_id, @animal_id, @application_date, @status, @interview_result);
    SELECT SCOPE_IDENTITY() AS NewApplicationId;
END
GO

PRINT 'Хранимые процедуры созданы.';
GO

-- Проверка вызова
EXEC sp_AddAnimal 
    @name = N'Тестовый Барсик', @species_id = 1, @breed_id = 1,
    @gender = N'М', @age = 2, @color = N'Рыжий',
    @arrival_date = '2026-09-15', @status_id = 1, @volier_id = 1;

EXEC sp_UpdateAnimalStatus @animal_id = 1, @new_status_id = 2;

EXEC sp_RegisterVetProcedure 
    @animal_id = 1, @procedure_date = '2026-09-15',
    @procedure_type = N'Осмотр', @doctor = N'Иванов И.И.', @cost = 50.00;

EXEC sp_SubmitApplication
    @owner_id = 1, @animal_id = 1,
    @application_date = '2026-09-15', @status = N'На рассмотрении';
GO