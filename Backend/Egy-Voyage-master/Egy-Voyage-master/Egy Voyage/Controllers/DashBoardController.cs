using EgyVoyageApi.Data;
using EgyVoyageApi.Entities;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System;

namespace Egy_Voyage.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DashBoardController : ControllerBase
    {
        private readonly AppDbContext _context;

        public DashBoardController(AppDbContext context)
        {
            _context=context;
        }
        [HttpGet("chart")]
        public async Task<IActionResult> Get()
        {
            var monthNames = new[] { "JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC" };

            var reservations = await _context.receipts
                .Include(r => r.Hotel) // Ensure Hotel navigation property is included
                .GroupBy(r => new { Month = r.reservation_date.Month })
                .OrderBy(g => g.Key.Month)
                .Select(g => new
                {
                    MonthName = monthNames[g.Key.Month - 1],
                   
                    data = g.GroupBy(r => new {HotelId= r.HotelId,HotelName=r.Hotel.Name }).Select(x => new
                    {
                        HotelId=x.Key.HotelId,
                        HotelName=x.Key.HotelName,
                        count = x.Count()
                    })
                })
                .ToListAsync();



            return Ok(reservations);
        }
        [HttpGet("Piechart")]
        public async Task<IActionResult> pie()
        {
            float all = _context.receipts.Count();
            var counts = await _context.receipts
             .GroupBy(r => r.Hotel.Name)
             .Select(g => new
             {
                 HotelName = g.Key,
                 ReservationCount = (g.Count()/all)*100
             })
             .ToListAsync();

            return Ok(counts);
        }
        [HttpGet("feedback_analysis")]
        public async Task<IActionResult> analysis_feed()
        {
            var result = await _context.feedbacks.Include(x=>x.Hotel).GroupBy(x => new { x.HotelId,x.Hotel.Name,}).Select(x => new
            {
                HotelId = x.Key.HotelId,
                HotelName = x.Key.Name,
                
                

                Good= x.Count(x => x.rating>6.5m),
                Bad=x.Count(x=>x.rating<6.5m)
            }).ToListAsync();

            return Ok(result);
        }
        [HttpGet("show_feedback")]
        public async Task<IActionResult> show(bool type,int HotelId)
        {
            if (type)
            {
                var result = await _context.hotels.Include(x => x.feedbacks).Where(x => x.Id==HotelId)
                    .Select(x => new
                    {
                        HotelId = x.Id,
                        Name = x.Name,
                        image = x.images.Select(x => x.image),
                        x.rating,
                        data = x.feedbacks.Where(x=>x.rating>6m).Select(x => new
                        {
                            name = x.User.FName+" "+x.User.LName,
                            rating = x.rating,
                            description = x.description,
                        }).ToList(),
                    })
                    .ToListAsync();
                return Ok(result);
            }
            else
            {
                var result = await _context.hotels.Include(x => x.feedbacks).Where(x => x.Id==HotelId)
                    .Select(x => new
                    {
                        HotelId = x.Id,
                        Name = x.Name,
                        image = x.images.Select(x => x.image),
                        x.rating,
                        data = x.feedbacks.Where(x => x.rating<6m).Select(x => new
                        {
                            name = x.User.FName+" "+x.User.LName,
                            rating = x.rating,
                            description = x.description,
                        }).ToList(),
                    })
                    .ToListAsync();
                return Ok(result);
            }
           
        }
    }
}
