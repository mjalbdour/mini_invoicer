using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace MiniInvoicer.Models
{
    public class Neighborhood
    {
        [Key]
        public int NeighborhoodID { get; set; }

        [ForeignKey("AreaID")]
        public int AreaID { get; set; }
        public Area Area { get; set; }

        [Required]
        public string Name { get; set; }
    }
}
