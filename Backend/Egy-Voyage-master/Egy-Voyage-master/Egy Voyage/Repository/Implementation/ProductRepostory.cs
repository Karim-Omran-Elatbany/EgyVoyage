using EgyVoyageApi.Data;
using EgyVoyageApi.Entities;
using EgyVoyageApi.Repository.Abastract;
using Microsoft.EntityFrameworkCore;

namespace EgyVoyageApi.Repository.Implementation
{
	public class ProductRepostory : IProductRepository
	{
		private readonly AppDbContext _context;
		public ProductRepostory(AppDbContext context)
		{
			this._context = context;
		}
        public async Task<bool> AddAsync(UserImage model)
        {
            try
            {
                bool check = await _context.users.Where(x => x.Email == model.email).AnyAsync();
                 

                if (check != false)
                {
                    var existingUser = await _context.users.FirstOrDefaultAsync(x => x.Email == model.email);
                    var image = new UserImage
                    {
                        UserId = existingUser.Id,
                        image = model.image,
                    };

                    await _context.UserImages.AddAsync(image);
                     await _context.SaveChangesAsync();
                    Console.WriteLine(true);

                    return true;
                }

                return false;
            }
            catch (Exception ex)
            {
                // Log or handle the exception appropriately
                Console.WriteLine($"Eh da{false}");
                return false;
            }
        }

        public async Task<bool> AddAsync(Hotel_Image model)
        {
            try
            {
                var existingHotel= await _context.hotels.FirstOrDefaultAsync(x=>x.Id==model.Hotelid);
                if (existingHotel != null)
                {
                     Hotel_Image image = new Hotel_Image
                    {
                        Hotelid = existingHotel.Id,
                        image = model.image,
                    };
                    await _context.HotelImages.AddAsync(image);
                    await _context.SaveChangesAsync();
                    Console.WriteLine(true);
                    return true;
                }
                return false;
            }
            catch (Exception ex)
            {
                return false;
            }
        }
        



    }
}
