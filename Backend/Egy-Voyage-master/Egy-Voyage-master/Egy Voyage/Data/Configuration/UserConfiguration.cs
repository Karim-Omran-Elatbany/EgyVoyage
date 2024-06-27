using EgyVoyageApi.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace EgyVoyageApi.Data.Configuration
{
    public class UserConfiguration : IEntityTypeConfiguration<User>
    {
        public void Configure(EntityTypeBuilder<User> builder)
        {
            builder.HasKey(x => x.Id);

            builder.Property(x => x.Id).ValueGeneratedOnAdd();
            builder.Property(x => x.FName)
                .HasMaxLength(50);
            builder.Property(x => x.LName)
               .HasMaxLength(50);
            builder.Property(x=>x.Gender)
                .HasMaxLength (7);
            builder.Property(x => x.Email)
                .HasMaxLength(100)
                .IsRequired();
            builder.Property(x => x.Password)
                .HasMaxLength(50)
                .IsRequired();
            builder.HasIndex(x => x.Email)
                .IsUnique();
            builder.HasIndex(x => x.Password)
                .IsUnique();

            builder.Property(x => x.Nationality)
                .HasMaxLength(50);
            builder.Property(x => x.PhoneNumber)
                .HasMaxLength(50);
            builder.HasIndex(x => x.PhoneNumber)
                .IsUnique();


            builder.Property(x => x.birthdate)
                .HasColumnType("date").IsRequired();




            builder.Property(x => x.SSN)
                   .HasMaxLength(50);
            builder.HasIndex(x => x.SSN)
                .IsUnique();
            builder.HasData(LoadData());
        }
        private static List<User> LoadData()
        {
            return new List<User>
    {
        new User
        {
            Id = 1,
            FName = "marwan",
            LName = "Emad",
            Gender= "male",
            PhoneNumber = "01060708090",
            Nationality = "England",
            SSN = "30210171402082",
            birthdate = new DateTime(2005, 12, 1,0,0,0),
            Email = "marwanemad612005@gmail.com",
            Password = "marwanemad"
        },
        new User
        {
            Id = 2,
            FName = "Karim",
            LName = "Emad",
            Gender= "male",
            PhoneNumber = "01032392337",
            Nationality = "Egypt",
            SSN = "30210171402092",
            birthdate = new DateTime(2002, 10, 17,0,0,0),
            Email = "kareememad612005@gmail.com",
            Password = "karimemad"
        }
    };
        }







    }
}

