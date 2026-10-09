using System;
using System.Collections.Generic;

namespace AnimalShelterEFCore.Models;

public partial class Enclosure
{
    public int Id { get; set; }

    public string Number { get; set; } = null!;

    public string Type { get; set; } = null!;

    public int Capacity { get; set; }

    public virtual ICollection<Placement> Placements { get; set; } = new List<Placement>();
}
