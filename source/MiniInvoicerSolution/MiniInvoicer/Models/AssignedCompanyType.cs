using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace MiniInvoicer.Models
{
    public class AssignedCompanyType
    {
        [Key]
        public int AssignedCompanyTypeID { get; set; }

        [ForeignKey("CompanyTypeID")]
        public int CompanyTypeID { get; set; }
        public CompanyType CompanyType { get; set; }

        [ForeignKey("CompanyID")]
        public int CompanyID{ get; set; }
        public Company Company { get; set; }

    }
}
