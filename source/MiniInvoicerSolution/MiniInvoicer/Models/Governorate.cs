using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace MiniInvoicer.Models
{
    public class Governorate
    {
        [Key]
        public int GovernorateID { get; set; }

        public string Name { get; set; }
    }
}
