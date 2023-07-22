
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
    private readonly AppDataContext _appDataContext;
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
        // string[] outcomes = {
        //     "No Issues",
        //     "Requires Follow up",
        //     "No Longer In LTS"
        // };

        // Randomizer.Seed = new Random(_seed);
        // for (int i = 0; i < outcomes.Length; i++)
        // {
        //     var item = new Faker<ReviewOutcomeDTO>()
        //                      .RuleFor(x => x.Text, t => outcomes[i])
        //                      .RuleFor(x => x.ReviewOutcomeId, t => i + 1)
        //                      .RuleFor(x => x.CreatedAt, t => t.Date.Past(2))
        //                      .RuleFor(x => x.UpdatedAt, t => t.Date.Past(1));

        //     result.Data.Add(item);

        // }

        result.Data = _appDataContext.ReviewOutcomes.ToList();
        result.Status = true;
        //_logger.LogInformation(JsonConvert.SerializeObject(result.Data));

        return Task.FromResult(result);
    }

    public async Task<AppResult<UserDTO>> GetUsers()
    {
        var result = new AppResult<UserDTO>();

        // var duties = await GetDutyTypes();
        // var dutyRange = Enumerable.Range(1, duties.Data.Count).ToArray();
        // var usertypes = await GetUserTypes();
        //_logger.LogInformation(JsonConvert.SerializeObject(usertypes.Data));

        // var usertypesRange = Enumerable.Range(1, usertypes.Data.Count).ToArray();

        // Randomizer.Seed = new Random(_seed);
        // for (int i = 0; i < 5; i++)
        // {
        //     var item = new Faker<UserDTO>()
        //                      .RuleFor(x => x.UserId, t => ++i)
        //                      .RuleFor(x => x.DutyTypeId, t => t.PickRandom(dutyRange))
        //                      .RuleFor(x => x.UserTypeId, t => t.PickRandom(usertypesRange))
        //                      .RuleFor(x => x.FirstName, t => t.Person.FirstName)
        //                      .RuleFor(x => x.LastName, t => t.Person.LastName)
        //                      .RuleFor(x => x.CreatedAt, t => t.Date.Past(2))
        //                      .RuleFor(x => x.UpdatedAt, t => t.Date.Past(1));
        //     result.Data.Add(item);

        // }

        result.Data = _appDataContext.Users.ToList();
        //_logger.LogInformation(JsonConvert.SerializeObject(result.Data));

        result.Status = true;
        return result;
    }

    public Task<AppResult<UserTypeDTO>> GetUserTypes()
    {
        var result = new AppResult<UserTypeDTO>();
        // result.Data = new List<UserTypeDTO>()
        // {
        //     new UserTypeDTO()
        //     {
        //         UserTypeId = 1,
        //         Name = "Doctor",
        //         Label = "Dr.",
        //         CreatedAt = DateTime.Now,
        //         UpdatedAt = DateTime.Now
        //     },
        //     new UserTypeDTO()
        //     {
        //         UserTypeId = 2,
        //         Name = "Nurse",
        //         Label = null,
        //         CreatedAt = DateTime.Now,
        //         UpdatedAt = DateTime.Now

        //     }
        // };

        result.Data = _appDataContext.UserTypes.ToList();
        //_logger.LogInformation(JsonConvert.SerializeObject(result.Data));

        result.Status = true;
        return Task.FromResult(result);

    }

    public Task<AppResult<WardDTO>> GetWards()
    {
        var result = new AppResult<WardDTO>();
        Randomizer.Seed = new Random(_seed);
        // for (int i = 0; i < 5; i++)
        // {
        //     var item = new Faker<WardDTO>()
        //                      .RuleFor(x => x.WardId, t => ++i)
        //                      .RuleFor(x => x.Name, t => t.Name.FullName())
        //                      .RuleFor(x => x.CreatedAt, t => t.Date.Past(2))
        //                      .RuleFor(x => x.UpdatedAt, t => t.Date.Past(1));
        //     result.Data.Add(item);

        // }


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
            //if (
            //    patientItem.Comment != null 
            //    && !string.IsNullOrEmpty(patientItem.Comment) 
            //    && patientItem.Comment.Trim() != ""
            //)
            //{
            //    patientItem.Comment = patientItem.Comment.Trim();
            //}
            //else
            //{
            //    patientItem.Comment = null;
            //}

            _patientCases.Add(patientItem);

        }

        //_patientCases.AddRange(patientCasesFiles);
        result.Status = true;
        result.Message = $"Saved {patientCasesFiles.Count()} Patient Records";
        await Task.Delay(0);
        return result;
    }




}