using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Long_Term_Segregation.Models;

public class UserAssessltsrevpatient
{
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
            
    */

    [Key]
    public long Id { get; set; }
    // [Column("system_ValidationData")]
    // public int? SystemValidationData { get; set; }
    [Column("LTSreviewoutcome")]
    [StringLength(20)]
    public string? LTSReviewOutcome { get; set; }
    public string? LTSComments { get; set; }
    [StringLength(15)]
    public string ClientID { get; set; }
    public DateTime? AssessmentDate { get; set; }
    public DateTime? LTSReview { get; set; }
    public DateTime? LTStart { get; set; }
    [Column("type12_NoteID")]
    public int Type12NoteID { get; set; }
    [Column("type12_OriginalNoteID")]
    public int? Type12OriginalNoteID { get; set; }
    [Column("type12_DeletedDate")]
    public DateTime? Type12DeletedDate { get; set; }
    [Column("type12_UpdatedBy")]
    [StringLength(20)]
    public string? Type12UpdatedBy { get; set; }
    [Column("type12_UpdatedDate")]
    public DateTime? Type12UpdatedDate { get; set; }
    //[Column("type12_NoteGroup")]
    //public int Type12NoteGroup { get; set; }
    public DateTime? LTSExit { get; set; }
    [Column("patward")]
    [StringLength(40)]
    public string? PatWard { get; set; }
    [Column("patRC")]
    [StringLength(40)]
    public string? PatRC { get; set; }
    [Column("LTSReason")]
    [StringLength(20)]
    public string? LTSReason { get; set; }
    [Column("IR1SUISecRef")]
    [StringLength(200)]
    public string? IR1SUISecRef { get; set; }

    /*
        Required: 
        1. ClientId
        2. Type12NoteID
        3. Type12NoteGroup
        4. 
    */




}

