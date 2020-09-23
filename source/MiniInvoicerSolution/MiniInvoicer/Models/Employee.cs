using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace MiniInvoicer.Models
{
    public class Employee
    {
        [Key]
        public int EmployeeID { get; set; }

        [ForeignKey("UserId")]
        public string UserId { get; set; }

        [ForeignKey("CompanyID")]
        public int CompanyID { get; set; }

        [ForeignKey("DepartmentID")]
        public int DepartmentID { get; set; }

        [ForeignKey("TeamID")]
        public int TeamID { get; set; }

        [ForeignKey("EmployeeTypeID")]
        public int TypeID { get; set; }

        [ForeignKey("EmployeeStatusID")]
        public int StatusID { get; set; }

        [ForeignKey("NationalityID")]
        public int NationalityID { get; set; }

        [ForeignKey("AddressID")]
        public int HomeAddressID { get; set; }

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
