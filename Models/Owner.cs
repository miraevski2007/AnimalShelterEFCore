using System;
using System.Collections.Generic;

namespace AnimalShelterEFCore.Models;

public partial class Owner
{
    public int Id { get; set; }

    public string FullName { get; set; } = null!;

    public string Address { get; set; } = null!;

    public string Phone { get; set; } = null!;

    public string? LivingConditions { get; set; }

    public bool HasOtherAnimals { get; set; }

    public virtual ICollection<AdoptionRequest> AdoptionRequests { get; set; } = new List<AdoptionRequest>();
}
