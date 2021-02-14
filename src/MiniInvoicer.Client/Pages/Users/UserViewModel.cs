using Microsoft.AspNetCore.Identity;

namespace MiniInvoicer.Client.Pages.Users
{
    public class UserViewModel
    {
        public IdentityUser IdentityUser { get; set; }
        public IdentityRole IdentityRole { get; set; }
    }
}