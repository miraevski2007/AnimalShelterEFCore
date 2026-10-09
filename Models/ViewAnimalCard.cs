using System;
using System.Collections.Generic;

namespace AnimalShelterEFCore.Models;

public partial class ViewAnimalCard
{
    public int IdЖивотного { get; set; }

    public string Кличка { get; set; } = null!;

    public string Вид { get; set; } = null!;

    public string? Порода { get; set; }

    public string Пол { get; set; } = null!;

    public decimal? Возраст { get; set; }

    public string? Окрас { get; set; }

    public string? ОсобыеПриметы { get; set; }

    public DateOnly ДатаПоступления { get; set; }

    public string? ИсточникПоступления { get; set; }

    public string Статус { get; set; } = null!;

    public string? Вольер { get; set; }

    public string? ТипВольера { get; set; }

    public DateOnly? ДатаРазмещения { get; set; }

    public DateOnly? ДатаВыбытияИзВольера { get; set; }

    public DateOnly? ДатаВетмероприятия { get; set; }

    public string? ВидМероприятия { get; set; }

    public string? Описание { get; set; }

    public string? Врач { get; set; }

    public decimal? Стоимость { get; set; }

    public DateOnly? ДатаЗаявки { get; set; }

    public string? СтатусЗаявки { get; set; }

    public string? РезультатСобеседования { get; set; }
}
