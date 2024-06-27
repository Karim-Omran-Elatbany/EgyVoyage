using EgyVoyageApi.DTOs;

namespace EgyVoyageApi.Repository.Abastract
{
    public interface IEmailService
    {
        public Task<string> SendEmailAsync(UserDto user);
    }
}
