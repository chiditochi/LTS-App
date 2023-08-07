namespace Long_Term_Segregation.Models.DTOs;

public class PatientCaseFileDTO
{
    //public long PatientCaseFileId { get; set; }
    public long PatientId { get; set; }
    public long ReviewOutcomId { get; set; }
    public long UserId { get; set; }
    public long DutyTypeId { get; set; }
    public long? WardId { get; set; }
    public string? Comment { get; set; }
    public DateTime StartDate { get; set; }
    public DateTime ReviewTime { get; set; }
    public DateTime? ExitTime { get; set; }
    public DateTime CreatedAt { get; set; }
    public DateTime UpdatedAt { get; set; }
}

