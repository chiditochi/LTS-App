using System.ComponentModel.DataAnnotations;

namespace Long_Term_Segregation.Models.DTOs;

public class DutyTypeDTO
{
    [Key]
    public long DutyTypeId { get; set; }
    public string? Name { get; set; }
    public DateTime CreatedAt { get; set; }
    public DateTime UpdatedAt { get; set; }
}