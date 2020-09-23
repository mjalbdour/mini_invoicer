using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace MiniInvoicer.Models
{
    public class Address
    {
        [Key]
        public int AddressID { get; set; }

        [ForeignKey("StreetID")]
        public int StreetID { get; set; }

        [ForeignKey("AreaID")]
        public int AreaID { get; set; }

        [ForeignKey("NeighborhoodID")]
        public int NeighborhoodID { get; set; }

        [ForeignKey("CityID")]
        public int CityID { get; set; }

        [ForeignKey("CountryID")]
        public int CountryID { get; set; }

        [ForeignKey("ZipcodeID")]
        public int ZipcodeID { get; set; }

        [ForeignKey("HolderID")]
        public int HolderID { get; set; }

        [ForeignKey("GovernorateID")]
        public int GovernorateID { get; set; }

        public int BuildingNumber { get; set; }
        public string BuildingName { get; set; }

        public string NearbyPlace { get; set; }

        public string Note { get; set; }

    }
}
