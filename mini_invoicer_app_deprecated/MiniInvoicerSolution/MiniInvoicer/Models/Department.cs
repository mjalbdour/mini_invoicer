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
        public Company Company { get; set; }

        [ForeignKey("UserID")]
        public int ManagerID { get; set; }
        public Employee Employee { get; set; }


        [Required]
        [MinLength(3)]
        public string Name { get; set; }

        public string Description { get; set; }

    }
}
