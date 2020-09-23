using System;
using System.Collections.Generic;
using System.Text;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using MiniInvoicer.Models;

namespace MiniInvoicer.Data
{
    public class ApplicationDbContext : IdentityDbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
            : base(options)
        {

        }
        public DbSet<MiniInvoicer.Models.AccountHolderType> AccountHolderType { get; set; }
        public DbSet<MiniInvoicer.Models.Account> Account { get; set; }
        public DbSet<MiniInvoicer.Models.Address> Address { get; set; }
        public DbSet<MiniInvoicer.Models.AreaDomain> AreaDomain { get; set; }
        public DbSet<MiniInvoicer.Models.Area> Area { get; set; }
        public DbSet<MiniInvoicer.Models.AssignedCompanyStatus> AssignedCompanyStatus { get; set; }
        public DbSet<MiniInvoicer.Models.AssignedCompanyType> AssignedCompanyType { get; set; }
        public DbSet<MiniInvoicer.Models.AssignedEmployeeStatus> AssignedEmployeeStatus { get; set; }
        public DbSet<MiniInvoicer.Models.AssignedEmployeeType> AssignedEmployeeType { get; set; }
        public DbSet<MiniInvoicer.Models.AssignedVehicleStatus> AssignedVehicleStatus { get; set; }
        public DbSet<MiniInvoicer.Models.City> City { get; set; }
        public DbSet<MiniInvoicer.Models.Company> Company { get; set; }
        public DbSet<MiniInvoicer.Models.CompanyStatus> CompanyStatus { get; set; }
        public DbSet<MiniInvoicer.Models.CompanyType> CompanyType { get; set; }
        public DbSet<MiniInvoicer.Models.Country> Country { get; set; }
    }
}
