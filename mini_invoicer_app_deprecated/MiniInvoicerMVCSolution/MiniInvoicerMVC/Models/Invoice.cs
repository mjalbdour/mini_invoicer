using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace MiniInvoicerMVC.Models
{
    public class Invoice
    {
        public int InvoiceId { get; set; }

        public DateTime CreatedOn { get; set; }

        [ForeignKey("CustomerId")]
        public int CustomerId { get; set; }

        [Required, Column(TypeName = "decimal(8,2)")]
        public decimal Tax { get; set; }

        [Required, Column(TypeName = "decimal(8,2)")]
        public decimal Discount { get; set; }
    }
}
