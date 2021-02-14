using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using MiniInvoicer.Client.Pages.Users;
using MiniInvoicer.Server.DbContexts;
using Microsoft.EntityFrameworkCore.Query;

namespace MiniInvoicer.Server.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class UsersController : ControllerBase
    {
        private readonly UserManager<IdentityUser> _userManager;
        private readonly RoleManager<IdentityRole> _roleManager;
        private readonly IdentityContext _identityContext;

        public UsersController(UserManager<IdentityUser> userManager, RoleManager<IdentityRole> roleManager, IdentityContext identityContext)
        {
            _userManager = userManager;
            _roleManager = roleManager;
            _identityContext = identityContext;
        }

        [HttpGet]
        public async Task<ActionResult<List<UserViewModel>>> GetUsers()
        {
            List<UserViewModel> userViewModels = new List<UserViewModel>();
            var userRoles = _identityContext.UserRoles.ToList();
            foreach (var user in _userManager.Users)
            {
                var userViewModel = new UserViewModel();
                userViewModel.IdentityUser = user;
                var userRole = userRoles.FirstOrDefault(ur => ur.UserId == user.Id);
                if (userRole != null)
                {
                    userViewModel.IdentityRole = _roleManager.Roles.FirstOrDefault(r => r.Id == userRole.RoleId);
                }
                userViewModels.Add(userViewModel);
            }
            return await Task.FromResult(userViewModels);
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<EditUserModel>> GetUser([FromRoute] string id)
        {
            var user = await _userManager.FindByIdAsync(id);
            if (user == null)
            {
                return NotFound(id);
            }

            return Ok(new EditUserModel {Id = id, Email = user.Email, Username = user.UserName});
        }

        [HttpPost]
        public async Task<IActionResult> CreateUser([FromBody] EditUserModel userModel)
        {
            if (ModelState.IsValid)
            {
                IdentityUser user = new IdentityUser {UserName = userModel.Username, Email = userModel.Email};
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

        [HttpPut]
        public async Task<IActionResult> EditUser([FromBody] EditUserModel userModel)
        {
            if (!ModelState.IsValid)
            {
                Console.WriteLine(ModelState.ErrorCount);
                return BadRequest();
            }

            IdentityUser user = await _userManager.FindByIdAsync(userModel.Id);
            if (user != null)
            {
                user.Email = userModel.Email;
                user.UserName = userModel.Username;
                IdentityResult result = await _userManager.UpdateAsync(user);
                if (result.Succeeded)
                {
                    await _userManager.RemovePasswordAsync(user);
                    result = await _userManager.AddPasswordAsync(user, userModel.Password);
                    if (result.Succeeded)
                    {
                        return Accepted();
                    }

                    var passwordChangeErrors = result.Errors.Select(x => x.Description);

                    return BadRequest(passwordChangeErrors);
                }
                var emailusernameErrors = result.Errors.Select(x => x.Description);

                return BadRequest(emailusernameErrors);
            }

            return NotFound(userModel.Id);
        }


        [HttpDelete("{id}")]
        public async Task<ActionResult> DeleteUser([FromRoute] string id)
        {
            var user = await _userManager.FindByIdAsync(id);
            if (user != null)
            {
                var result = await _userManager.DeleteAsync(user);
                if (result.Succeeded)
                {
                    return Ok($"User with id: {id} was deleted.");
                }
                return BadRequest(result.Errors);
            }

            return NotFound($"User with id: {id} was not found.");
        }
    }
}