using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using MiniInvoicer.Data;
using MiniInvoicer.Models;

namespace MiniInvoicer.Pages.Areas
{
    public class DeleteModel : PageModel
    {
        private readonly MiniInvoicer.Data.ApplicationDbContext _context;

        public DeleteModel(MiniInvoicer.Data.ApplicationDbContext context)
        {
            _context = context;
        }

        [BindProperty]
        public Area Area { get; set; }

        public async Task<IActionResult> OnGetAsync(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            Area = await _context.Area.FirstOrDefaultAsync(m => m.AreaID == id);

            if (Area == null)
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

            Area = await _context.Area.FindAsync(id);

            if (Area != null)
            {
                _context.Area.Remove(Area);
                await _context.SaveChangesAsync();
            }

            return RedirectToPage("./Index");
        }
    }
}
