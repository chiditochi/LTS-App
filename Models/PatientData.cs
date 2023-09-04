namespace Long_Term_Segregation.Models;

public class PatientData
{

    public string Title { get; set; } = "LTS patients";
    public string Description { get; set; } = "LTS patients";
    public string UserCode { get; set; } = string.Empty;
    public List<Question> Questions { get; set; } = new List<Question>();

}


public class QuestionR
{
    public string QuestionCode { get; set; } = string.Empty;
    public string Type { get; set; } = string.Empty;
    public string QuestionText { get; set; } = string.Empty;
    public string Mandatory { get; set; } = string.Empty;
    public List<QuestionOptions>? Options { get; set; } = new List<QuestionOptions>();
}
public class Question
{
    public string QuestionCode { get; set; } = string.Empty;
    public string QuestionText { get; set; } = string.Empty;
}

public class QuestionOptions
{
    public string Answer { get; set;} = string.Empty;
    public string UserCode { get; set;} = string.Empty;
}

/*
{
    "Title": "LTS patients",
    "Description": "LTS patients",
    "UserCode": "ltsrevpatients",
    "VersionID": "20230816T085725947",
    "ValidationEnabled": "false",
    "Context": "A",
    "Questions": [
        {
            "QuestionCode": "LTSComments",
            "Type": "RichTextArea",
            "QuestionText": "Any Comments ",
            "Mandatory": "false",
            "Order": 14000,
            "Editable": "true"
        },
        {
            "QuestionCode": "AssessmentDate",
            "Type": "DateTime",
            "QuestionText": "Date/time of Assessment Form",
            "Mandatory": "true",
            "Order": 1000,
            "Editable": "true"
        },
        {
            "QuestionCode": "LTSReview",
            "Type": "DateTime",
            "QuestionText": "Date/Time Patient Reviewed",
            "Mandatory": "false",
            "Order": 12000,
            "Editable": "true"
        },
        {
            "QuestionCode": "LTSExit",
            "Type": "DateTime",
            "QuestionText": "Date/Time Patient Leaving LTS",
            "Mandatory": "false",
            "Order": 16000,
            "Editable": "true"
        },
        {
            "QuestionCode": "LTStart",
            "Type": "DateTime",
            "QuestionText": "LTS Start Date",
            "Mandatory": "true",
            "Order": 4000,
            "Editable": "true"
        },
        {
            "QuestionCode": "LTSreviewoutcome",
            "Type": "Select",
            "QuestionText": "Outcome of Daily Review",
            "Mandatory": "false",
            "Order": 12000,
            "Editable": "true",
            "Options": [
                {
                    "Answer": "LTS Review Completed ? No Issues",
                    "UserCode": "AO101"
                },
                {
                    "Answer": "LTS Review Completed ? Requires Follow-up",
                    "UserCode": "AO102"
                },
                {
                    "Answer": "LTS - Patient No Longer in LTS",
                    "UserCode": "AO103"
                }
            ]
        },
        {
            "QuestionCode": "LTSReason",
            "Type": "Select",
            "QuestionText": "Reason for LTS",
            "Mandatory": "true",
            "Order": 4000,
            "Editable": "true",
            "Options": [
                {
                    "Answer": "Actual Assault",
                    "UserCode": "RP03"
                },
                {
                    "Answer": "Advance Statement",
                    "UserCode": "RP06"
                },
                {
                    "Answer": "Attempted Assault",
                    "UserCode": "RP02"
                },
                {
                    "Answer": "Damage To Property",
                    "UserCode": "RP05"
                },
                {
                    "Answer": "Disruptive Behaviour (No Victim)",
                    "UserCode": "RP04"
                },
                {
                    "Answer": "Threatening Behaviour",
                    "UserCode": "RP01"
                }
            ]
        },
        {
            "QuestionCode": "patward",
            "Type": "Text",
            "QuestionText": "Ward",
            "Mandatory": "false",
            "Order": 2000,
            "Editable": "false"
        },
        {
            "QuestionCode": "patRC",
            "Type": "Text",
            "QuestionText": "Responsible Clinician",
            "Mandatory": "false",
            "Order": 2000,
            "Editable": "false"
        },
        {
            "QuestionCode": "IR1SUISecRef",
            "Type": "Text",
            "QuestionText": "IR1/SUI/Sec Ref ",
            "Mandatory": "false",
            "Order": 4000,
            "Editable": "true"
        },
        {
            "Type": "Horizontal",
            "Order": 3000
        },
        {
            "Type": "Horizontal",
            "Order": 5000
        },
        {
            "Type": "Horizontal",
            "Order": 15000
        },
        {
            "Type": "Horizontal",
            "Order": 17000
        }
    ]
}
*/