
using Long_Term_Segregation.Models;
using Long_Term_Segregation.Models.DTOs;

namespace Long_Term_Segregation.Services.interfaces;

public interface IAppDataService
{
    public Task<AppResult<DutyTypeDTO>> GetDutyTypes();
    public Task<AppResult<ReviewOutcomeDTO>> GetReviewOutcomes();
    public Task<AppResult<WardDTO>> GetWards();
    public Task<AppResult<UserTypeDTO>> GetUserTypes();
    public Task<AppResult<UserDTO>> GetUsers();
    //public Task<AppResult<PatientDTO>> GetPatients(long customSeed, int page);

    public Task<AppResult<SetupDataDTO>> GetSetupData();
    public Task<AppResult<PatientDTO>> GetPatients(long doctorsId, long dutyType, int page, long? wardId);
    public Task<AppResult<bool>> CommitPatients(IEnumerable<PatientCaseFileDTO> patientCasesFiles);
    public Task<AppResult<bool>> CreatePatient(NewPatientDTO patient);


    //public Task<AppResult<bool>> SeedPatient();



}