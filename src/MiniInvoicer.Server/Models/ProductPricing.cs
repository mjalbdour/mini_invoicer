namespace MiniInvoicer.Server.Models
{
    public class ProductPricing
    {
        public int Id { get; set; }
        public int ProductId { get; set; }
        public int PricingTypeId { get; set; }
        public decimal Value { get; set; }
    }
}