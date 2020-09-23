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
    public class DeleteModel : PageModel
    {
        private readonly MiniInvoicer.Data.ApplicationDbContext _context;

        public DeleteModel(MiniInvoicer.Data.ApplicationDbContext context)
        {
            _context = context;
        }

        [BindProperty]
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

        public async Task<IActionResult> OnPostAsync(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            ProductPricing = await _context.ProductPricing.FindAsync(id);

            if (ProductPricing != null)
            {
                _context.ProductPricing.Remove(ProductPricing);
                await _context.SaveChangesAsync();
            }

            return RedirectToPage("./Index");
        }
    }
}
