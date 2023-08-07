namespace Long_Term_Segregation.Models.DTOs;

public class NewPatientDTO
{
    public NewPatientDTO()
    {
        FirstName = string.Empty;
        LastName = string.Empty;
    }
    
    public long DutyTypeId { get; set; }
    public long UserId { get; set; }
    public long? WardId { get; set; }
    public string FirstName { get; set; }
    public string LastName { get; set; }
    public DateTime StartDate { get; set; }
}
