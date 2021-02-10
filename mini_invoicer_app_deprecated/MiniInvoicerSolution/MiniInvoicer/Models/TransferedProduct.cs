using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace MiniInvoicer.Models
{
    public class TransferedProduct
    {
        [Key]
        public int TransferedProductID { get; set; }

        [ForeignKey("ProductTransferID")]
        public int ProductTransferID { get; set; }
        public ProductTransfer ProductTransfer { get; set; }

        [ForeignKey("ProductID")]
        public int ProductID { get; set; }
        public Product Product { get; set; }

        [Required]
        public int Quantity { get; set; }
    }
}
