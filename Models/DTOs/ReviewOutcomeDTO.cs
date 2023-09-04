using System.ComponentModel.DataAnnotations;

namespace Long_Term_Segregation.Models.DTOs;

public class ReviewOutcomeDTO
{
    [Key]
    public long ReviewOutcomeId { get; set; }
    public string? Text { get; set; }
    public DateTime CreatedAt { get; set; }
    public DateTime UpdatedAt { get; set; }
}