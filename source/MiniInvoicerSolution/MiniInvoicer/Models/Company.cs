using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace MiniInvoicer.Models
{
    public class Company
    {
        public int CompanyID { get; set; }
        public int AccountID { get; set; }
        public int AddressID { get; set; }
        public int MyProperty { get; set; }
        public int TypeID { get; set; }
        public int StatusID { get; set; }

        public string Name { get; set; }
        public string Description { get; set; }
        public string Slogan { get; set; }
        public DateTime EstablishDate { get; set; }
        public string TaxNumber { get; set; }
    }
}
