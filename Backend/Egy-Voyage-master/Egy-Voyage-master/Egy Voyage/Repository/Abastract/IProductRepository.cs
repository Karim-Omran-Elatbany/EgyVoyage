using EgyVoyageApi.Entities;

namespace EgyVoyageApi.Repository.Abastract
{
    public interface IProductRepository
    {
        Task<bool> AddAsync(UserImage model);
        Task<bool> AddAsync(Hotel_Image model);
        
    }
}
