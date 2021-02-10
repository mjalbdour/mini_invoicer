using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace MiniInvoicerMVC.Models
{
    public class InvoiceProduct
    {
        [Key]
        public int InvoiceProductId { get; set; }

        [ForeignKey("InvoiceId")]
        public int InvoiceId { get; set; }

        [ForeignKey("ProductId")]
        public int ProductId { get; set; }

        public int Quantity { get; set; }
    }
}
