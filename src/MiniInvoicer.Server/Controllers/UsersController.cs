using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using MiniInvoicer.Client.Pages.Users;
using MiniInvoicer.Server.DbContexts;

namespace MiniInvoicer.Server.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class UsersController : ControllerBase
    {
        private readonly UserManager<IdentityUser> _userManager;
        private readonly RoleManager<IdentityRole> _roleManager;
        private readonly IdentityContext _identityContext;

        public UsersController(UserManager<IdentityUser> userManager, RoleManager<IdentityRole> roleManager,
            IdentityContext identityContext)
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

            var editUserModel = new EditUserModel();
            var userRole = _identityContext.UserRoles.FirstOrDefault(ur => ur.UserId == user.Id);
            if (userRole != null)
            {
                editUserModel.RoleId = _roleManager.Roles.FirstOrDefault(r => r.Id == userRole.RoleId).Id;
            }

            editUserModel.Id = id;
            editUserModel.Username = user.UserName;
            editUserModel.Email = user.Email;
            return Ok(editUserModel);
        }

        [HttpPost]
        public async Task<IActionResult> CreateUser([FromBody] EditUserModel editUserModel)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest();
            }

            IdentityUser user = new IdentityUser {UserName = editUserModel.Username, Email = editUserModel.Email};
            IdentityResult result = await _userManager.CreateAsync(user, editUserModel.Password);
            if (!result.Succeeded)
            {
                return BadRequest(result.Errors);
            }

            var role = await _roleManager.FindByIdAsync(editUserModel.RoleId);
            if (role != null)
            {
                result = await _userManager.AddToRoleAsync(user, role.Name);
                if (!result.Succeeded)
                {
                    return BadRequest(result.Errors);
                }
            }

            return Accepted();
        }


        [HttpPut]
        public async Task<IActionResult> EditUser([FromBody] EditUserModel editUserModel)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest("Check Model");
            }

            IdentityUser user = await _userManager.FindByIdAsync(editUserModel.Id);
            if (user == null)
            {
                return NotFound($"User with id: {editUserModel.Id} was not found.");
            }

            var roleResult = await _roleManager.FindByIdAsync(editUserModel.RoleId);
            if (roleResult == null)
            {
                return BadRequest($"Role with id: {editUserModel.Id} doesn't exist");
            }

            user.Email = editUserModel.Email;
            user.UserName = editUserModel.Username;

            IdentityResult result = await _userManager.UpdateAsync(user);
            if (!result.Succeeded)
            {
                return BadRequest(result.Errors);
            }

            var checkIsInRoleResult = await _userManager.IsInRoleAsync(user, roleResult.Name);
            if (!checkIsInRoleResult)
            {
                await _userManager.RemoveFromRolesAsync(user, _roleManager.Roles.Select(r => r.Name));
                await _userManager.AddToRoleAsync(user, roleResult.Name);
            }

            await _userManager.RemovePasswordAsync(user);
            result = await _userManager.AddPasswordAsync(user, editUserModel.Password);
            if (!result.Succeeded)
            {
                return BadRequest(result.Errors);
            }

            return Accepted($"User updated");
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