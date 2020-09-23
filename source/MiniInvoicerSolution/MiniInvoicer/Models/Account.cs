using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace MiniInvoicer.Models
{
    public class Account
    {
        [Key]
        public int AccountID { get; set; }

        public int AccountHolderID { get; set; }

        [ForeignKey("AccountHolderTypeID")]
        public int AccountHolderTypeID { get; set; }

        [Required]
        [Column(TypeName = ("money"))]
        public decimal Balance { get; set; }

        [DataType(DataType.DateTime)]
        public DateTime LastUpdated { get; set; }
    }
}
