using System;
using System.Collections.Generic;

namespace AnimalShelterEFCore.Models;

public partial class ViewAvailableAnimal
{
    public int IdЖивотного { get; set; }

    public string Кличка { get; set; } = null!;

    public string Вид { get; set; } = null!;

    public string? Порода { get; set; }

    public string Пол { get; set; } = null!;

    public decimal? ВозрастЛет { get; set; }

    public string? Окрас { get; set; }

    public string? ОсобыеПриметы { get; set; }

    public DateOnly ДатаПоступления { get; set; }

    public int? СрокПребыванияДней { get; set; }

    public string? НомерВольера { get; set; }

    public string? ТипВольера { get; set; }

    public string Статус { get; set; } = null!;
}
