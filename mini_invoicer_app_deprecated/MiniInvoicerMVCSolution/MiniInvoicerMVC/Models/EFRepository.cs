using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MiniInvoicerMVC.Models
{
    public class EFRepository : IRepository
    {
        private MiniInvoicerContext context;
        public EFRepository(MiniInvoicerContext ctx)
        {
            context = ctx;
        }

        public IQueryable<Invoice> Invoices => context.Invoices;
        public IQueryable<Customer> Customers => context.Customers;
        public IQueryable<Product> Products => context.Products;
    }
}
