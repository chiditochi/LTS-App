
using System.IO.Compression;
using Bogus;
using Long_Term_Segregation.Models;
using Long_Term_Segregation.Models.DTOs;
using Long_Term_Segregation.Services.interfaces;

namespace Long_Term_Segregation.Services.Implementations;

public class AppDataService : IAppDataService
{
    private readonly ILogger<AppDataService> _logger;
    private readonly IConfiguration _config;
    private readonly int _seed;

    public AppDataService(
        ILogger<AppDataService> logger,
        IConfiguration configuration
    )
    {
        _logger = logger;
        _config = configuration;

        _seed = 12345;

    }
    public Task<AppResult<DutyTypeDTO>> GetDutyTypes()
    {
        var result = new AppResult<DutyTypeDTO>();
        result.Data = new List<DutyTypeDTO>()
        {
            new DutyTypeDTO()
            {
                DutyTypeId = 1,
                Name = "Ward",
                CreatedAt = DateTime.Now,
                UpdatedAt = DateTime.Now
            },
            new DutyTypeDTO()
            {
                DutyTypeId = 2,
                Name = "Clinician",
                CreatedAt = DateTime.Now,
                UpdatedAt = DateTime.Now

            }
        };

        result.Status = true;
        return Task.FromResult(result);


    }

    public async Task<AppResult<PatientDTO>> GetPatients(long seed)
    {
        var result = new AppResult<PatientDTO>();
        int _customSeed = Convert.ToInt32(seed);

        var wards = await GetWards();
        var wardRange = Enumerable.Range(1, wards.Data.Count).ToArray();

        Randomizer.Seed = new Random(_customSeed);
        for (int i = 0; i < 20; i++)
        {
            var item = new Faker<PatientDTO>()
                             .RuleFor(x => x.PatientId, t => ++i)
                             .RuleFor(x => x.WardId, t => t.PickRandom(wardRange))
                             .RuleFor(x => x.FirstName, t => t.Person.FirstName)
                             .RuleFor(x => x.LastName, t => t.Person.LastName)
                             .RuleFor(x => x.CreatedAt, t => t.Date.Past(2))
                             .RuleFor(x => x.UpdatedAt, t => t.Date.Past(1));
            result.Data.Add(item);

        }
        result.Status = true;
        result.Message = $"Patients Retrieved";

        return result;
    }

    public Task<AppResult<ReviewOutcomeDTO>> GetReviewOutcomes()
    {
        var result = new AppResult<ReviewOutcomeDTO>();
        string[] outcomes = {
            "No Issues",
            "Requires Follow up",
            "No Longer In LTS"
        };

        Randomizer.Seed = new Random(_seed);
        for (int i = 0; i < outcomes.Length; i++)
        {
            var item = new Faker<ReviewOutcomeDTO>()
                             .RuleFor(x => x.Text, t => outcomes[i])
                             .RuleFor(x => x.ReviewOutcomeId, t => i + 1)
                             .RuleFor(x => x.CreatedAt, t => t.Date.Past(2))
                             .RuleFor(x => x.UpdatedAt, t => t.Date.Past(1));

            result.Data.Add(item);

        }

        return Task.FromResult(result);
    }

    public async Task<AppResult<UserDTO>> GetUsers()
    {
        var result = new AppResult<UserDTO>();

        var duties = await GetDutyTypes();
        var dutyRange = Enumerable.Range(1, duties.Data.Count).ToArray();
        var usertypes = await GetUserTypes();
        var usertypesRange = Enumerable.Range(1, usertypes.Data.Count).ToArray();

        Randomizer.Seed = new Random(_seed);
        for (int i = 0; i < 5; i++)
        {
            var item = new Faker<UserDTO>()
                             .RuleFor(x => x.UserId, t => ++i)
                             .RuleFor(x => x.DutyTypeId, t => t.PickRandom(dutyRange))
                             .RuleFor(x => x.UserTypeId, t => t.PickRandom(usertypesRange))
                             .RuleFor(x => x.FirstName, t => t.Person.FirstName)
                             .RuleFor(x => x.LastName, t => t.Person.LastName)
                             .RuleFor(x => x.CreatedAt, t => t.Date.Past(2))
                             .RuleFor(x => x.UpdatedAt, t => t.Date.Past(1));
            result.Data.Add(item);

        }
        result.Status = true;

        return result;
    }

    public Task<AppResult<UserTypeDTO>> GetUserTypes()
    {
        var result = new AppResult<UserTypeDTO>();
        result.Data = new List<UserTypeDTO>()
        {
            new UserTypeDTO()
            {
                UserTypeId = 1,
                Name = "Doctor",
                Label = "Dr.",
                CreatedAt = DateTime.Now,
                UpdatedAt = DateTime.Now
            },
            new UserTypeDTO()
            {
                UserTypeId = 2,
                Name = "Nurse",
                Label = null,
                CreatedAt = DateTime.Now,
                UpdatedAt = DateTime.Now

            }
        };

        result.Status = true;
        return Task.FromResult(result);

    }

    public Task<AppResult<WardDTO>> GetWards()
    {
        var result = new AppResult<WardDTO>();
        Randomizer.Seed = new Random(_seed);
        for (int i = 0; i < 5; i++)
        {
            var item = new Faker<WardDTO>()
                             .RuleFor(x => x.WardId, t => ++i)
                             .RuleFor(x => x.Name, t => t.Name.FullName())
                             .RuleFor(x => x.CreatedAt, t => t.Date.Past(2))
                             .RuleFor(x => x.UpdatedAt, t => t.Date.Past(1));
            result.Data.Add(item);

        }
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

        var resultItem = new SetupDataDTO(dutyTypesResult.Data, wardsResult.Data, doctorResult.Data.First(), reviewOutcomes.Data);

        result.Data.Add(resultItem);
        result.Status = true;
        result.Message = $"Setup Data Retrieved!";

        return result;
    }

    public async Task<AppResult<PatientDTO>> GetPatients(long doctorsId, long dutyTypeId, long? wardId)
    {
        var result = new AppResult<PatientDTO>();
        var seedValue = doctorsId + dutyTypeId;
        if (wardId != null) seedValue += wardId.Value;
        result = await GetPatients(seedValue);
        return result;
    }
    public async Task<AppResult<bool>> CommitPatients(IEnumerable<PatientCaseFileDTO> patientCasesFiles)
    {
        var result = new AppResult<bool>();
        // var seedValue = doctorsId + dutyTypeId;
        // if (wardId != null) seedValue += wardId.Value;
        // result = await GetPatients(seedValue);
        return result;
    }




}