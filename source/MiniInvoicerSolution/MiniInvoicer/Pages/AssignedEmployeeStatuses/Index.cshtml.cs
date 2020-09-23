﻿using System;
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
    public class IndexModel : PageModel
    {
        private readonly MiniInvoicer.Data.ApplicationDbContext _context;

        public IndexModel(MiniInvoicer.Data.ApplicationDbContext context)
        {
            _context = context;
        }

        public IList<AssignedEmployeeStatus> AssignedEmployeeStatus { get;set; }

        public async Task OnGetAsync()
        {
            AssignedEmployeeStatus = await _context.AssignedEmployeeStatus.ToListAsync();
        }
    }
}