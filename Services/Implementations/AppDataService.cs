
using System.IO.Compression;
using Bogus;
using Long_Term_Segregation.Data;
using Long_Term_Segregation.Models;
using Long_Term_Segregation.Models.DTOs;
using Long_Term_Segregation.Services.interfaces;
using Newtonsoft.Json;

namespace Long_Term_Segregation.Services.Implementations;

public class AppDataService : IAppDataService
{
    private readonly ILogger<AppDataService> _logger;
    private readonly IConfiguration _config;
    private AppDataContext _appDataContext;
    private readonly int _seed;
    private readonly int _pageSize;

    private List<PatientCaseFileDTO> _patientCases;

    public AppDataService(
        ILogger<AppDataService> logger,
        IConfiguration configuration,
        AppDataContext appDataContext
    )
    {
        _logger = logger;
        _config = configuration;

        var db = appDataContext.GetDbContext();
        _appDataContext = db.Data.First();

        _patientCases = new List<PatientCaseFileDTO>();

        _seed = 12345;
        _pageSize = Convert.ToInt32(_config.GetSection("App:PageSize").Value);

    }
    public Task<AppResult<DutyTypeDTO>> GetDutyTypes()
    {
        var result = new AppResult<DutyTypeDTO>();
        result.Data = _appDataContext.DutyTypes.ToList();
        //_logger.LogInformation(JsonConvert.SerializeObject(result.Data));

        result.Status = true;
        return Task.FromResult(result);

    }

    private async Task<AppResult<PatientDTO>> GetPatientList(long userId, long dutyTypeId, int page, long? wardId)
    {
        var result = new AppResult<PatientDTO>();

        var resultItem = _appDataContext.Patients
                                        .Where(x => x.UserId == userId && x.DutyTypeId == dutyTypeId && x.WardId == wardId)
                                        .ToList();

        //remove already posted data 
        var patientIds = _patientCases
                            .Where(x => x.UserId == userId && x.DutyTypeId == dutyTypeId && x.WardId == wardId)
                            .Select(x => x.PatientId).ToList();
        resultItem = resultItem.Where(x => !patientIds.Contains(x.PatientId)).ToList();

        var skipCount = (page - 1) * _pageSize;
        var resultItemData = resultItem.ToArray().Skip(skipCount).Take(_pageSize).ToList();
        //_logger.LogInformation(JsonConvert.SerializeObject(resultItemData));
        result.Data.AddRange(resultItemData);

        result.TotalPages = Math.Ceiling(Convert.ToDouble((double)resultItem.Count / _pageSize));
        result.Page = page;
        result.PageSize = _pageSize;

        result.Status = true;
        result.Message = $"Patients Retrieved";

        return result;
    }

    public Task<AppResult<ReviewOutcomeDTO>> GetReviewOutcomes()
    {
        var result = new AppResult<ReviewOutcomeDTO>();
        result.Data = _appDataContext.ReviewOutcomes.ToList();
        result.Status = true;
        //_logger.LogInformation(JsonConvert.SerializeObject(result.Data));

        return Task.FromResult(result);
    }

    public async Task<AppResult<UserDTO>> GetUsers()
    {
        var result = new AppResult<UserDTO>();

        result.Data = _appDataContext.Users.ToList();
        //_logger.LogInformation(JsonConvert.SerializeObject(result.Data));

        result.Status = true;
        return result;
    }

    public Task<AppResult<UserTypeDTO>> GetUserTypes()
    {
        var result = new AppResult<UserTypeDTO>();
        result.Data = _appDataContext.UserTypes.ToList();
        //_logger.LogInformation(JsonConvert.SerializeObject(result.Data));

        result.Status = true;
        return Task.FromResult(result);

    }

    public Task<AppResult<WardDTO>> GetWards()
    {
        var result = new AppResult<WardDTO>();
        Randomizer.Seed = new Random(_seed);

        result.Data = _appDataContext.Wards.ToList();
        // _logger.LogInformation(JsonConvert.SerializeObject(result.Data));

        result.Status = true;
        return Task.FromResult(result);

    }

    public async Task<AppResult<SetupDataDTO>> GetSetupData()
    {
        /*
            1. get DutyTypes
            2. get Wards
            3. get Doctor
        */
        var result = new AppResult<SetupDataDTO>();
        var dutyTypesResult = await GetDutyTypes();
        var wardsResult = await GetWards();
        var doctorResult = await GetUsers();
        var reviewOutcomes = await GetReviewOutcomes();

        //_logger.LogInformation(JsonConvert.SerializeObject(reviewOutcomes.Data));

        var resultItem = new SetupDataDTO(dutyTypesResult.Data, wardsResult.Data, doctorResult.Data.First(), reviewOutcomes.Data);

        result.Data.Add(resultItem);
        result.Status = true;
        result.Message = $"Setup Data Retrieved!";

        return result;
    }

    public async Task<AppResult<PatientDTO>> GetPatients(long doctorsId, long dutyTypeId, int page, long? wardId)
    {
        var result = new AppResult<PatientDTO>();

        if (page < 1) page = 1;
        result = await GetPatientList(doctorsId, dutyTypeId, page, wardId);
        return result;
    }
    public async Task<AppResult<bool>> CommitPatients(IEnumerable<PatientCaseFileDTO> patientCasesFiles)
    {
        var result = new AppResult<bool>();

        foreach (var patientItem in patientCasesFiles)
        {
            patientItem.CreatedAt = DateTime.Now;
            patientItem.UpdatedAt = DateTime.Now;
            _patientCases.Add(patientItem);

        }

        result.Status = true;
        result.Message = $"Saved {patientCasesFiles.Count()} Patient Records";
        await Task.Delay(0);
        return result;
    }

    public async Task<AppResult<bool>> CreatePatient(NewPatientDTO patient)
    {
        var result = new AppResult<bool>();
        try
        {
            //add this new Patient to _appDataContext.Patient array 
            var dto = new PatientDTO();
            dto.FirstName = patient.FirstName;
            dto.LastName = patient.LastName;
            dto.CreatedAt = DateTime.Now;
            dto.UpdatedAt = DateTime.Now;
            dto.StartDate = patient.StartDate;
            dto.DutyTypeId = patient.DutyTypeId;
            dto.UserId = patient.UserId;
            dto.WardId = patient.WardId == 0 ? null : patient.WardId;

            var lastId = _appDataContext.Patients.Where(x => x.UserId == patient.UserId && x.DutyTypeId == patient.DutyTypeId && x.WardId == dto.WardId).Count();

            dto.PatientId = ++lastId;
            var patientList =  _appDataContext.Patients.ToList();
            patientList.Add(dto);
            _appDataContext.Patients = patientList;

            //_logger.LogInformation(JsonConvert.SerializeObject(dto));

            result.Status = true;
            result.Message = $"User {patient.LastName}, {patient.FirstName} Created";
            result.Data.Add(true);

        }
        catch (Exception ex)
        {
            result.Status = true;
            result.Message = ex.Message;
        }

        return result;
    }







}