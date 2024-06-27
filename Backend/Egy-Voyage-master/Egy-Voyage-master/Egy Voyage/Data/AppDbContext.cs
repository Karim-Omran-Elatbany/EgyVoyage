using Egy_Voyage.Entities;
using EgyVoyageApi.Entities;
using Microsoft.EntityFrameworkCore;

namespace EgyVoyageApi.Data
{
    public class AppDbContext :DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options): base(options) 
        {

        }
         public DbSet<User> users {  get; set; }
        public DbSet<Hotel> hotels { get; set; }
        public DbSet<room> rooms { get; set; }
        public DbSet<Reservation> reservations { get; set; }
        public DbSet<UserImage> UserImages { get; set; }
        public DbSet <Hotel_Image> HotelImages { get; set; }
        public DbSet <feedback_Hotel> feedbacks { get; set; }
        public DbSet<place> places { get; set; }
        public DbSet<Admin> admin { get; set; }
        public DbSet<receipt> receipts { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            base.OnConfiguring(optionsBuilder);
            var conf =  new ConfigurationBuilder().AddJsonFile("appsettings.json").Build();
            var conn = conf.GetSection("constr").Value;
            optionsBuilder.UseSqlServer(conn);
        }
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);
            modelBuilder.ApplyConfigurationsFromAssembly(typeof(AppDbContext).Assembly);

        }
    }
}
