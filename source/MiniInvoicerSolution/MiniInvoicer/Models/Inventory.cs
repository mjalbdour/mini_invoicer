using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace MiniInvoicer.Models
{
    public class Inventory
    {
        [Key]
        public int InventoryID { get; set; }

        [ForeignKey("ProductID")] 
        public int ProductID { get; set; }
        public Product Product { get; set; }

        [ForeignKey("WarehouseID")]
        public int WarehouseID { get; set; }
        public Warehouse Warehouse { get; set; }

        [Required]
        [Range(1, 9999999)]
        public int Quantity { get; set; }
    }
}
