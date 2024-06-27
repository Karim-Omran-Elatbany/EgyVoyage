using EgyVoyageApi.Data;
using EgyVoyageApi.DTOs;
using EgyVoyageApi.Entities;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Diagnostics;

namespace EgyVoyageApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class FeedBackController : ControllerBase
    {
        private readonly AppDbContext _context;

        public FeedBackController(AppDbContext context)
        {
            _context=context;
        }
        [HttpPost]
        public async Task<IActionResult> GiveFeedBack(feedbackDTO reveiw, int hotel_id)
        {

            var user = _context.users.Where(x => x.Email==reveiw.email).FirstOrDefault();
            bool check = _context.feedbacks.Where(x => x.user_id==user.Id&x.HotelId==hotel_id).Any();
            if (!check)
            {
                var feed = new feedback_Hotel
                {
                    user_id=user.Id,
                    HotelId = hotel_id,
                    description=reveiw.description,
                    rating=reveiw.rating
                };
                await _context.AddAsync(feed);
                await _context.SaveChangesAsync();
            }
            else
            {
                var feedback = _context.feedbacks.Where(x => x.user_id==user.Id&x.HotelId==hotel_id).FirstOrDefault();
                feedback.description= reveiw.description;
                feedback.rating=reveiw.rating;
                await _context.SaveChangesAsync();


            }
            int count = await _context.feedbacks.Where(x => x.HotelId==hotel_id).CountAsync();
            if (count >100)
            {
                var records = await _context.feedbacks.Where(x => x.HotelId == hotel_id).ToListAsync();
                _context.RemoveRange(records);
                await _context.SaveChangesAsync();
            }
            else if (count > 25)
            {
                var rating = await _context.feedbacks.Where(x => x.HotelId==hotel_id).Select(x => x.rating).AverageAsync();
                var hotel = await _context.hotels.FindAsync(hotel_id);
                hotel.rating = rating;
                await _context.SaveChangesAsync();

            }


            return Ok("thanks");
        }
        //feedback for spacific hotel
        [HttpGet]
        public async Task<IActionResult> GetFeedBack(int hotel_id)
        {
            var feedbacks = await _context.feedbacks.Include(x => x.User).Where(x => x.HotelId==hotel_id)
                .Select(x => new
                {
                    x.User.Image.image,
                    Name = x.User.FName+" "+x.User.LName,
                    x.rating,
                    x.description,

                }).ToListAsync();
            return Ok(feedbacks);
        }
        


    }
}
