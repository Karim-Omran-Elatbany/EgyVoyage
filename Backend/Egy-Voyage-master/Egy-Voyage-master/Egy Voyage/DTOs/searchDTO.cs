namespace EgyVoyageApi.DTOs
{
    public class searchDTO
    {
        public string distination {  get; set; }
        public DateTime start { get; set; } = default;
        public DateTime end { get; set; }= default;

    }
}
