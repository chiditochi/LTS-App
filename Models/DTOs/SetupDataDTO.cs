namespace Long_Term_Segregation.Models.DTOs;

public class SetupDataDTO
{
    public SetupDataDTO()
    {
        DutyTypes = new List<DutyTypeDTO>();
        Wards = new List<WardDTO>();
        ReviewOutcomes = new List<ReviewOutcomeDTO>();
        Doctor = new UserDTO();
    }
    public SetupDataDTO(List<DutyTypeDTO> dutyTypes, List<WardDTO> wards, UserDTO doctor, List<ReviewOutcomeDTO> reviewOutcomes)
    {
        DutyTypes = dutyTypes;
        Wards = wards;
        Doctor = doctor;
        ReviewOutcomes = reviewOutcomes;
    }
    public IEnumerable<DutyTypeDTO> DutyTypes { get; set; }
    public IEnumerable<WardDTO> Wards { get; set; }
    public UserDTO Doctor { get; set; }
    public IEnumerable<ReviewOutcomeDTO> ReviewOutcomes { get; set; }
}