using EgyVoyageApi.Data;
using EgyVoyageApi.DTOs;
using EgyVoyageApi.Entities;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace EgyVoyageApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AdminController : ControllerBase
    {
        private readonly AppDbContext _context;

        public AdminController(AppDbContext context)
        {
            _context=context;
        }
        [HttpGet]
        public async Task<IActionResult> GetAllAdmins()
        {
            var Admins = await _context.admin.ToListAsync();
            
            
            return Ok(Admins);
        }
        [HttpPost]
        public async Task<IActionResult> CreateAdmin(AdminDTO admin )
        {
            Admin newAdmin = new Admin
            {
                Name = admin.Name,
                Email = admin.Email,
                Password = admin.Password
            };

            await _context.AddAsync(newAdmin);
            await _context.SaveChangesAsync();
            return Ok($"succesful to create admin:{admin.Name}");
        }
        [HttpPost("LoginAdmin")]
        public async Task<IActionResult> Admin_Login(LoginAdminDTO admin)
        {
          bool check = await _context.admin.Where(x=>x.Email == admin.Email &&x.Password==admin.Password).AnyAsync(); 
            if (check)
            {
                return Ok(check);
            }
            else
            {
                return StatusCode(500, new { check, Message = "Email or password wrong" });
            }
        }

    }
}
