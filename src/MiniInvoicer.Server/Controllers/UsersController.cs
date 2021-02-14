using System.Collections.Generic;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;

namespace MiniInvoicer.Server.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class UsersController : ControllerBase
    {
        private readonly UserManager<IdentityUser> _userManager;

        public UsersController(UserManager<IdentityUser> _userManager)
        {
            this._userManager = _userManager;
        }

        [HttpGet]
        public async Task<IEnumerable<IdentityUser>> GetUsers()
        {
            return await Task.FromResult(_userManager.Users);
        }
    }
}