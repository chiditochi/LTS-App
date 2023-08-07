namespace Long_Term_Segregation.Models.DTOs;

public class PatientDTO
{
    public long PatientId { get; set; }
    public long DutyTypeId { get; set; }
    public long UserId { get; set; }
    public long? WardId { get; set; }
    public string? FirstName { get; set; }
    public string? LastName { get; set; }
    public DateTime StartDate { get; set; }
    public DateTime CreatedAt { get; set; }
    public DateTime UpdatedAt { get; set; }
}
