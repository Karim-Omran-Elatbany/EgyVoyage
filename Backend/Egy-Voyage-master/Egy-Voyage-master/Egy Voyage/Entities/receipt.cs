using EgyVoyageApi.Entities;

namespace Egy_Voyage.Entities
{
    public class receipt
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string email { get; set; }
        public int total_price { get; set; }
        public long processNumber { get; set; }
        public DateTime reservation_date { get; set; }
        public string pin_code { get; set; }

        public ICollection<Reservation> Reservations { get; set; }
        public DateTime Start { get; set; } = default;
        public DateTime? End { get; set; } = default;
        public Hotel Hotel { get; set; }
        public int HotelId { get; set; }


    }
}
