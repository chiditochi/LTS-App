using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper.Configuration.Annotations;
using Microsoft.AspNetCore.Identity;

namespace Long_Term_Segregation.Models
{
    public class AppUser : IdentityUser<long>
    {
        public AppUser()
        {

        }
    }
}
