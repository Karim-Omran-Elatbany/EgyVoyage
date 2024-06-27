using EgyVoyageApi.DTOs;
using EgyVoyageApi.Repository.Abastract;
using Microsoft.EntityFrameworkCore;
using System.Net.Mail;
using System.Net;

namespace EgyVoyageApi.Repository.Implementation
{
    public class EmialService : IEmailService
    {
        public async Task<string> SendEmailAsync(UserDto user)
        {
            var random = new Random();
            string code = random.Next(100000, 999999).ToString();
            string pass = "nzrpygitegotrnng";
            var client = new SmtpClient("smtp.gmail.com")
            {
                Port = 587,
                Credentials = new NetworkCredential("egyvoyage@gmail.com", pass),
                EnableSsl = true
            };

            var message = new MailMessage("egyvoyage@gmail.com", user.Email, "Welcome to Egy Voyage Application (this your verification code)", code);
            try
            {
                await client.SendMailAsync(message);
                return code;
            }
            catch (Exception ex)
            {
                // Log the exception or handle it appropriately
                return($"Failed to send email: {ex.Message}");
            }
            finally
            {
                // Ensure that the SmtpClient is properly disposed
                client.Dispose();
                // Ensure that the MailMessage is properly disposed
                message.Dispose();
            }
        }
    }
}
