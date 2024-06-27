using Egy_Voyage.Entities;
using System;

namespace EgyVoyageApi.Entities
{
    public class Reservation
    {
        public int Id { get; set; }
       
        public User user { get; set; }
        public int UserId { get; set; }
        public room room { get; set; }
        public int roomId { get; set; }
        public DateTime Start { get; set; } = default;
        public DateTime? End { get; set; }= default;
        public receipt receipt { get; set; }
        public int receiptId { get; set;}
        
        
        
    }
}
