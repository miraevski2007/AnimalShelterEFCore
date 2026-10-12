# AnimalShelterEFCore

Лабораторная работа №2: Entity Framework Core (Database First).
Предметная область: приют для животных (`AnimalShelterDB`).

![Build Status](https://github.com/miraevski2007/AnimalShelterEFCore/actions/workflows/build.yml/badge.svg)

## Возможности
- Scaffolding MS SQL Server (Database First, Reverse Engineering)
- LINQ-запросы: выборка, фильтрация, группировка, соединение таблиц
- CRUD-операции через EF Core
- Автосборка GitHub Actions на Ubuntu и Windows

## Схема БД
- `owners` 1—∞ `adoption_requests`
- `animals` 1—∞ (`adoption_requests`, `placements`, `veterinary_events`)
- `enclosures` 1—∞ `placements`
- `adoption_requests` 1—∞ `transfer_contracts`

## База данных

База `AnimalShelterDB` создана в ходе выполнения лабораторной работы №1 (вариант «Приют для животных»).
Скрипты создания и наполнения базы находятся в каталоге [`sql/`](sql/):

- `01_create_db.sql` — создание базы и таблиц
- `02_seed_dictionaries.sql` — справочные данные
- `03_seed_operational.sql` — операционные данные
- `04_views.sql` — представления
- `05_procedures.sql` — хранимые процедуры

## Запуск
```bash
dotnet restore
dotnet ef dbcontext scaffold "Server=localhost;Database=AnimalShelterDB;Trusted_Connection=True;TrustServerCertificate=True;" Microsoft.EntityFrameworkCore.SqlServer -o Models -c AnimalShelterContext
dotnet run
```

## Технологии
- .NET 10
- Entity Framework Core 10
- MS SQL Server
- LINQ
- GitHub Actions