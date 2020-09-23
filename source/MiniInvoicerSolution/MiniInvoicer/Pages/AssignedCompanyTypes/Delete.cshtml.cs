using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using MiniInvoicer.Data;
using MiniInvoicer.Models;

namespace MiniInvoicer.Pages.AssignedCompanyTypes
{
    public class DeleteModel : PageModel
    {
        private readonly MiniInvoicer.Data.ApplicationDbContext _context;

        public DeleteModel(MiniInvoicer.Data.ApplicationDbContext context)
        {
            _context = context;
        }

        [BindProperty]
        public AssignedCompanyType AssignedCompanyType { get; set; }

        public async Task<IActionResult> OnGetAsync(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            AssignedCompanyType = await _context.AssignedCompanyType.FirstOrDefaultAsync(m => m.AssignedCompanyTypeID == id);

            if (AssignedCompanyType == null)
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

            AssignedCompanyType = await _context.AssignedCompanyType.FindAsync(id);

            if (AssignedCompanyType != null)
            {
                _context.AssignedCompanyType.Remove(AssignedCompanyType);
                await _context.SaveChangesAsync();
            }

            return RedirectToPage("./Index");
        }
    }
}
