using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace MiniInvoicer.Models
{
    public class Receipt
    {
        [Key]
        public int ReceiptID { get; set; }

        [ForeignKey("InvoiceID")]
        public int InvoiceID { get; set; }

        [ForeignKey("CurrencyID")]
        public int CurrencyID { get; set; }

        [Required]
        [Range(1, 99999)]
        [Column(TypeName = "money")]
        public decimal Value { get; set; }

        [Required]
        public DateTime DateCreated { get; set; }

        [Required]
        public int TimesPrinted { get; set; }

    }
}
