using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection.Metadata.Ecma335;
using System.Threading.Tasks;

namespace MiniInvoicerMVC.Controllers
{
    public class InvoicesController : Controller
    {
        public IActionResult Index() => View();
    }
}
