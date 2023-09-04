using System.ComponentModel.DataAnnotations;

namespace Long_Term_Segregation.Models.DTOs;

public class UserTypeDTO
{
    [Key]
    public long UserTypeId { get; set; }
    public string? Name { get; set; }
    public string? Label { get; set; }
    public DateTime CreatedAt { get; set; }
    public DateTime UpdatedAt { get; set; }
}