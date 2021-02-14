using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using MiniInvoicer.Client.Pages.Users;

namespace MiniInvoicer.Server.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class UsersController : ControllerBase
    {
        private readonly UserManager<IdentityUser> _userManager;

        public UsersController(UserManager<IdentityUser> userManager)
        {
            this._userManager = userManager;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<IdentityUser>>> GetUsers()
        {
            return await Task.FromResult(_userManager.Users.ToList());
        }

        [HttpPost]
        public async Task<IActionResult> CreateUser(CreateUserModel userModel)
        {
            if (ModelState.IsValid)
            {
                IdentityUser user = new IdentityUser { UserName = userModel.Username, Email = userModel.Email};
                IdentityResult result = await _userManager.CreateAsync(user, userModel.Password);
                if (result.Succeeded)
                {
                    return Accepted();
                }

                if (!result.Succeeded)
                {
                    var errors = result.Errors.Select(x => x.Description);

                    return BadRequest(errors);
                }
            }

            return BadRequest();
        }
    }
}