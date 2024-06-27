namespace EgyVoyageApi.DTOs
{
    public class UpdateHotelDto
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public decimal rating { get; set; }
        public string cordinate { get; set; }
        public string map { get; set; }
        public string day1 { get; set; }
        public string day2 { get; set; }
        public string day3 { get; set; }
   
        public string location { get; set; }
        public IFormFile imagefile { get; set; }

    }
}
