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
            var result = await _roleManager.CreateAsync(new IdentityRole(roleName: roleModel.Name));
            if (result.Succeeded)
            {
                return Accepted();
            }
            return BadRequest(result.Errors);
        }

        [HttpPut]
        public async Task<IActionResult> EditRole([FromBody] EditRoleModel roleModel)
        {
            var role = await _roleManager.FindByIdAsync(roleModel.Id);
            if (role == null)
            {
                return NotFound($"Role with id: {roleModel.Id} was not found.");
            }

            role.Name = roleModel.Name;
            var result = await _roleManager.UpdateAsync(role);
            if (result.Succeeded)
            {
                return Accepted();
            }

            return BadRequest(result.Errors);
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteRole([FromRoute] string id)
        {
            var role = await _roleManager.FindByIdAsync(id);
            if (role == null)
            {
                return NotFound($"Role with id: {id} was not found.");
            }

            var result = await _roleManager.DeleteAsync(role);
            if (result.Succeeded)
            {
                return Ok($"Role with id: {id} was deleted");
            }
            return BadRequest(result.Errors);
        }
    }
}