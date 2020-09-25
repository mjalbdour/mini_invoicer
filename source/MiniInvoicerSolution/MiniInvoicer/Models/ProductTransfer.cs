using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace MiniInvoicer.Models
{
    public class ProductTransfer
    {
        [Key]
        public int ProductTransferID { get; set; }

        [ForeignKey("WarehouseID")]
        public int FromWarehouseID { get; set; }
        public Warehouse FromWarehouse { get; set; }

        [ForeignKey("WarehouseID")]
        public int ToWarehouseID { get; set; }
        public Warehouse ToWarehouse { get; set; }

        public string Note { get; set; }

        [Column(TypeName = "money")]
        public decimal Value { get; set; }

        public DateTime DateCreated { get; set; }
    }
}
