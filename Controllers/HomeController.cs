using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using Long_Term_Segregation.Models;
using Long_Term_Segregation.Services.interfaces;
using Newtonsoft.Json;
using Long_Term_Segregation.Models.DTOs;

namespace Long_Term_Segregation.Controllers;

public class HomeController : Controller
{
    private readonly ILogger<HomeController> _logger;
    private readonly IAppDataService _appDataService;

    public HomeController(
        ILogger<HomeController> logger,
        IAppDataService appDataService
        )
    {
        _logger = logger;
        _appDataService = appDataService;
    }

    [HttpGet("/")]
    [HttpGet("/Home/Index")]
    public IActionResult Index()
    {
        return View();
    }

    [HttpGet("/Home/SetupData")]
    public async Task<IActionResult> GetSetupData()
    {
        var result = await _appDataService.GetSetupData();
        var data = JsonConvert.SerializeObject(result);
        //_logger.LogInformation(data);
        return Json(new { Data = result });
    }

    [HttpGet("/Home/DoctorsPatient/{DoctorId:long}/{DutyTypeId:long}/{WardId}")]
    public async Task<IActionResult> GetDoctorsPatients(long DoctorId, long DutyTypeId, long? WardId,[FromQuery] int? page = 1)
    {
        var result = await _appDataService.GetPatients(DoctorId, DutyTypeId, page.Value!, WardId);
        //var data = JsonConvert.SerializeObject(result);
        //_logger.LogInformation(data);
        return Json(new { Data = result });
    }

    [HttpPost("/Home/Patient")]
    public async Task<IActionResult> CommitPatient([FromBody] IEnumerable<PatientCaseFileDTO> patientCaseFiles)
    {
        var result = await _appDataService.CommitPatients(patientCaseFiles);
        //var data = JsonConvert.SerializeObject(result);
        //_logger.LogInformation(data);
        return Json(new { Data = result });
    }

    [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
    public IActionResult Error()
    {
        return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
    }
}
