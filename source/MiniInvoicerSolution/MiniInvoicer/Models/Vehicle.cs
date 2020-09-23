﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace MiniInvoicer.Models
{
    public class Vehicle
    {
        [Key]
        public int VehicleID { get; set; }

        [ForeignKey("VehicleManufacturerID")]
        public int ManufacturerID { get; set; }

        [ForeignKey("AssignedVehcileStatusID")]
        public int AssignedVehicleStatusID { get; set; }

        [Required]
        [MinLength(2)]
        public string Model { get; set; }

        [Required]
        [Range(1900, 2999)]
        public string Year { get; set; }

        [Required]
        [Range(1, 99)]
        public decimal FuelConsumptionRate { get; set; }
    }
}