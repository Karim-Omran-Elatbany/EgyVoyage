namespace EgyVoyageApi.Entities
{
    public class feedback_Hotel
    {
         public int Id { get; set; }
        public string description { get; set; }
        public decimal rating { get; set; }
        public Hotel Hotel { get; set; }
        public int HotelId { get; set; }
        
        public User User { get; set; }
        public int user_id {  get; set; }
    }
}
