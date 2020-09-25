using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace MiniInvoicer.Models
{
    public class Warehouse : IAddressHolder
    {
        [Key]
        public int WarehouseID { get; set; }

        [ForeignKey("CompanyID")]
        public int CompanyID { get; set; }
        public Company Company { get; set; }

        public Address Address { get; set; }

        [Required]
        [MinLength(3)]
        public string Name { get; set; }

        [Required]
        public int Number { get; set; }

        public string Description { get; set; }

    }
}
