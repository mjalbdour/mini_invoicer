using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace MiniInvoicer.Models
{
    public class Zipcode
    {
        [Key]
        public int ZipcodeID { get; set; }

        [ForeignKey("CountryID")]
        public int CountryID { get; set; }
        public Country Country { get; set; }

        public string Code { get; set; }
    }
}
