using Microsoft.EntityFrameworkCore;
using MiniInvoicer.Server.Models;

namespace MiniInvoicer.Server.DbContexts
{
    public class DataContext : DbContext
    {
        public DataContext(DbContextOptions<DataContext> options) : base(options)
        {
        }

        public DbSet<Product> Products { get; set; }
    }
}