
using System.Data.SqlTypes;
using System.Net;
using Long_Term_Segregation.Data;
using Long_Term_Segregation.Models;
using Long_Term_Segregation.Models.DTOs;
using Long_Term_Segregation.Services.interfaces;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using Microsoft.AspNetCore.Http;
using System.Text;

namespace Long_Term_Segregation.Services.Implementations;

public class AppDataService : IAppDataService
{
    private readonly ILogger<AppDataService> _logger;
    private readonly IConfiguration _config;
    private readonly AppDbContext _context;
    private readonly IHttpClientFactory _httpClientFactory;
    private AppDataContext _appDataContext;
    private readonly int _seed;
    private readonly int _pageSize;

    private List<PatientCaseFileDTO> _patientCases;

    public AppDataService(
        ILogger<AppDataService> logger,
        IConfiguration configuration,
        AppDataContext appDataContext,
        AppDbContext context,
        IHttpClientFactory httpClientFactory
    )
    {
        _logger = logger;
        _config = configuration;
        _context = context;
        _httpClientFactory = httpClientFactory;

        var db = appDataContext.GetDbContext();
        _appDataContext = db.Data.First();

        _patientCases = new List<PatientCaseFileDTO>();

        _seed = 12345;
        _pageSize = Convert.ToInt32(_config.GetSection("App:PageSize").Value);

    }
    public async Task<AppResult<DutyTypeDTO>> GetDutyTypes()
    {
        var result = new AppResult<DutyTypeDTO>();
        result.Data = await _context.DutyTypes.ToListAsync();
        //_logger.LogInformation(JsonConvert.SerializeObject(result.Data));

        result.Status = true;
        return result;

    }

    private async Task<AppResult<PatientDTO>> GetPatientList(long userId, long dutyTypeId, int page, long? wardId)
    {
        var result = new AppResult<PatientDTO>();

        try
        {
            var resultItem = await _context.Patients
                                                    .Where(x => x.UserId == userId && x.DutyTypeId == dutyTypeId && x.WardId == wardId)
                                                    .ToListAsync();

            //remove already posted data 
            // var patientIds = _patientCases
            //                     .Where(x => x.UserId == userId && x.DutyTypeId == dutyTypeId && x.WardId == wardId)
            //                     .Select(x => x.PatientId).ToList();

            var patientIds = _context.UserAssessltsrevpatients
                                .AsEnumerable()
                                .Where(x => x.AssessmentDate.Value.ToString("yyyy-MM-dd") == DateTime.Now.ToString("yyyy-MM-dd"))
                                .Select(x => Convert.ToDouble(x.ClientID)).ToList();

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
        }
        catch (Exception ex)
        {
            result.Status = false;
            result.Message = $"Erro Retrieving Patients";
            _logger.LogError(ex.Message);
        }

        return result;
    }

    public async Task<AppResult<ReviewOutcomeDTO>> GetReviewOutcomes()
    {
        var result = new AppResult<ReviewOutcomeDTO>();
        result.Data = await _context.ReviewOutcomes.ToListAsync();
        result.Status = true;
        //_logger.LogInformation(JsonConvert.SerializeObject(result.Data));

        return result;
    }

    public async Task<AppResult<UserDTO>> GetUsers()
    {
        var result = new AppResult<UserDTO>();

        result.Data = await _context.Users.ToListAsync();
        //_logger.LogInformation(JsonConvert.SerializeObject(result.Data));

        result.Status = true;
        return result;
    }
    public async Task<AppResult<UserDTO>> GetUser(long userId)
    {
        var result = new AppResult<UserDTO>();

        var user = await _context.Users.FirstOrDefaultAsync(x => x.UserId == userId);
        if (user == null)
        {
            result.Status = false;
        }
        else
        {
            result.Status = true;
            result.Data.Add(user);
        }
        //_logger.LogInformation(JsonConvert.SerializeObject(result.Data));

        return result;
    }

    public Task<AppResult<UserTypeDTO>> GetUserTypes()
    {
        var result = new AppResult<UserTypeDTO>();
        result.Data = _context.UserTypes.ToList();
        //_logger.LogInformation(JsonConvert.SerializeObject(result.Data));

        result.Status = true;
        return Task.FromResult(result);

    }

    public Task<AppResult<WardDTO>> GetWards()
    {
        var result = new AppResult<WardDTO>();
        //Randomizer.Seed = new Random(_seed);

        result.Data = _context.Wards.ToList();
        // _logger.LogInformation(JsonConvert.SerializeObject(result.Data));

        result.Status = true;
        return Task.FromResult(result);

    }
    public async Task<AppResult<WardDTO>> GetWard(long wardId)
    {
        var result = new AppResult<WardDTO>();

        var w = await _context.Wards.FirstOrDefaultAsync(x => x.WardId == wardId);
        if (w == null)
        {
            result.Status = false;
        }
        else
        {
            result.Status = true;
            result.Data.Add(w);
        }
        //_logger.LogInformation(JsonConvert.SerializeObject(result.Data));

        return result;


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

    //persist to the db
    public async Task<AppResult<bool>> CommitPatients(IEnumerable<PatientCaseFileDTO> patientCasesFiles)
    {
        var result = new AppResult<bool>();

        try
        {
            var id = patientCasesFiles.First().UserId;
            var userResult = await GetUser(id);
            if (!userResult.Status) throw new Exception($"Error fetching user with UserId = {id}");
            var patRc = userResult.Data.First();

            var wardsResult = await GetWards();
            if (!wardsResult.Status) throw new Exception($"Error fetching ward with WardIds");
            var wards = wardsResult.Data;

            var reviewOutcomesResult = await GetReviewOutcomes();
            if (!reviewOutcomesResult.Status) throw new Exception($"Error fetching ReviewOutcomes");
            var reviewOutcomes = reviewOutcomesResult.Data;

            foreach (var patientItem in patientCasesFiles)
            {
                var p = new UserAssessltsrevpatient();
                p.ClientID = patientItem.PatientId.ToString();
                p.Type12NoteID = (int)patientItem.PatientId;
                //p.Type12NoteGroup = (int)patientItem.PatientId;

                p.LTSReason = "RP05";
                p.PatRC = $"{patRc.Title} {patRc.FirstName} {patRc.LastName}";
                var patWard = wards.FirstOrDefault(x => x.WardId == patientItem.WardId);
                p.PatWard = patWard?.Name;

                p.LTSExit = patientItem.ExitTime;
                var outcome = reviewOutcomes.FirstOrDefault(x => x.ReviewOutcomeId == patientItem.ReviewOutcomeId);
                p.LTSReviewOutcome = outcome?.Text;
                p.LTSComments = patientItem.Comment;
                p.AssessmentDate = DateTime.Now;
                p.LTSReview = DateTime.Now;
                p.LTStart = patientItem.StartDate.ToNullIfTooEarlyForDb();

                _context.UserAssessltsrevpatients.Add(p);
            }

            await _context.SaveChangesAsync();
            result.Status = true;
            result.Message = $"Saved {patientCasesFiles.Count()} Patient Records";

        }
        catch (Exception ex)
        {
            result.Status = false;
            _logger.LogError(ex.Message);
        }

        return result;
    }

    public async Task<AppResult<bool>> CreatePatient(NewPatientDTO patient)
    {
        var result = new AppResult<bool>();
        try
        {
            var patientWardId = patient.WardId == 0 ? null : patient.WardId;

            var patientWard = string.Empty;
            if (patientWardId != null)
            {
                var wardsResult = await GetWard(patientWardId.Value);
                if (!wardsResult.Status) throw new Exception($"Error fetching ward with WardIds");
                var patientWardResult = wardsResult.Data.First();
                if (!string.IsNullOrEmpty(patientWardResult.Name)) patientWard = patientWardResult.Name;
            }

            var id = patient.UserId;
            var userResult = await GetUser(id);
            if (!userResult.Status) throw new Exception($"Error fetching user with UserId = {id}");
            var patRc = userResult.Data.First();

            PatientData pd = new PatientData();
            pd.UserCode = patient.UserId.ToString();

            var questionTextDic = new Dictionary<string, string>()
            {
                {"LTSComments", string.Empty},
                {"AssessmentDate", DateTime.Now.ToString()},
                {"LTSReview", DateTime.Now.ToString()},
                {"LTSExit", DateTime.Now.ToString()},
                {"LTStart", patient.StartDate.ToString()},
                {"LTSreviewoutcome", string.Empty},
                {"patward", patientWard},
                {"patRC", $"{patRc.FirstName} {patRc.LastName}"}
            };
            foreach (var questionItem in questionTextDic)
            {
                var question = new Question();
                question.QuestionCode = questionItem.Key;
                question.QuestionText = questionItem.Value;
                pd.Questions.Add(question);
            }

            var apiUrl = _config.GetSection("App:NewPatientApi").Value;
            var request = new HttpRequestMessage();
            //request.Headers.Add("Content-Type", "application/json");

            //request.RequestUri = new Uri(apiUrl);
            request.Method = HttpMethod.Post;
            var stringContent = JsonConvert.SerializeObject(pd);
            var requestContent = new StringContent(stringContent, Encoding.UTF8, "application/json");
            request.Content = requestContent;
            var client = _httpClientFactory.CreateClient("patient");
            var response = await client.SendAsync(request);
            if (response.StatusCode != HttpStatusCode.OK) throw new Exception(response.ReasonPhrase);

            result.Status = true;
            result.Message = $"User {patient.LastName}, {patient.FirstName} Created";
            result.Data.Add(true);

        }
        catch (Exception ex)
        {
            result.Status = false;
            result.Message = ex.Message;
            _logger.LogError(ex.Message);
        }

        return result;
    }

    // public async Task<AppResult<bool>> SeedPatient()
    // {
    //     var result = new AppResult<bool>();
    //     try
    //     {
    //         var dtos = _appDataContext.Patients.ToList();
    //         var dbPatientList = new List<PatientDTO>();
    //         foreach (var patientItem in dtos)
    //         {
    //             var patient = new PatientDTO();
    //             patient.DutyTypeId = patientItem.DutyTypeId;
    //             patient.UserId = patientItem.UserId;
    //             patient.WardId = patientItem.WardId;
    //             patient.FirstName = patientItem.FirstName;
    //             patient.LastName = patientItem.LastName;
    //             patient.StartDate = DateTime.Now;
    //             patient.UpdatedAt = DateTime.Now;
    //             patient.CreatedAt = DateTime.Now;

    //             dbPatientList.Add(patient);
    //         }

    //         _context.Patients.AddRange(dbPatientList);
    //         await _context.SaveChangesAsync();
    //         //_logger.LogInformation(JsonConvert.SerializeObject(dto));

    //         result.Status = true;
    //         result.Message = $"Seeded {dtos.Count()} Patients";
    //         result.Data.Add(true);

    //     }
    //     catch (Exception ex)
    //     {
    //         result.Status = true;
    //         result.Message = ex.Message;
    //         _logger.LogError($"Error Seeding patients");
    //     }

    //     return result;
    // }



}

public static class DbDateHelper
{
    /// <summary>
    /// Replaces any date before 01.01.1753 with a Nullable of 
    /// DateTime with a value of null.
    /// </summary>
    /// <param name="date">Date to check</param>
    /// <returns>Input date if valid in the DB, or Null if date is 
    /// too early to be DB compatible.</returns>
    public static DateTime? ToNullIfTooEarlyForDb(this DateTime date)
    {
        return (date >= (DateTime)SqlDateTime.MinValue) ? date : (DateTime?)null;
    }
}