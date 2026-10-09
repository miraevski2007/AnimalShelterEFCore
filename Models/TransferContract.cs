using System;
using System.Collections.Generic;

namespace AnimalShelterEFCore.Models;

public partial class TransferContract
{
    public int Id { get; set; }

    public int RequestId { get; set; }

    public DateOnly ContractDate { get; set; }

    public DateOnly? ControlVisitDate { get; set; }

    public string? VisitResult { get; set; }

    public virtual AdoptionRequest Request { get; set; } = null!;
}
