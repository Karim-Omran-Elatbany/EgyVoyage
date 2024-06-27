namespace EgyVoyageApi.DTOs
{
    public class ReserveDto
    {
        
        public string email { get; set; }
        public string name { get; set; }
        public int[] roomId { get; set; }
        public DateTime Start { get; set; } = default;
        public DateTime End { get; set; } = default;
    }
}
