using Microsoft.EntityFrameworkCore;

namespace MiniInvoicer.Server.DbContexts
{
    public class DataContext : DbContext
    {
        public DataContext(DbContextOptions<DataContext> options) : base(options)
        {
        }
    }
}