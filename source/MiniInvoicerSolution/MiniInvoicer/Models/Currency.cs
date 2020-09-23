using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace MiniInvoicer.Models
{
    public class Currency
    {
        [Key]
        public int CurrencyID { get; set; }

        [Required]
        [MinLength(3)]
        public string Name { get; set; }

        [Required]
        [MinLength(3), StringLength(3)]
        public string Acronym { get; set; }
    }
}
