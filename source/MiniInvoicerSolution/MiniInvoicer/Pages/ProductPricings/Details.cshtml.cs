using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using MiniInvoicer.Data;
using MiniInvoicer.Models;

namespace MiniInvoicer.Pages.ProductPricings
{
    public class DetailsModel : PageModel
    {
        private readonly MiniInvoicer.Data.ApplicationDbContext _context;

        public DetailsModel(MiniInvoicer.Data.ApplicationDbContext context)
        {
            _context = context;
        }

        public ProductPricing ProductPricing { get; set; }

        public async Task<IActionResult> OnGetAsync(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            ProductPricing = await _context.ProductPricing.FirstOrDefaultAsync(m => m.ProductPricingID == id);

            if (ProductPricing == null)
            {
                return NotFound();
            }
            return Page();
        }
    }
}
