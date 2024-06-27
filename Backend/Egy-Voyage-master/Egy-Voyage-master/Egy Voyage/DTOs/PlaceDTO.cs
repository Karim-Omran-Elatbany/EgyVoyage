namespace EgyVoyageApi.DTOs
{
    public class PlaceDTO
    {
        public string Name { get; set; }
        public string city { get; set; }
        public string Description { get; set; }
        public decimal rating { get; set; }
        public string url_location { get; set; }
        public string cordinate { get; set; }
        public int price { get; set; }
        public string start {  get; set; }
        public string end { get; set; }
        public IFormFile imagefile { get; set; }
    }
}
