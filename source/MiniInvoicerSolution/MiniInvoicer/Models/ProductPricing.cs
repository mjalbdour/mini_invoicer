using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace MiniInvoicer.Models
{
    public class ProductPricing
    {
        [Key]
        public int ProductPricingID { get; set; }

        [ForeignKey("ProductID")]
        public int ProductID { get; set; }

        [ForeignKey("ProductPricingTypeID")]
        public int ProductPricingTypeID { get; set; }

        [Required]
        [Range(0.1, 9999)]
        public decimal Value { get; set; }
    }
}
