using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace MiniInvoicer.Models
{
    public class Area
    {
        [Key]
        public int AreaID { get; set; }
        
        [ForeignKey("AreaDomainID")]
        public int AreaDomainID { get; set; }

        [ForeignKey("ZipcodeID")]
        public int ZipcodeID { get; set; }

        [Required]
        [MinLength(3)]
        public string Name { get; set; }

    }
}
