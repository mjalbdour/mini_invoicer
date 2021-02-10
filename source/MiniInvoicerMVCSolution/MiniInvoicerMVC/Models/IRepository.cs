using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MiniInvoicerMVC.Models
{
    public interface IRepository
    {
        IQueryable<Invoice> Invoices { get; }
        IQueryable<Customer> Customers{ get; }
        IQueryable<Product> Products { get; }
    }
}
