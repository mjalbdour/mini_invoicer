using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace MiniInvoicer.Models
{
    public class AssignedEmployeeType
    {
        [Key]
        public int AssignedEmployeeTypeID { get; set; }

        [ForeignKey("EmployeeTypeID")]
        public int EmployeeTypeID { get; set; }
        public EmployeeType EmployeeType { get; set; }

        [ForeignKey("EmployeeID")]
        public int EmployeeID { get; set; }
        public Employee Employee { get; set; }

        // TODO: Create SalesRep Table and Manager Table where each extend Employee and has their own columns
    }
}
