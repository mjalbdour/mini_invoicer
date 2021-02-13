using System.Collections.Generic;

namespace MiniInvoicer.Server.Models
{
    public class Product
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public int SalesTax { get; set; }

        public ICollection<PricingType> PricingTypes { get; set; }
    }
}