using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace MiniInvoicer.Models
{
    public class AssignedVehicleStatus
    {
        [Key]
        public int AssignedVehicleStatusID { get; set; }

        [ForeignKey("VehicleID")]
        public int VehicleID { get; set; }
        [ForeignKey("VehicleStatusID")]
        public int VehicleStatusID { get; set; }
    }
}
