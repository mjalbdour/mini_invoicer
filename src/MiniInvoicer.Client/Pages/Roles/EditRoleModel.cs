using System.ComponentModel.DataAnnotations;

namespace MiniInvoicer.Client.Pages.Roles
{
    public class EditRoleModel
    {
        public string Id { get; set; }
        [Required]
        [StringLength(16, MinimumLength = 3)]
        public string Name { get; set; }
    }
}