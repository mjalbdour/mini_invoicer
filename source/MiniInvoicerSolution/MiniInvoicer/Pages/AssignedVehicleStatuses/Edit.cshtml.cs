using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using MiniInvoicer.Data;
using MiniInvoicer.Models;

namespace MiniInvoicer.Pages.AssignedVehicleStatuses
{
    public class EditModel : PageModel
    {
        private readonly MiniInvoicer.Data.ApplicationDbContext _context;

        public EditModel(MiniInvoicer.Data.ApplicationDbContext context)
        {
            _context = context;
        }

        [BindProperty]
        public AssignedVehicleStatus AssignedVehicleStatus { get; set; }

        public async Task<IActionResult> OnGetAsync(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            AssignedVehicleStatus = await _context.AssignedVehicleStatus.FirstOrDefaultAsync(m => m.AssignedVehicleStatusID == id);

            if (AssignedVehicleStatus == null)
            {
                return NotFound();
            }
            return Page();
        }

        // To protect from overposting attacks, enable the specific properties you want to bind to, for
        // more details, see https://aka.ms/RazorPagesCRUD.
        public async Task<IActionResult> OnPostAsync()
        {
            if (!ModelState.IsValid)
            {
                return Page();
            }

            _context.Attach(AssignedVehicleStatus).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!AssignedVehicleStatusExists(AssignedVehicleStatus.AssignedVehicleStatusID))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return RedirectToPage("./Index");
        }

        private bool AssignedVehicleStatusExists(int id)
        {
            return _context.AssignedVehicleStatus.Any(e => e.AssignedVehicleStatusID == id);
        }
    }
}
