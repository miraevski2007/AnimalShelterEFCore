using System;
using System.Collections.Generic;

namespace AnimalShelterEFCore.Models;

public partial class Animal
{
    public int Id { get; set; }

    public string Nickname { get; set; } = null!;

    public string Species { get; set; } = null!;

    public string? Breed { get; set; }

    public string Gender { get; set; } = null!;

    public decimal? AgeYears { get; set; }

    public string? Color { get; set; }

    public string? SpecialMarks { get; set; }

    public DateOnly ArrivalDate { get; set; }

    public string? ArrivalSource { get; set; }

    public string Status { get; set; } = null!;

    public virtual ICollection<AdoptionRequest> AdoptionRequests { get; set; } = new List<AdoptionRequest>();

    public virtual ICollection<Placement> Placements { get; set; } = new List<Placement>();

    public virtual ICollection<VeterinaryEvent> VeterinaryEvents { get; set; } = new List<VeterinaryEvent>();
}
