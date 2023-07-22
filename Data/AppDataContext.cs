
using Long_Term_Segregation.Models;
using Long_Term_Segregation.Models.DTOs;
using Newtonsoft.Json;

namespace Long_Term_Segregation.Data;

public class AppDataContext
{
    private readonly string _contentRootPath;
    public AppDataContext(string contentRootPath)
    {
        _contentRootPath = contentRootPath;
        
        DutyTypes = new List<DutyTypeDTO>();
        UserTypes = new List<UserTypeDTO>();
        ReviewOutcomes = new List<ReviewOutcomeDTO>();
        Wards = new List<WardDTO>();
        Users = new List<UserDTO>();
        Patients = new List<PatientDTO>();

    }


    public IEnumerable<DutyTypeDTO> DutyTypes { get; set; }
    public IEnumerable<UserTypeDTO> UserTypes { get; set; }
    public IEnumerable<ReviewOutcomeDTO> ReviewOutcomes { get; set; }
    public IEnumerable<WardDTO> Wards { get; set; }
    public IEnumerable<UserDTO> Users { get; set; }
    public IEnumerable<PatientDTO> Patients { get; set; }

    public AppResult<AppDataContext> GetDbContext()
    {
        var result = new AppResult<AppDataContext>();
        try
        {
            /*
                
            */
            var jsonFilePath = Path.Combine(_contentRootPath, "Data", "db.json");
            string jsonFile = File.ReadAllText(jsonFilePath);
            var jsonData = JsonConvert.DeserializeObject<AppDataContext>(jsonFile)!;

            result.Data.Add(jsonData);
            result.Status = true;
            result.Message = $"Data fetched";

        }
        catch (Exception ex)
        {
            Console.WriteLine("AppDataContext Error {0} | {1}", ex.Message, ex.StackTrace);
            result.Status = false;
            result.Message = $"{ex.Message} | {ex.StackTrace}";
        }

        return result;
    }
}