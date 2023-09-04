using System.ComponentModel.DataAnnotations;

namespace Long_Term_Segregation.Models.DTOs;

public class UserDTO
{
    [Key]
    public long UserId { get; set; }
    public long UserTypeId { get; set; }
    public long DutyTypeId { get; set; }
    public string Title { get; set; } = string.Empty;
    public string? FirstName { get; set; }
    public string? LastName { get; set; }
    public DateTime CreatedAt { get; set; }
    public DateTime UpdatedAt { get; set; }
}
