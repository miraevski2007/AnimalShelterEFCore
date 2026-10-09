using System;
using System.Collections.Generic;

namespace AnimalShelterEFCore.Models;

public partial class VeterinaryEvent
{
    public int Id { get; set; }

    public int AnimalId { get; set; }

    public DateOnly EventDate { get; set; }

    public string EventType { get; set; } = null!;

    public string? Description { get; set; }

    public string Veterinarian { get; set; } = null!;

    public decimal Cost { get; set; }

    public virtual Animal Animal { get; set; } = null!;
}
