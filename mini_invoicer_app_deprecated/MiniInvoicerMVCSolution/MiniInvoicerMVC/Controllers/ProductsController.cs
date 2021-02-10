using Microsoft.AspNetCore.Mvc;
using MiniInvoicerMVC.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MiniInvoicerMVC.Controllers
{
    public class ProductsController : Controller
    {
        private IRepository repository;
        public ProductsController(IRepository repo)
        {
            repository = repo;
        }
        public IActionResult Index() => View(repository.Products);
    }
}
