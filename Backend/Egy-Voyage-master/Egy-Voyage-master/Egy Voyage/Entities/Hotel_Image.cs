using System.ComponentModel.DataAnnotations.Schema;

namespace EgyVoyageApi.Entities
{
    public class Hotel_Image
    {
        public int Id { get; set; }
        public Hotel hotel { get; set; }
        public int Hotelid { get; set; }
        public string? image { get; set; }
        [NotMapped]
        public IFormFile imageFile { get; set; }
    }
    }
