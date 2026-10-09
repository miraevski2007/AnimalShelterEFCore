using System;
using System.Collections.Generic;

namespace AnimalShelterEFCore.Models;

public partial class ViewArrivalAdoptionReport
{
    public int? Год { get; set; }

    public int? Месяц { get; set; }

    public int? ПоступилоЖивотных { get; set; }

    public int? ПристроеноЖивотных { get; set; }

    public decimal? СреднийСрокПребыванияДней { get; set; }
}
