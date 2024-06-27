using Egy_Voyage.DTOs;
using EgyVoyageApi.Data;
using EgyVoyageApi.DTOs;
using EgyVoyageApi.Entities;
using EgyVoyageApi.Repository.Abastract;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace EgyVoyageApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class RoomController : ControllerBase
    {
        private readonly AppDbContext _context;
        private readonly IFileService _fileService;



        public RoomController(AppDbContext context, IFileService fileService)
        {
            _context = context;
            _fileService = fileService;
        }
        //----------------Begin---------------viewroom--------------Begin------------------------------
        [HttpGet]
        public async Task<IActionResult> GetAllRoom()
        {
            var rooms = await _context.rooms.Include(x => x.Hotel).Select(x => new
            {
                Id = x.Id,
                hotel_id = x.Hotel.Id,
                x.capacity,
                x.breakfast,
                x.freeWifi,
                x.smoking,
                Name = x.RoomNumber,
                category = x.category,
                price = x.price,
                hotelname = x.Hotel.Name,
                image = $"http://egyvoyage2.somee.com/Resources/{x.image}"


            }).ToListAsync();
            return Ok(rooms);
        }
        //----------------End---------------viewroom--------------End-----------------------------

        //----------------Begin-------------CreateRoom------------Begin---------------------------
        [HttpPost]
        public async Task<IActionResult> creatRoom([FromForm] RoomDto room)
        {
            bool check = _context.hotels.Where(x => x.Id==room.HotelId).Any();

            if (check)
            {
                if (room.imagefile != null)
                {
                    var fileResult = _fileService.SaveImage(room.imagefile);

                    if (fileResult.Item1 == 1)
                    {
                        var newroom = new room
                        {

                            RoomNumber = room.Name,
                            category = room.category,
                            breakfast = room.breakfast,
                            freeWifi = room.freeWifi,
                            smoking = room.smoking,
                            capacity=room.capacity,
                            price = room.price,
                            HotelId = room.HotelId,
                            image = fileResult.Item2,
                        };
                        await _context.rooms.AddAsync(newroom);
                        await _context.SaveChangesAsync();
                        return Ok("Succesfull");

                    }




                    return BadRequest("no room added");
                }
                return NotFound("no file upload");
            }
            else
            {
                return BadRequest($"no hotel with id:{room.HotelId}");
            }

        }
        //----------------End-------------CreateRoom------------End---------------------------
        [HttpPut] 
        public async Task<IActionResult> EditRoom([FromForm] UpdateRoomDTO room)
        {
            var get = _context.rooms.Find(room.Id);
            
           
            if (get==null)
            {
                return NotFound($"There no hotel with Id:{room.Id}");
            }

            if (get.image.Length!=0)
            {
                _fileService.DeleteImage(get.image);
            }
            if (!ModelState.IsValid)
            {
                return BadRequest("error in uploading");
            }
            if (room.imagefile != null)
            {
                var fileResult = _fileService.SaveImage(room.imagefile);
                if (fileResult.Item1 == 1)
                {
                    //image.image = fileResult.Item2; // getting name of image
                    get.RoomNumber = room.Name;
                    get.HotelId = room.HotelId;
                    get.price = room.price;
                    get.image = fileResult.Item2;
                    get.capacity=room.capacity;
                    get.category=room.category;
                    get.image=fileResult.Item2;
                    get.breakfast=room.breakfast;
                    get.freeWifi=room.freeWifi;
                    get.smoking=room.smoking;
                    
                    await _context.SaveChangesAsync();

                }

                return Ok($"succeful on update {room.Name}");
            }
            return BadRequest("upload photo please");
            
        }
        //edit end

        //delelte start
        [HttpDelete]
        public async Task<IActionResult> DeleteRoom(int id)
        {
            var room = _context.rooms.Find(id);
           
            if (room!=null)
            {
               
                
                   
                    _context.rooms.Remove(room);
                    
                    _context.SaveChangesAsync();
                    _fileService.DeleteImage(room.image);
                
                
               
            }
            else
            {
                return NotFound($"there no hotel with Id:{id}");
            }


            return Ok($"succesful on delete {room.Id}");
        }


    }
}
