using System.ComponentModel.DataAnnotations;

namespace Long_Term_Segregation.Models.DTOs;

public class WardDTO
{
    [Key]
    public long WardId { get; set; }
    public string? Name { get; set; }
    public DateTime CreatedAt { get; set; }
    public DateTime UpdatedAt { get; set; }
}