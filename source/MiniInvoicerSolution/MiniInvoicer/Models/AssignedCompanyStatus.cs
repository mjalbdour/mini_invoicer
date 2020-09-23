using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace MiniInvoicer.Models
{
    public class AssignedCompanyStatus
    {
        [Key]
        public int AssignedCompanyStatusID { get; set; }

        [ForeignKey("CompanyStatusID")]
        public int CompanyStatusID { get; set; }

        [ForeignKey("CompanyID")]
        public int CompanyID { get; set; }

        [Timestamp]
        [DataType(DataType.DateTime)]
        public DateTime LastChanged { get; set; }
    }
}
