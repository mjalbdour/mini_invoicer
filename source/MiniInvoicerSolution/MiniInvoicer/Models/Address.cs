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
        public Street Street { get; set; }

        [ForeignKey("AreaID")]
        public int AreaID { get; set; }
        public Area Area { get; set; }

        [ForeignKey("NeighborhoodID")]
        public int NeighborhoodID { get; set; }
        public Neighborhood Neighborhood { get; set; }

        [ForeignKey("CityID")]
        public int CityID { get; set; }
        public City City { get; set; }

        [ForeignKey("CountryID")]
        public int CountryID { get; set; }
        public Country Country { get; set; }

        [ForeignKey("ZipcodeID")]
        public int ZipcodeID { get; set; }
        public Zipcode Zipcode { get; set; }

        public int HolderID { get; set; }
        public IAddressHolder AddressHolder { get; set; }


        [ForeignKey("GovernorateID")]
        public int GovernorateID { get; set; }
        public Governorate Governorate { get; set; }

        public int BuildingNumber { get; set; }
        public string BuildingName { get; set; }

        public string NearbyPlace { get; set; }

        public string Note { get; set; }

    }
}
