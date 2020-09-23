using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace MiniInvoicer.Models
{
    public class Country
    {
        [Key]
        public int CountryID { get; set; }

        [Required]
        [MinLength(3)]
        public string Name { get; set; }
    }
}
