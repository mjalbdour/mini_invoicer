using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace MiniInvoicer.Models
{
    public class AreaDomain
    {
        [Key]
        public int AreaDomainID { get; set; }

        [ForeignKey("CityID")]
        public int CityID { get; set; }
        public City City { get; set; }

        [Required]
        [MinLength(3)]
        public string Name { get; set; }
    }
}
