using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace MiniInvoicer.Models
{
    public class Zipcode
    {
        [Key]
        public int ZipcodeID { get; set; }

        public string Code { get; set; }
    }
}
