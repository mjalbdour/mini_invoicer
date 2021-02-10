using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace MiniInvoicer.Models
{
    public class Street
    {
        [Key]
        public int StreetID { get; set; }
        
        [Required]
        public string Name { get; set; }
    }
}
