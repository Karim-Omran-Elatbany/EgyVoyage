using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace EgyVoyageApi.DTOs
{
    public class LoginAdminDTO
    {
       
        public string Email { get; set; }
      
        public string Password { get; set; }
    }
}
