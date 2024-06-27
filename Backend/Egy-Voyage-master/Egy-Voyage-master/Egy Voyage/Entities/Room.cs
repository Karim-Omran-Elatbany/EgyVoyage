using Egy_Voyage.Entities;

namespace EgyVoyageApi.Entities
{
    public class room
    {
        public int Id { get; set; }
        public string RoomNumber { get; set; }
        public string category { get; set; }
        public int price { get; set; }
        public int capacity { get; set; } = 1;
        public bool freeWifi { get; set; }
        public bool smoking { get; set; }
        public bool breakfast { get; set; }
        public Hotel Hotel { get; set; }
        public int HotelId { get; set;}
        public string image { get; set; }
       public ICollection<Reservation> Reservations { get; set; }


    }
}
