using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using MiniInvoicer.Data;
using MiniInvoicer.Models;

namespace MiniInvoicer.Pages.AssignedEmployeeStatuses
{
    public class DeleteModel : PageModel
    {
        private readonly MiniInvoicer.Data.ApplicationDbContext _context;

        public DeleteModel(MiniInvoicer.Data.ApplicationDbContext context)
        {
            _context = context;
        }

        [BindProperty]
        public AssignedEmployeeStatus AssignedEmployeeStatus { get; set; }

        public async Task<IActionResult> OnGetAsync(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            AssignedEmployeeStatus = await _context.AssignedEmployeeStatus.FirstOrDefaultAsync(m => m.AssignedEmployeeStatusID == id);

            if (AssignedEmployeeStatus == null)
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

            AssignedEmployeeStatus = await _context.AssignedEmployeeStatus.FindAsync(id);

            if (AssignedEmployeeStatus != null)
            {
                _context.AssignedEmployeeStatus.Remove(AssignedEmployeeStatus);
                await _context.SaveChangesAsync();
            }

            return RedirectToPage("./Index");
        }
    }
}
