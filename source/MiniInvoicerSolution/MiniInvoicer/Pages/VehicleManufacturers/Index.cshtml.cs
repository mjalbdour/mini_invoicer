using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using MiniInvoicer.Data;
using MiniInvoicer.Models;

namespace MiniInvoicer.Pages.VehicleManufacturers
{
    public class IndexModel : PageModel
    {
        private readonly MiniInvoicer.Data.ApplicationDbContext _context;

        public IndexModel(MiniInvoicer.Data.ApplicationDbContext context)
        {
            _context = context;
        }

        public IList<VehicleManufacturer> VehicleManufacturer { get;set; }

        public async Task OnGetAsync()
        {
            VehicleManufacturer = await _context.VehicleManufacturer.ToListAsync();
        }
    }
}
