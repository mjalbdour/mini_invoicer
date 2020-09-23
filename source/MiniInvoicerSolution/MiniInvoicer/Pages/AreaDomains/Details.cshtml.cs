using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using MiniInvoicer.Data;
using MiniInvoicer.Models;

namespace MiniInvoicer.Pages.AreaDomains
{
    public class DetailsModel : PageModel
    {
        private readonly MiniInvoicer.Data.ApplicationDbContext _context;

        public DetailsModel(MiniInvoicer.Data.ApplicationDbContext context)
        {
            _context = context;
        }

        public AreaDomain AreaDomain { get; set; }

        public async Task<IActionResult> OnGetAsync(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            AreaDomain = await _context.AreaDomain.FirstOrDefaultAsync(m => m.AreaDomainID == id);

            if (AreaDomain == null)
            {
                return NotFound();
            }
            return Page();
        }
    }
}
