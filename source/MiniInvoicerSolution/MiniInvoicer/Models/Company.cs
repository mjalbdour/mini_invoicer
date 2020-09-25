using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace MiniInvoicer.Models
{
    public class Company
    {
        [Key]
        public int CompanyID { get; set; }

        [ForeignKey("AccountID")]
        public int AccountID { get; set; }
        public Account Account { get; set; }

        [ForeignKey("AddressID")]
        public int AddressID { get; set; }
        public Address Address { get; set; }

        [ForeignKey("AssignedCompanyTypeID")]
        public int AssignedCompanyTypeID { get; set; }
        public AssignedCompanyType AssignedCompanyType { get; set; }

        [ForeignKey("AssignedCompanyStatusID")]
        public int AssignedCompanyStatusID { get; set; }
        public AssignedCompanyStatus AssignedCompanyStatus { get; set; }

        [Required]
        [MinLength(2)]
        public string Name { get; set; }
        public string Description { get; set; }
        public string Slogan { get; set; }

        [Required]
        [DataType(DataType.Date)]
        public DateTime EstablishDate { get; set; }

        [Required]
        [DataType(DataType.Text),StringLength(9)]
        public string TaxNumber { get; set; }
    }
}
