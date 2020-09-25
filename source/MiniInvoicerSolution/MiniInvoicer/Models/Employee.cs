using Microsoft.AspNetCore.Identity;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace MiniInvoicer.Models
{
    public class Employee : IdentityUser, IAccountHolder, IAddressHolder
    {
        [ForeignKey("CompanyID")]
        public int CompanyID { get; set; }
        public Company Company { get; set; }

        [ForeignKey("DepartmentID")]
        public int DepartmentID { get; set; }
        public Department Department { get; set; }

        [ForeignKey("TeamID")]
        public int TeamID { get; set; }
        public Team Team { get; set; }

        [ForeignKey("EmployeeTypeID")]
        public int TypeID { get; set; }
        public EmployeeType EmployeeType { get; set; }

        [ForeignKey("EmployeeStatusID")]
        public int StatusID { get; set; }
        public EmployeeStatus EmployeeStatus { get; set; }

        [ForeignKey("NationalityID")]
        public int NationalityID { get; set; }
        public Nationality Nationality { get; set; }

        [ForeignKey("AddressID")]
        public int HomeAddressID { get; set; }
        public Address Address { get; set; }

        public Account Account { get; set; }

        [Required]
        [MinLength(2)]
        public string FirstName { get; set; }

        [Required]
        [MinLength(2)]
        public string FatherName { get; set; }

        [Required]
        [MinLength(2)]
        public string GrandfatherName { get; set; }

        [Required]
        [MinLength(2)]
        public string FamilyName { get; set; }

        [Required]
        [DataType(DataType.Date)]
        public DateTime BirthDate { get; set; }
    }
}
