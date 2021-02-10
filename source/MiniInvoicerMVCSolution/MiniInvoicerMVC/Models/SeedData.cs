using Microsoft.AspNetCore.Builder;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MiniInvoicerMVC.Models
{
    public class SeedData
    {
        public static void EnsurePopulated(IApplicationBuilder app)
        {
            MiniInvoicerContext context = app.ApplicationServices
            .CreateScope().ServiceProvider.GetRequiredService<MiniInvoicerContext>();
            if (context.Database.GetPendingMigrations().Any())
            {
                context.Database.Migrate();
            }
            if (!context.Products.Any())
            {
                context.Products.AddRange(
                new Product
                {
                    Name = "red velvet",
                    Price = 10.99M,

                },
                new Product
                {
                    Name = "hazelnut",
                    Price = 10.99M,

                }
            );
                context.SaveChanges();
            }
        }
    }
}