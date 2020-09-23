using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace MiniInvoicer.Models
{
    public class Transaction
    {
        [Key]
        public int TransactionID { get; set; }

        [ForeignKey("AccountID")]
        public int FromAccountID { get; set; }

        [ForeignKey("AccountID")]
        public int ToAccountID { get; set; }

        [Required]
        [Column(TypeName = "money")]
        public decimal Value { get; set; }

        [Required]
        [DataType(DataType.DateTime)]
        public DateTime DateCreated { get; set; }
    }
}
