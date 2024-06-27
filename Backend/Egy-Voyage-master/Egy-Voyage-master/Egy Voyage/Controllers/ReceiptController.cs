using EgyVoyageApi.Data;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Egy_Voyage.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ReceiptController : ControllerBase
    {
        private readonly AppDbContext _context;

        public ReceiptController(AppDbContext context)
        {
            _context=context;
        }
        [HttpGet]
        public async Task<IActionResult> GetAllReceipt()
        {
            var receipt=await _context.receipts.ToArrayAsync();
            return Ok(receipt);
        }
        //start---------------------------
        [HttpPost]
        public async Task<IActionResult> GetReceipt(string email)
        {
            var receipt = await _context.receipts.Include(x=>x.Hotel).Where(x=>x.email==email)
                .Select(x=>new
                {

                   x.Id,
                   image =$"http://egyvoyage2.somee.com/Resources/{x.Hotel.images.Select(x => x.image).FirstOrDefault()}" ,
                   x.HotelId,
                   hotel_name = x.Hotel.Name,
                   name = x.Name,
                   x.total_price,
                   x.Start,
                   x.End,
                   x.processNumber,
                   x.pin_code
                }).ToListAsync();
            return Ok(receipt);
        }
        //end-------------------------------
       

    }
}
