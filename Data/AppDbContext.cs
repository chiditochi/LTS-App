using Long_Term_Segregation.Models;
using Long_Term_Segregation.Models.DTOs;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;

namespace Long_Term_Segregation.Data;

public class AppDbContext : IdentityDbContext<AppUser, AppRole, long>
{
    public AppDbContext(DbContextOptions<AppDbContext> options) : base(options)
    {
    }


    public virtual DbSet<DutyTypeDTO> DutyTypes { get; set; } = null!;
    public virtual DbSet<UserTypeDTO> UserTypes { get; set; } = null!;
    public virtual DbSet<ReviewOutcomeDTO> ReviewOutcomes { get; set; } = null!;
    public virtual DbSet<WardDTO> Wards { get; set; } = null!;
    public virtual DbSet<UserDTO> Users { get; set; } = null!;
    public virtual DbSet<PatientDTO> Patients { get; set; } = null!;
    public virtual DbSet<UserAssessltsrevpatient> UserAssessltsrevpatients { get; set; } = null!;

    
}
