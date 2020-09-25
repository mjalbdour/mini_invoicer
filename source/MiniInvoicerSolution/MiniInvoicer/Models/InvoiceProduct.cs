using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace MiniInvoicer.Models
{
    public class InvoiceProduct
    {
        [Key]
        public int InvoiceProductID { get; set; }

        [ForeignKey("InvoiceID")]
        public int InvoiceID { get; set; }
        public Invoice Invoice { get; set; }

        [ForeignKey("ProductPricingID")]
        public int ProductPricingID { get; set; }
        public ProductPricing ProductPricing { get; set; }

        [Required]
        public int ProductQuantity { get; set; }
    }
}
