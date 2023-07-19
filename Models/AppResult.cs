namespace Long_Term_Segregation.Models;

public class AppResult<T>
{
    public AppResult()
    {
        Data = new List<T>();
        Status = false;
        Message = string.Empty;
    }
    public bool Status { get; set; }
    public string Message { get; set; }
    public List<T> Data { get; set; }

    //for pagination
    public int? Page { get; set; }
    public int? PageSize { get; set; }
    public double? TotalPages { get; set; }
}