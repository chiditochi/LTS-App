
DutyType	ReviewOutCome	Ward	UserType	User	Patient	PatientCaseFile	PatientCaseFile
DutyTypeId	ReviewOutComeId	WardId	UserTypeId	UserId	PatientId	PatientCaseFileId	PatientCaseFileId
Name	Text	Name	Name	UserTypeId	FirstName	PatientId	PatientId
CreatedAt	CreatedAt	CreatedAt	CreatedAt	DutyTypeId	LastName	ReviewTime	ReviewTime
UpdatedAt	UpdatedAt	UpdatedAt	UpdatedAt		WardId?	ExitTime?	ExitTime?
				FirstName	CreatedAt	ReviewOutCome	ReviewOutCome
				LastName	UpdatedAt	Comment	Comment
				CreatedAt			
Ward			Doctor	UpdatedAt		CreatedAt	CreatedAt
Clinician			Nurse			UpdatedAt	UpdatedAt



### Todos
	- 1. persist the selected patientCaseFile data to the database
	- 2. call external api to create new patient















	- add a db.json file 
		- dutyType

		- reviewOutCome
		- ward
		- userType
		- patient (40)
			- ward patient (20 * no-of-wards)
			- clinician (20)
	- on post keep a list 
		- CompletedPatients 
	- on get patients 
		- exclude specified patients from the list 
	- change Comment btn color upon adding comment 




var jsonFilePath = Path.Combine(_wenv.ContentRootPath, "data.json");
string jsonFile = File.ReadAllText(jsonFilePath);
TestData jsonData = JsonConvert.DeserializeObject<TestData>(jsonFile)!;



------------------ Api --------------------
1. setupData 
	a. dutyTypesResult
	b. wardsResult
	c. doctorResult
	d. reviewOutcomes

2. create patient 
