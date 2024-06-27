using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations.Schema;

namespace EgyVoyageApi.Entities
{
   
    public class UserImage
    {
        public int Id { get; set; }
        public User User { get; set; }
        public int UserId { get; set; }
        public string? image { get; set; }
        [NotMapped]
        public IFormFile imageFile { get; set; }
        [NotMapped]
        public string email { get; set; }
    }
}
