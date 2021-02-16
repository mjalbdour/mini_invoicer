using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace MiniInvoicer.Client.Pages.Users
{
    public class EditUserModel
    {
        public string Id { get; set; }

        [Required]
        [StringLength(16, MinimumLength = 3)]
        public string Username { get; set; }

        [Required] [EmailAddress] public string Email { get; set; }

        public string RoleId { get; set; }

        [Required]
        [PasswordPropertyText]
        [StringLength(32, MinimumLength = 8)]
        public string Password { get; set; }
    }
}