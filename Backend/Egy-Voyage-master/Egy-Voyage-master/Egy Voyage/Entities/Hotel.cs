using Egy_Voyage.Entities;
using System.Collections.Generic;

namespace EgyVoyageApi.Entities
{
    public class Hotel
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public string location {  get; set; }
        public string cordinate {  get; set; }
        public decimal rating { get; set; }
        public string map { get; set; }
        public ICollection<feedback_Hotel> feedbacks { get; set; }
        public ICollection<Hotel_Image> images { get; set; }
        public  string day1 { get; set; }
        public string day2 { get; set; }
        public string day3 { get; set; }
        

        public ICollection<room> rooms { get; set; }
        public ICollection<receipt> receipts { get; set; }
    }
}
