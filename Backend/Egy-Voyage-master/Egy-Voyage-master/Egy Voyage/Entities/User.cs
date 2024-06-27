using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using Microsoft.VisualBasic;
using System;
using System.ComponentModel.DataAnnotations.Schema;

namespace EgyVoyageApi.Entities
{
    public class User
    {
        public int Id { get; set; }
        public string FName { get; set; }
        public string LName { get; set; }
        public string Gender { get; set; }
        public string PhoneNumber { get; set; }
        public string Nationality { get; set; }
        public string SSN { get; set; }
        public DateTime birthdate { get; set; } = default;
        public string Email { get; set; }
        public string Password { get; set; }
        public UserImage Image { get; set; }

        public ICollection<Reservation> Reservations { get; set; }
        public ICollection<feedback_Hotel> feedbacks { get; set; }
        

   

    }
}
