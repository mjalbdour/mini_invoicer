using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace MiniInvoicer.Models
{
    public enum HolderType { Company, Employee, Customer }
    public class AccountHolderType
    {
        [Key]
        public int AccountHolderTypeID { get; set; }

        [Required]
        public HolderType HolderType { get; set; }
    }
}
