using AnimalShelterEFCore.Models;
using Microsoft.EntityFrameworkCore;

using var ctx = new AnimalShelterContext();

// ===== 2.1. Все данные из таблицы на стороне "один" (owners) =====
Console.WriteLine("=== 2.1. Все хозяева (owners) ===");
foreach (var o in await ctx.Owners.Take(10).ToListAsync())
    Console.WriteLine($"{o.Id}: {o.FullName} | {o.Phone}");

// ===== 2.2. Фильтрация таблицы на стороне "один" =====
Console.WriteLine("\n=== 2.2. Хозяева с телефоном на +375 ===");
foreach (var o in await ctx.Owners
    .Where(x => x.Phone.StartsWith("+375"))
    .Take(10)
    .ToListAsync())
    Console.WriteLine($"{o.FullName} — {o.Phone}");

// ===== 2.3. Группировка таблицы на стороне "многие" =====
Console.WriteLine("\n=== 2.3. Кол-во заявок по статусу ===");
var byStatus = await ctx.AdoptionRequests
    .GroupBy(r => r.Status)
    .Select(g => new {
        Status    = g.Key,
        Count     = g.Count(),
        FirstDate = g.Min(r => r.RequestDate)
    })
    .OrderByDescending(g => g.Count)
    .ToListAsync();
foreach (var g in byStatus)
    Console.WriteLine($"«{g.Status}»: {g.Count} заявок, первая — {g.FirstDate:yyyy-MM-dd}");

// ===== 2.4. Выборка из двух связанных таблиц =====
Console.WriteLine("\n=== 2.4. Заявки с именами хозяев ===");
foreach (var x in await ctx.AdoptionRequests
    .Include(r => r.Owner)
    .Select(r => new { r.Id, Owner = r.Owner.FullName, r.RequestDate, r.Status })
    .Take(10)
    .ToListAsync())
    Console.WriteLine($"#{x.Id}: {x.Owner} — {x.RequestDate:yyyy-MM-dd} [{x.Status}]");

// ===== 2.5. Две таблицы + фильтр =====
Console.WriteLine("\n=== 2.5. Одобренные заявки + животное ===");
foreach (var x in await ctx.AdoptionRequests
    .Include(r => r.Animal)
    .Where(r => r.Status == "Одобрена")
    .Select(r => new { r.Id, Animal = r.Animal.Nickname, r.RequestDate })
    .Take(10)
    .ToListAsync())
    Console.WriteLine($"#{x.Id}: «{x.Animal}» — {x.RequestDate:yyyy-MM-dd}");

// ===== 2.6. Вставка в таблицу на стороне "один" =====
Console.WriteLine("\n=== 2.6. Добавление хозяина ===");
var newOwner = new Owner {
    FullName         = "Иванов Иван Иванович",
    Phone            = "+375291112233",
    Address          = "г. Минск, ул. Примерная, 1",
    LivingConditions = "квартира",
    HasOtherAnimals  = false
};
ctx.Owners.Add(newOwner);
await ctx.SaveChangesAsync();
Console.WriteLine($"Добавлен owner id={newOwner.Id}");

// ===== 2.7. Вставка в таблицу на стороне "многие" =====
Console.WriteLine("\n=== 2.7. Добавление заявки ===");
var anyAnimal = await ctx.Animals.FirstAsync();
var newRequest = new AdoptionRequest {
    OwnerId         = newOwner.Id,
    AnimalId        = anyAnimal.Id,
    RequestDate     = DateOnly.FromDateTime(DateTime.Today),
    Status          = "Новая",
    InterviewResult = null
};
ctx.AdoptionRequests.Add(newRequest);
await ctx.SaveChangesAsync();
Console.WriteLine($"Добавлена заявка id={newRequest.Id}");

// ===== 2.8. Удаление из таблицы на стороне "один" =====
Console.WriteLine("\n=== 2.8. Удаление хозяина без заявок ===");
var ownerDel = await ctx.Owners
    .Where(o => !o.AdoptionRequests.Any())
    .FirstOrDefaultAsync();
if (ownerDel != null) {
    ctx.Owners.Remove(ownerDel);
    await ctx.SaveChangesAsync();
    Console.WriteLine($"Удалён owner id={ownerDel.Id} ({ownerDel.FullName})");
} else Console.WriteLine("Нет подходящих хозяев.");

// ===== 2.9. Удаление из таблицы на стороне "многие" =====
Console.WriteLine("\n=== 2.9. Удаление заявки ===");
var reqDel = await ctx.AdoptionRequests.FirstOrDefaultAsync(r => r.Id == newRequest.Id);
if (reqDel != null) {
    ctx.AdoptionRequests.Remove(reqDel);
    await ctx.SaveChangesAsync();
    Console.WriteLine($"Удалена заявка id={reqDel.Id}");
}

// ===== 2.10. Обновление записей по условию =====
Console.WriteLine("\n=== 2.10. Статус 'Одобрена' → 'Завершена' (по одной заявке) ===");
var toUpdate = await ctx.AdoptionRequests
    .Where(r => r.Status == "Одобрена")
    .Take(5)
    .ToListAsync();
foreach (var r in toUpdate) r.Status = "Завершена";
await ctx.SaveChangesAsync();
Console.WriteLine($"Обновлено заявок: {toUpdate.Count}");
