using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace MiniInvoicer.Models
{
    public class CompanyType
    {
        [Key]
        public int CompanyTypeID { get; set; }

        [ForeignKey("TypeID")]
        public int TypeID { get; set; }

        [ForeignKey("CompanyID")]
        public int CompanyID{ get; set; }

    }
}
