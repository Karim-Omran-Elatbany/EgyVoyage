namespace Egy_Voyage.DTOs
{
    public class UpdatePlaceDTO
    {
        public int id { get; set; }
        public string Name { get; set; }
        public string city { get; set; }
        public string Description { get; set; }
        public decimal rating { get; set; }
        public string url_location { get; set; }
        public string cordinate { get; set; }
        public IFormFile imagefile { get; set; }
    }
}
