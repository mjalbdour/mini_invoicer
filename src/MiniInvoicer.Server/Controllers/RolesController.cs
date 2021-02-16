using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using MiniInvoicer.Client.Pages.Roles;

namespace MiniInvoicer.Server.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class RolesController : ControllerBase
    {
        private readonly RoleManager<IdentityRole> _roleManager;

        public RolesController(RoleManager<IdentityRole> roleManager)
        {
            _roleManager = roleManager;
        }

        [HttpGet]
        public async Task<ActionResult<List<IdentityRole>>> GetRoles()
        {
            return await Task.FromResult(_roleManager.Roles.ToList());
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<IdentityRole>> GetRole([FromRoute] string id)
        {
            var role = await _roleManager.FindByIdAsync(id);
            if (role == null)
            {
                return NotFound($"Role with id: {id} was not found.");
            }

            return Ok(role);
        }

        [HttpPost]
        public async Task<IActionResult> CreateRole([FromBody] EditRoleModel roleModel)
        {
            var role = new IdentityRole(roleModel.Name);
            var result = await _roleManager.CreateAsync(role);
            if (!result.Succeeded)
            {
                return BadRequest(result.Errors);
            }

            return Ok();
        }

        // [HttpPut]
        // public async Task<IActionResult> EditRole([FromBody] EditRoleModel roleModel)
        // {
        //     if (!ModelState.IsValid)
        //     {
        //         return BadRequest();
        //     }
        //
        //     var role = await _roleManager.FindByIdAsync(roleModel.Id);
        //     var result = await _roleManager.SetRoleNameAsync(role, roleModel.Name);
        //     if (result == null)
        //     {
        //         return BadRequest(new List<IdentityError> {new IdentityError {Description = "Duplicate role name"}});
        //     }
        //
        //     return Ok();
        // }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteRole([FromRoute] string id)
        {
            var role = await _roleManager.FindByIdAsync(id);
            if (role == null)
            {
                return NotFound($"Role with id: {id} not found.");
            }

            var result = await _roleManager.DeleteAsync(role);
            if (!result.Succeeded)
            {
                return BadRequest(result.Errors);
            }

            return Ok();
        }
    }
}