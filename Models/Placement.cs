using System;
using System.Collections.Generic;

namespace AnimalShelterEFCore.Models;

public partial class Placement
{
    public int Id { get; set; }

    public int AnimalId { get; set; }

    public int EnclosureId { get; set; }

    public DateOnly PlacedAt { get; set; }

    public DateOnly? RemovedAt { get; set; }

    public virtual Animal Animal { get; set; } = null!;

    public virtual Enclosure Enclosure { get; set; } = null!;
}
