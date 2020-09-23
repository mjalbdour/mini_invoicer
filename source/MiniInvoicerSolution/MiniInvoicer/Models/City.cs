using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace MiniInvoicer.Models
{
    public class City
    {
        [Key]
        public int CityID { get; set; }

        [ForeignKey("CountryID")]
        public int CountryID { get; set; }

        [Required]
        [MinLength(2)]
        public string Name { get; set; }
    }
}
