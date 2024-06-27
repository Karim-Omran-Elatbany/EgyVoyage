using EgyVoyageApi.Data;
using EgyVoyageApi.DTOs;
using EgyVoyageApi.Entities;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using EgyVoyageApi.Repository.Abastract;
using System.Net;
using System.Net.Mail;
using Egy_Voyage.DTOs;

namespace EgyVoyageApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        private readonly AppDbContext _context;
      
        
        private readonly IFileService _fileService;
        private readonly IProductRepository _productRepo;
        private readonly IEmailService _emailService;

        public UserController(AppDbContext context,IEmailService emailService, IFileService fs, IProductRepository productRepo)
        {
            _context = context;
            _emailService=emailService;
            this._fileService = fs;
            this._productRepo = productRepo;
        }
        [HttpGet]
        public async Task<IActionResult> GetUser() 
        { 
            var users = await _context.users
                .Select(x => new
                {
                    x.Id,
                    x.FName,
                    x.LName,
                    x.Email,
                    x.Gender,
                    x.birthdate,
                    x.Nationality,
                    x.Image.image
                })
                .ToListAsync();
            if (users == null)
            {
                BadRequest("NO users registered");
            }
            return Ok(users);
        }

        //---------------------Begin--------------------signup-----------------------------begin--------------------------
        [HttpPost]
        public async Task<IActionResult> SignUP(UserDto user)
        {
            var newuser = new User
            {
               
               FName=user.FName,
               LName=user.LName,
               Gender=user.Gender,
               Nationality=user.Nationality,
               PhoneNumber=user.PhoneNumber,
               SSN=user.SSN,
               birthdate=user.birthdate,
               Email=user.Email,
               Password=user.Password,

            };
            
            var check = await _context.users.Where(x=>x.Email==user.Email || x.Password==user.Password||x.SSN==user.SSN||x.PhoneNumber==user.PhoneNumber).AnyAsync();
            if (!check)
            {

               
                try
                {
                   var code= await _emailService.SendEmailAsync(user);
                    if (code.Length==6)
                    {
                        await _context.users.AddAsync(newuser);
                        await _context.SaveChangesAsync();
                        return Ok(new { Code = code, User = newuser });
                    }
                    else
                    {
                        return BadRequest($"{code}");
                    }
                }
                catch (Exception ex)
                {
                    return BadRequest($"Smtp send failed with the exception: {ex.Message}.");
                }
               

            }
            else if(check) 
            {
                return BadRequest("this user has already Registered");
            }

            return BadRequest("SignUp Again");
           

        }

        //-------------------End----------------------signup--------------------------End------------------------------


        //-------------------Begin----------------send email explicitly--------------Begin-----------------------------

        [HttpPost("send email")]

        public async Task<IActionResult> sendemail(string email)
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


            var message = new MailMessage("egyvoyage@gmail.com", email, "Welcome to Egy Voyage Application( this your virification code)", code);
            try
            {
                await client.SendMailAsync(message);
                return Ok("succes");
            }
            catch (Exception ex)
            {
                return BadRequest($"Smtp send failed with the exception: {ex.Message}.");
            }
        }
        //-------------------End----------------send email explicitly--------------End-----------------------------

        //------------------Begin----------------------signin---------------------Begin----------------------------

        [HttpGet("signin")]//post
        public async Task<IActionResult>SignIn(string email,string password)
        {
            bool check = await _context.users.Where(x=>x.Email == email & x.Password==password).AnyAsync();
            if (check)
            {
                return StatusCode(statusCode: 200, check);
            }
            else
            {
                 return StatusCode(500, new {  check, Message = "Email or password wrong" });
            }
            
        }

        //------------------End----------------------signin---------------------End----------------------------//
        //-----------------begin------------------uploadphoto-----------------begin----------------------------//
        [HttpPost("upload photo")] 
        public async Task<IActionResult> uploadPhoto(string email,[FromForm]uploadPhoto model )
        {
            var id =  _context.users.Where(_ => _.Email == email).Select(x=>x.Id).SingleOrDefault();
            bool check = _context.UserImages.Where(x => x.UserId==id).Any();
            if (!check)
            {


                var Userimage = new UserImage();
                Userimage.email = email;
                if (!ModelState.IsValid)
                {
                    return BadRequest("error in uploading");
                }
                if (model.imagefile != null)
                {
                    var fileResult = _fileService.SaveImage(model.imagefile);
                    if (fileResult.Item1 == 1)
                    {
                        Userimage.image = fileResult.Item2; // getting name of image
                    }
                    var productResult = _productRepo.AddAsync(Userimage);
                    if (productResult.Result==true)
                    {
                        return Ok("succesfull");
                    }
                    else
                    {
                        var path = $"Uploads/{fileResult.Item2}";
                        if (System.IO.File.Exists(path))
                        {
                            System.IO.File.Delete(path);
                        }
                        return BadRequest("error in uploading1");

                    }
                }
                return Ok("succesful");
            }
            else
            {
                var userimage = _context.UserImages.Where(x=>x.UserId==id).SingleOrDefault();
                var path = $"Uploads/{userimage.image}";
                if (System.IO.File.Exists(path))
                {
                    System.IO.File.Delete(path);
                }
                if (model.imagefile != null)
                {
                    var fileResult = _fileService.SaveImage(model.imagefile);
                    if (fileResult.Item1 == 1)
                    {
                        userimage.image = fileResult.Item2; // getting name of image
                        _context.SaveChanges();
                        return Ok("succesfull");
                    }
                    else
                    {
                        var path2 = $"Uploads/{fileResult.Item2}";
                        if (System.IO.File.Exists(path2))
                        {
                            System.IO.File.Delete(path2);
                        }
                        return BadRequest("error in uploading1");

                    }
                }
                return Ok("succesful");


            }

        }
        //-----------------End------------------uploadphoto-----------------End----------------------------//
        //-----------------begin-----------------GetPhotoUrl----------------Begin--------------------------//
        [HttpGet("GetPHoto")]
        public async Task<IActionResult> GetPhoto(String email)
        {
            var UserId = await _context.users.SingleOrDefaultAsync(x => x.Email == email);

            if(UserId == null)
            {
                return BadRequest("wrong email");
            }
            else
            {
                var images = await  _context.UserImages.Where(x => x.UserId==UserId.Id).Select(x => x.image).ToListAsync();
                var url = string.Join(",", images);
                //return Ok($"https://localhost:7244/Resources/{url}");//for local
                return Ok($"http://egyvoyage2.somee.com/Resources/{url}");//for server
            }


        }
        //-----------------End-----------------GetPhotoUrl----------------End--------------------------//
        //-----------------begin---------------Forgetpassword-------------begin------------------------//
        [HttpGet("ForgetPassword")]
        public async Task <IActionResult> ForgetPass(string email) 
        {
            bool check = await _context.users.Where(x=>x.Email== email).AnyAsync();
            if (check)
            {
                var user = await _context.users.Where(x=>x.Email== email).FirstOrDefaultAsync();
                UserDto userDto = new UserDto
                {
                    FName=user.FName,
                    LName=user.LName,
                    Gender=user.Gender,
                    Nationality=user.Nationality,
                    PhoneNumber=user.PhoneNumber,
                    SSN=user.SSN,
                    birthdate=user.birthdate,
                    Email=user.Email,
                    Password=user.Password,

                };

                var code = await _emailService.SendEmailAsync(userDto);
                if (code.Length==6)
                {
                    return Ok(new { Code = code });
                }
                else
                {
                    return BadRequest($"{code}");
                }
            }
            else
            {
                return BadRequest("This user hasn't registered yet");
            }
        }

        //end forget--------------------------------------------for web------- 
        [HttpGet("change password")]
        public async Task<IActionResult> ChangePass(string email,string pass)
        {
            var user =await _context.users.Where(x=>x.Email== email).FirstOrDefaultAsync();
            user.Password= pass;
            _context.SaveChanges();
            return Ok("succesfull");

        }
        //[HttpPost("change password")]
        //public async Task<IActionResult> ChangePassf(string email, string pass)
        //{
        //    var user = await _context.users.Where(x => x.Email== email).FirstOrDefaultAsync();
        //    user.Password= pass;
        //    _context.SaveChanges();
        //    return Ok("succesfull");

        //}

        //-----------------End---------------Forgetpassword-------------End------------------------//
        //-----------------begin---------------Editprofile---------------begin---------------------//
        [HttpPost("Edit")]
        public async Task<IActionResult> EditProfile(string Email,EditUserDto us)
        {
            var User = await _context.users.Where(x=>x.Email == Email).FirstOrDefaultAsync();
            User.FName = us.FName;
            User.LName = us.LName;
            User.Email = us.Email;
            User.PhoneNumber = us.PhoneNumber;
            _context.SaveChanges();
            return Ok("Succesful");

        }
        //get spacific data 
        [HttpGet("getuser")]//post
        public async Task<IActionResult> GetUser(string email, string password)
        {
            var user = await _context.users.Where(x => x.Email == email & x.Password==password)
                
                .Select(x=>new
                {
                  fnmam=  x.FName,
                  lname= x.LName, 
                  Email= x.Email,
                  PhoneNumber= x.PhoneNumber
                }).ToListAsync();
            bool check = await _context.users.Where(x => x.Email == email & x.Password==password).AnyAsync();
            if (check)
            {
                return StatusCode(statusCode: 200, user);
            }
            else
            {
                return StatusCode(500, new { user, Message = "Email or password wrong" });
            }

        }
        //image as data stream
        [HttpPost("upload_photo")]
        public async Task<IActionResult> upload_Photo(uploadphoto data)
        {
            IFormFile imagefile = _fileService.ConvertToFormFile(data.image, fileName: "output.jpg");

            var Userimage = new UserImage();
            Userimage.email = data.email;
            if (!ModelState.IsValid)
            {
                return BadRequest("error in uploading");
            }
            if (imagefile !=null )
            {
               

                var fileResult = _fileService.SaveImage(imagefile);
                if (fileResult.Item1 == 1)
                {
                    Userimage.image = fileResult.Item2; // getting name of image
                }
                var productResult = _productRepo.AddAsync(Userimage);
                if (productResult.Result == true)
                {
                    return Ok("succeful");
                }
                else
                {
                    var path = $"Uploads/{fileResult.Item2}";
                    if (System.IO.File.Exists(path))
                    {
                        System.IO.File.Delete(path);
                    }
                    return BadRequest("error in uploading1");

                }
            }
            return Ok("succesful");

        }

    }
}
