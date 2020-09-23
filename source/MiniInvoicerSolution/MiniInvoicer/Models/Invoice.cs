using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace MiniInvoicer.Models
{
    public class Invoice
    {
        [Key]
        public int InvoiceID { get; set; }

        [ForeignKey("OrderID")]
        public int OrderID { get; set; }

        [Required]
        [Range(1, 999999)]
        public decimal Value { get; set; }

        [Required]
        public int TimesPrinted { get; set; }

        [Required]
        public DateTime DateCreated { get; set; }
    }
}
