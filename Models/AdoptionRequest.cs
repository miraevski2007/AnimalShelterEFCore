using System;
using System.Collections.Generic;

namespace AnimalShelterEFCore.Models;

public partial class AdoptionRequest
{
    public int Id { get; set; }

    public int OwnerId { get; set; }

    public int AnimalId { get; set; }

    public DateOnly RequestDate { get; set; }

    public string Status { get; set; } = null!;

    public string? InterviewResult { get; set; }

    public virtual Animal Animal { get; set; } = null!;

    public virtual Owner Owner { get; set; } = null!;

    public virtual TransferContract? TransferContract { get; set; }
}
