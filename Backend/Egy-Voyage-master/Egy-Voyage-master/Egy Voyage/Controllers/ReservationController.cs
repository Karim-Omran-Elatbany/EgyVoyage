using System.Net.Mail;
using System.Net;
using EgyVoyageApi.Data;
using EgyVoyageApi.DTOs;
using EgyVoyageApi.Entities;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Egy_Voyage.DTOs;
using Egy_Voyage.Entities;

namespace EgyVoyageApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ReservationController : ControllerBase
    {
        private readonly AppDbContext _Context;

        public ReservationController(AppDbContext context)
        {
            _Context=context;
        }



        //--------------Begin--------------GetAllResvation--------------Begin--------------------------------
        [HttpGet]
        public async Task<IActionResult> GetAllResvation()
        {
            var resvations = await _Context.reservations.Include(x => x.user).Include(x => x.room)
                .Select(x => new
                {
                    user = x.user.FName+" "+x.user.LName,
                    x.roomId,
                    x.receiptId,
                    roomnumber = x.room.RoomNumber,
                    start = x.Start,
                    end = x.End,
                }).ToListAsync();
            return StatusCode(statusCode: 200, resvations);
        }
        //--------------End--------------GetAllResvation--------------End--------------------------------


        //--------------Begin--------------Reserve--------------Begin--------------------------------
        [HttpPost]
        public async Task<IActionResult> Reserve(string Email, int roomid, reservationDTO Reserve)
        {
            var check = await _Context.users.Where(x => x.Email==Email).AnyAsync();
            if (check)
            {
                int user_id = await _Context.users
                                   .Where(x => x.Email == Email)
                                   .Select(x => x.Id)
                                   .FirstOrDefaultAsync();
                var newreserve = new Reservation
                {
                    UserId= user_id,
                    roomId=roomid,
                    Start=Reserve.Start,
                    End=Reserve.End,
                };
                await _Context.reservations.AddAsync(newreserve);
                await _Context.SaveChangesAsync();
                return StatusCode(statusCode: 200, newreserve);
            }
            else
            {
                return StatusCode(StatusCodes.Status400BadRequest, "No User Found");

            }

            //--------------End--------------Reserve--------------End--------------------------------

            //search------------------------------------------------------------------------------------------------------------------------       

        }
        [HttpPost("search")]
        public async Task<IActionResult> search(searchDTO search)
        {

            var hotel = await _Context.hotels
                              .Include(x => x.rooms)
                              .Where(x => x.location == search.distination ||
                                                                              (x.location == search.distination &&
                                                                              (x.rooms == null || x.rooms.All(room => room.Reservations.Any(reservation => reservation.Start > search.end || reservation.End < search.start)))))
                              .Select(x => new
                              {
                                  id = x.Id,
                                  name = x.Name,
                                  rating = x.rating,
                                  cordinate = x.cordinate,
                                  location = x.location,
                                  Description = x.Description,
                                  minprice = x.rooms != null ? (int?)x.rooms.Select(room => room.price).Min() : null, // Use nullable int to allow null value
                                  image = $"http://egyvoyage2.somee.com/Resources/{x.images.Select(img => img.image).FirstOrDefault()}",
                                  rooms = x.rooms != null ? x.rooms.Where(room => room.Reservations.All(reservation => reservation.Start > search.end || reservation.End < search.start))
                                                                             .Select(room => new
                                                                             {
                                                                                 room.Id,
                                                                                 room.RoomNumber,
                                                                                 room.capacity,
                                                                                 room.breakfast,
                                                                                 room.freeWifi,
                                                                                 room.smoking,
                                                                                 room.price,
                                                                                 room.category,
                                                                                 image = $"http://egyvoyage2.somee.com/Resources/{room.image}"
                                                                             }) : null // If rooms is null, assign null to rooms
                              })
                                                                               .ToListAsync();

            return Ok(hotel);

        }

        //get user's data for the reservation form-------------------------------------------------------------------------------------------------
        [HttpGet("getuser")]
        public async Task<IActionResult> GetUser(string email)
        {
            var user = await _Context.users.Where(x => x.Email == email).ToListAsync();
            return Ok(user);
        }
        //reserv-----------------------------------------------------------------------------------------------------------------------------------
        [HttpPost("reserv")]
        public async Task<IActionResult> reserv(ReserveDto reserv)
        {
            int userId = _Context.users.Where(x => x.Email == reserv.email).Select(x => x.Id).FirstOrDefault();
            int hotel_id = await _Context.rooms.Include(x=>x.Hotel).Where(x=>x.Id == reserv.roomId[0]).Select(x=>x.Hotel.Id).FirstOrDefaultAsync();
            int days = reserv.End!=default ? (reserv.End - reserv.Start).Days : 0;
            Console.WriteLine("------------------------------------------------------------------------");
            Console.WriteLine(hotel_id);
            Console.WriteLine("------------------------------------------------------------------------");
           
           
            //calculate rondom value------------
            var random = new Random();
            string pincode = random.Next(100000, 999999).ToString();
            long num_process = (long)random.Next(1000000000, int.MaxValue) * 10 + random.Next(10);
            var receipt = new receipt
            {
                email=reserv.email,
                Name=reserv.name,
                HotelId=hotel_id,
                reservation_date=DateTime.Now,
                Start=reserv.Start,
                End=reserv.End,
                processNumber=num_process,
                pin_code=pincode
             };
            //end calculate rondom value--------
            foreach (var element in reserv.roomId)
            {
                var price = _Context.rooms.Where(x => x.Id==element).Select(x => x.price).FirstOrDefault();
                receipt.total_price += price*(days);


            }
            await _Context.AddAsync(receipt);
            await _Context.SaveChangesAsync();


            //add reservation---------
            foreach (var element in reserv.roomId)
            {
                var receipt_id = _Context.receipts.Where(x => x.processNumber==num_process).Select(x => x.Id).FirstOrDefault();
                Reservation newreserv = new Reservation
                {
                    UserId = userId,
                    roomId = element,
                    receiptId=receipt_id,
                    Start = reserv.Start,
                    End = reserv.End,

                };
                await _Context.AddAsync(newreserv);
            }
            await _Context.SaveChangesAsync();
            //end add reservation in database-----

            Console.WriteLine(num_process);
            string pass = "nzrpygitegotrnng";
            var client = new SmtpClient("smtp.gmail.com")
            {
                Port = 587,
                Credentials = new NetworkCredential("egyvoyage@gmail.com", pass),
                EnableSsl = true
            };


            var message = new MailMessage("egyvoyage@gmail.com", reserv.email, "Welcome, Your reservation has been completed", $" To accomplish your reservation keep reservation's pincode:{pincode}");
            try
            {
                await client.SendMailAsync(message);
                return StatusCode(statusCode: 200, new {num_process,pincode});
               
            }
            catch (Exception ex)
            {
                return BadRequest($"Smtp send failed with the exception: {ex.Message}.");
            }

        }
        
        ///end reservation--------------------------------------
        //start reserv------------------------------------------
        [HttpDelete]
        public async Task<IActionResult> cancelreservation(int id,string mail)
        {
            var receipt = _Context.receipts.Where(x => x.Id==id).FirstOrDefault();
            var hotel = await _Context.reservations.Include(x=>x.room).ThenInclude(x=>x.Hotel).Where(x => x.receiptId==id).Select(x=>x.room.Hotel.Name).FirstOrDefaultAsync() ;

            _Context.Remove(receipt);
            await _Context.SaveChangesAsync();
            
           
            string pass = "nzrpygitegotrnng";
            var client = new SmtpClient("smtp.gmail.com")
            {
                Port = 587,
                Credentials = new NetworkCredential("egyvoyage@gmail.com", pass),
                EnableSsl = true
            };


            var message = new MailMessage("egyvoyage@gmail.com", mail, "Welcome, Your reservation has been canceled", $"Your reservation in {hotel} has been canceled");
            try
            {
                await client.SendMailAsync(message);

                
            }
            catch (Exception ex)
            {
                return BadRequest($"Smtp send failed with the exception: {ex.Message}.");
            }
            finally
            {
                client.Dispose();
                // Ensure that the MailMessage is properly disposed
                message.Dispose();
            }
            return Ok("reservation has been canceled");
        }





    }
}
        
    

