using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace MiniInvoicer.Models
{
    public class Product
    {
        [Key]
        public int ProductID { get; set; }

        [ForeignKey("BrandID")]
        public int BrandID { get; set; }
        public ProductBrand ProductBrand { get; set; }

        [ForeignKey("CompanyID")]
        public int CompanyID { get; set; }
        public Company Company { get; set; }

        [ForeignKey("CategoryID")]
        public int CategoryID { get; set; }
        public Category Category { get; set; }

        [Required]
        [MinLength(3)]
        public string Name { get; set; }
        public string Description { get; set; }
        public string Note { get; set; }

        [Range(1, 1000)]
        public int UnisPerPacket { get; set; }
        [Range(1, 1000)]
        public int PacketPerCase { get; set; }

        [Range(1, 99999)]
        public int UnitWeight { get; set; }

        [Range(1, 99999)]
        public int PacketWeight { get; set; }

        [Range(1, 99999)]
        public int CaseWeight { get; set; }

        [Required]
        [Column(TypeName = "money")]
        public decimal Tax { get; set; }
    }
}
