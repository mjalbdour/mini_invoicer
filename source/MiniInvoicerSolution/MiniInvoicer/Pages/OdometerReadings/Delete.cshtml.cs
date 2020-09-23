using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using MiniInvoicer.Data;
using MiniInvoicer.Models;

namespace MiniInvoicer.Pages.OdometerReadings
{
    public class DeleteModel : PageModel
    {
        private readonly MiniInvoicer.Data.ApplicationDbContext _context;

        public DeleteModel(MiniInvoicer.Data.ApplicationDbContext context)
        {
            _context = context;
        }

        [BindProperty]
        public OdometerReading OdometerReading { get; set; }

        public async Task<IActionResult> OnGetAsync(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            OdometerReading = await _context.OdometerReading.FirstOrDefaultAsync(m => m.OdometerReadingID == id);

            if (OdometerReading == null)
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

            OdometerReading = await _context.OdometerReading.FindAsync(id);

            if (OdometerReading != null)
            {
                _context.OdometerReading.Remove(OdometerReading);
                await _context.SaveChangesAsync();
            }

            return RedirectToPage("./Index");
        }
    }
}
