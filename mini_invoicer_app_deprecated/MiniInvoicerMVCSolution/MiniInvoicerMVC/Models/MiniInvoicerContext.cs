using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MiniInvoicerMVC.Models
{
    public class MiniInvoicerContext : DbContext
    {
        public MiniInvoicerContext(DbContextOptions<MiniInvoicerContext> options) : base(options)
        {

        }

        public DbSet<Invoice> Invoices { get; set; }
        public DbSet<Customer> Customers{ get; set; }
        public DbSet<Product> Products { get; set; }
    }
}
