using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace MiniInvoicer.Models
{
    public class Department
    {
        [Key]
        public int DepartmentID { get; set; }

        [ForeignKey("CompanyID")]
        public int CompanyID { get; set; }

        [ForeignKey("EmployeeID")]
        public int ManagerID { get; set; }


        [Required]
        [MinLength(3)]
        public string Name { get; set; }

        public string Description { get; set; }

    }
}
