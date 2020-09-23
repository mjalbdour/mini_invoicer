using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace MiniInvoicer.Models
{
    public class AssignedEmployeeStatus
    {
        [Key]
        public int AssignedEmployeeStatusID { get; set; }

        [ForeignKey("EmployeeStatusID")]
        public int EmployeeStatusID { get; set; }

        [ForeignKey("EmployeeID")]
        public int EmployeeID { get; set; }

        [Timestamp]
        [DataType(DataType.DateTime)]
        public DateTime LastChanged { get; set; }
    }
}
