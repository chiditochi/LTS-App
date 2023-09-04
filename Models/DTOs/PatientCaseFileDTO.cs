namespace Long_Term_Segregation.Models.DTOs;

public class PatientCaseFileDTO
{
    //public long PatientCaseFileId { get; set; }
    public long PatientId { get; set; }
    public long ReviewOutcomeId { get; set; }
    public long UserId { get; set; }
    public long DutyTypeId { get; set; }
    public long? WardId { get; set; }
    public string? Comment { get; set; }
    public DateTime StartDate { get; set; }
    public DateTime ReviewTime { get; set; }
    public DateTime? ExitTime { get; set; }
    public DateTime CreatedAt { get; set; }
    public DateTime UpdatedAt { get; set; }



    //--------------------------
/*
Id	bigint	Unchecked
system_ValidationData	xml	Checked
LTSreviewoutcome	nvarchar(20)	Checked
LTSComments	ntext	Checked
ClientID	nvarchar(15)	Unchecked
AssessmentDate	datetime	Checked
LTSReview	datetime	Checked
LTStart	datetime	Checked
type12_NoteID	int	Unchecked
type12_OriginalNoteID	int	Checked
type12_DeletedDate	datetime	Checked
type12_UpdatedBy	nvarchar(20)	Checked
type12_UpdatedDate	datetime	Checked
type12_NoteGroup		Unchecked
LTSExit	datetime	Checked
patward	nvarchar(40)	Checked
patRC	nvarchar(40)	Checked
LTSReason	nvarchar(20)	Checked
IR1SUISecRef	nvarchar(200)	Checked
		Unchecked
*/
    

    

}

