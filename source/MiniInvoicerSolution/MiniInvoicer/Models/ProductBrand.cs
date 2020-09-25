using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace MiniInvoicer.Models
{
    public class ProductBrand
    {
        [Key]
        public int ProductBrandID { get; set; }
        
        [ForeignKey("CountryID")]
        public int ManufacturingCountryID { get; set; }
        public Country Country { get; set; }
        public string Name { get; set; }
    }
}
