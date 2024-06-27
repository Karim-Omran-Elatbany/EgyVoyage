using Egy_Voyage.DTOs;
using EgyVoyageApi.Data;
using EgyVoyageApi.DTOs;
using EgyVoyageApi.Entities;
using EgyVoyageApi.Repository.Abastract;
using EgyVoyageApi.Repository.Implementation;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace EgyVoyageApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PlaceController : ControllerBase
    {
        private readonly AppDbContext _context;
        private readonly IFileService _fileService;
        


        
        
        public PlaceController(AppDbContext context, IFileService fileService)
        {
            _context=context;
            _fileService=fileService;
           
        }
        [HttpGet]
        public async Task<IActionResult> GetAllPlaces()
        {
            var places = await _context.places.Select(x => new
            { 
                x.Id, 
                name= x.Name,
               description= x.Description,
                rating=x.rating,
                city=x.city,
               url_location= x.url_location,
                cordinate = x.cordinate,
                Adult_price=x.pirce,
                child_price=x.pirce*0.02,
                tourist_price=x.pirce*2,
                start=x.start,
                end=x.end,
                image=$"http://egyvoyage2.somee.com/Resources/{x.image}",

            }).ToListAsync();
            return Ok(places);
        }
        [HttpPost]
        public async Task<IActionResult> CreatePlace([FromForm]PlaceDTO place)
        {
            var newplace = new place
            {
                Name = place.Name,
                city=place.city,
                Description = place.Description,
                rating = place.rating,
                url_location= place.url_location,
                cordinate = place.cordinate,
                pirce=place.price,
                start=place.start,
                end=place.end,
                
            };

            if (!ModelState.IsValid)
            {
                return BadRequest("state is not valid");
            }
            if (place.imagefile != null)
            {
                var fileResult = _fileService.SaveImage(place.imagefile);

                if (fileResult.Item1 == 1)
                {
                    newplace.image = fileResult.Item2; // getting name of image

                }
                else
                {
                    return BadRequest(fileResult.Item2);
                }
                await _context.AddAsync(newplace);
                await _context.SaveChangesAsync();
                return Ok($"succesful add{newplace.Name}");

            }
            else
            {
                return BadRequest("no photo uploaded");
            }

        }
        [HttpDelete]
        public async Task<IActionResult> deleteplace(int id)
        {
            var place = await _context.places.Where(x=>x.Id==id).FirstOrDefaultAsync();
            if (place == null)
            {
                return Ok($"no place wih this {id}");
            }
             _context.places.Remove(place);
            _context.SaveChanges();
            return Ok($"seccesful deleting {place.Name}");
        }
        [HttpPut]

        public async Task<IActionResult> UpdateHotel([FromForm] UpdatePlaceDTO place)
        {
            var get = _context.places.Find(place.id);
            var image = _context.places.SingleOrDefault(x => x.Id == place.id);
            Console.WriteLine(image);
            if (get == null)
            {
                return NotFound($"There no Place with Id:{place.id}");
            }

            if (image.image != "")
            {
                _fileService.DeleteImage(image.image);
            }
            if (!ModelState.IsValid)
            {
                return BadRequest("error in uploading");
            }
            if (place.imagefile != null)
            {
                var fileResult = _fileService.SaveImage(place.imagefile);
                if (fileResult.Item1 == 1)
                {
                    //image.image = fileResult.Item2; // getting name of image
                    get.Name = place.Name;
                    get.city = place.city;
                    get.rating = place.rating;
                    get.cordinate = place.cordinate;
                    get.url_location = place.url_location;
                    get.image=fileResult.Item2;
                    await _context.SaveChangesAsync();

                }

                return Ok($"succeful on update {place.Name}");
            }
            return BadRequest("upload photo please");
        }
    }



}