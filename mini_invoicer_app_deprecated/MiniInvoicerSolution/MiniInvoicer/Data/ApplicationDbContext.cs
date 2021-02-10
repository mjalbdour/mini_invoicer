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
        public DbSet<MiniInvoicer.Models.Currency> Currency { get; set; }
        public DbSet<MiniInvoicer.Models.Department> Department { get; set; }
        public DbSet<MiniInvoicer.Models.Governorate> Governorate { get; set; }
        public DbSet<MiniInvoicer.Models.Inventory> Inventory { get; set; }
        public DbSet<MiniInvoicer.Models.InvoiceProduct> InvoiceProduct { get; set; }
        public DbSet<MiniInvoicer.Models.Invoice> Invoice { get; set; }
        public DbSet<MiniInvoicer.Models.Neighborhood> Neighborhood { get; set; }
        public DbSet<MiniInvoicer.Models.Order> Order { get; set; }
        public DbSet<MiniInvoicer.Models.ProductBrand> ProductBrand { get; set; }
        public DbSet<MiniInvoicer.Models.ProductPricing> ProductPricing { get; set; }
        public DbSet<MiniInvoicer.Models.ProductPricingType> ProductPricingType { get; set; }
        public DbSet<MiniInvoicer.Models.Product> Product { get; set; }
        public DbSet<MiniInvoicer.Models.ProductTransfer> ProductTransfer { get; set; }
        public DbSet<MiniInvoicer.Models.Receipt> Receipt { get; set; }
        public DbSet<MiniInvoicer.Models.Street> Street { get; set; }
        public DbSet<MiniInvoicer.Models.Team> Team { get; set; }
        public DbSet<MiniInvoicer.Models.Transaction> Transaction { get; set; }
        public DbSet<MiniInvoicer.Models.TransferedProduct> TransferedProduct { get; set; }
        public DbSet<MiniInvoicer.Models.VehicleManufacturer> VehicleManufacturer { get; set; }
        public DbSet<MiniInvoicer.Models.Vehicle> Vehicle { get; set; }
        public DbSet<MiniInvoicer.Models.VehicleStatus> VehicleStatus { get; set; }
        public DbSet<MiniInvoicer.Models.Warehouse> Warehouse { get; set; }
        public DbSet<MiniInvoicer.Models.Zipcode> Zipcode { get; set; }
        public DbSet<MiniInvoicer.Models.OdometerReading> OdometerReading { get; set; }
    }
}
