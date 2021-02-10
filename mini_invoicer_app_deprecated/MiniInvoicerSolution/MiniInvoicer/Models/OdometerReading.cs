using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace MiniInvoicer.Models
{
    public class OdometerReading
    {
        [Key]
        public int OdometerReadingID { get; set; }
        
        [ForeignKey("VehicleID")]
        public int VehicleID { get; set; }
        public Vehicle Vehicle { get; set; }

        public int ReadingInKm { get; set; }
    }
}
