using EgyVoyageApi.Data;
using EgyVoyageApi.DTOs;
using EgyVoyageApi.Entities;
using EgyVoyageApi.Repository.Abastract;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System;
using System.Text.Json.Serialization;
using System.Text.Json;
using System.ComponentModel;
using static System.Net.Mime.MediaTypeNames;

namespace EgyVoyageApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class HotelController : ControllerBase
    {
        private readonly AppDbContext _context;
        private readonly IFileService _fileService;
        private readonly IProductRepository _productRepository;
        

        public HotelController(AppDbContext context,IFileService fileService,IProductRepository productRepository)
        {
            _context=context;
            _fileService=fileService;
            _productRepository=productRepository;
        }
        
        //---------------Begin----------View----------Begin--------------
        [HttpGet] 
        public async Task<IActionResult> GetAllHotel()
        {
            var Hotels = await _context.hotels.Include(x=>x.rooms).Include(x=>x.images).Select(x=> new
            {
                id=x.Id,
                name = x.Name,
                Description=x.Description,
                rating=x.rating,
                location =x.location,
                price=x.rooms.Select(x=>x.price).Average().ToString(),
                cordinate = x.cordinate,
                day1 = x.day1,
                x.map,
                day2 = x.day2,
                day3 = x.day3,
                image = $"http://egyvoyage2.somee.com/Resources/{x.images.Select(x => x.image).FirstOrDefault()}"
                        // $"https://localhost:7244/Resources/{x.images.Select(x => x.image).FirstOrDefault()}"

            }).ToListAsync();

            return Ok(Hotels);  
        }
        //---------------End----------View----------End--------------

        //---------------Begin----------Create----------Begin--------------

        [HttpPost]
        public async Task<IActionResult> CreateHotel([FromForm]HotelDto hotel)
        {
            try
            {
                Hotel newHotel = new Hotel
                {
                    Name = hotel.Name,
                    Description= hotel.Description,
                    rating = hotel.rating,
                    location = hotel.location,
                    cordinate = hotel.cordinate,
                    map = hotel.map,
                    day1=hotel.day1,
                    day2=hotel.day2,
                    day3 = hotel.day3,
                };

                await _context.AddAsync(newHotel);
                await _context.SaveChangesAsync();

                var id = await _context.hotels
                                    .Where(x => x.cordinate == hotel.cordinate)
                                    .Select(x => x.Id)
                                    .FirstOrDefaultAsync();

                var Hotelimage = new Hotel_Image();
                Hotelimage.Hotelid = id;

                if (!ModelState.IsValid)
                {
                    return BadRequest("state is not valid");
                }

                if (hotel.imagefile != null)
                {
                    var fileResult = _fileService.SaveImage(hotel.imagefile);

                    if (fileResult.Item1 == 1)
                    {
                        Hotelimage.image = fileResult.Item2; // getting name of image
                       
                    }

                    var productResult = _productRepository.AddAsync(Hotelimage);
                    await _context.SaveChangesAsync();

                    if (productResult.Result)
                    {
                        return Ok($"successful adding ");
                    }
                    else
                    {
                        return BadRequest("error in uploading");
                    }
                }
                return Ok("no file upload");
            }
            catch (Exception ex)
            {
                // Log the exception
                // You can also rollback any changes made to the database here
                return StatusCode(500, "An error occurred while processing your request.");
            }


        }


        //---------------End----------Create----------End--------------
        [HttpPut]

        public async Task<IActionResult> UpdateHotel([FromForm]UpdateHotelDto hotel)
        {
            var get = _context.hotels.Find(hotel.Id);
            var image = _context.HotelImages.FirstOrDefault(x=>x.Id==hotel.Id);
            Console.WriteLine(image);
            if(get==null) 
            {
                return NotFound($"There no hotel with Id:{hotel.Id}");
            }
           
            if (image.image[0]!=null)
            {
                _fileService.DeleteImage(image.image);
            }
            if (!ModelState.IsValid)
            {
                return BadRequest("error in uploading");
            }
            if (hotel.imagefile != null)
            {
                var fileResult = _fileService.SaveImage(hotel.imagefile);
                if (fileResult.Item1 == 1)
                {
                    //image.image = fileResult.Item2; // getting name of image
                    get.Name = hotel.Name;
                    get.Description = hotel.Description;
                    get.rating = hotel.rating;
                    get.cordinate = hotel.cordinate;
                    get.location=hotel.location;
                    image.image=fileResult.Item2;
                    get.map=hotel.map;
                    get.day1=hotel.day1;
                    get.day2=hotel.day2;
                    get.day3=hotel.day3;
                    await _context.SaveChangesAsync();

                }

                return Ok($"succeful on update {hotel.Name}");
            }
            return BadRequest("upload photo please");
        }
        //-----------------begin------------------uploadphoto-----------------begin----------------------------//
        [HttpPost("upload photo")]
        public async Task<IActionResult> uploadPhoto(int  id, [FromForm] uploadPhoto model)
        {

            var Hotelimage = new Hotel_Image();
            Hotelimage.Hotelid = id;
            if (!ModelState.IsValid)
            {
                return BadRequest("error in uploading");
            }
            if (model.imagefile != null)
            {
                var fileResult = _fileService.SaveImage(model.imagefile);
                if (fileResult.Item1 == 1)
                {
                    Hotelimage.image = fileResult.Item2; // getting name of image
                }
                var productResult = _productRepository.AddAsync(Hotelimage);
                if (productResult.Result==true)
                {
                    return Ok("succesfull");
                }
                else
                {
                    return BadRequest("error in uploading");

                }
            }
            return Ok("Enter The Image ");

        }
        //-----------------End------------------uploadphoto-----------------End----------------------------//

        
        [HttpDelete]
        public async Task<IActionResult> DeleteHotel(int id)
        {
            var hotel = _context.hotels.Find(id);
            bool check =_context.HotelImages.Where(x=>x.Hotelid==id).Any();
            if(hotel!=null){
                if (check)
                {
                    var image = _context.HotelImages.FirstOrDefault(x => x.Hotelid == id);
                    _context.hotels.Remove(hotel);
                    _context.HotelImages.Remove(image);
                    _context.SaveChangesAsync();
                    _fileService.DeleteImage(image.image);
                }
                else
                {
                    _context.hotels.Remove(hotel);
                    _context.SaveChangesAsync();
                    
                }
            }
            else
            {
                return NotFound($"there no hotel with Id:{id}");
            }
            
            
            return Ok($"succesful on delete {hotel.Name}");
        }
        [HttpGet("GetHotel_ID")]
        public async Task<IActionResult> GetHotel_Id(int id) 
        {
            var hotel = _context.hotels.Where(x=>x.Id==id ).Select(x=>new
            {
                x.Id,
                x.Name,
                x.Description,
                x.location,
                x.rating,
                x.cordinate,
                x.feedbacks,
                image=x.images.Select(x=>x.image),
                x.rooms,
            });

            if (hotel!=null)
            {
                return Ok(hotel);
            }
            else
            {
                return NotFound($"there no hotel with Id:{id}");
            }


           
        }
    }
}
