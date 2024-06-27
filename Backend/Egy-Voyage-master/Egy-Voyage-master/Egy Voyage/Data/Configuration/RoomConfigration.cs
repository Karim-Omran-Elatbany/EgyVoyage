using EgyVoyageApi.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
using System;
using System.Reflection.Emit;

namespace EgyVoyageApi.Data.Configuration
{
    public class RoomConfigration : IEntityTypeConfiguration<room>
    {
        public void Configure(EntityTypeBuilder<room> builder)
        {
            builder.HasKey(x => x.Id);
            builder.Property(x=>x.Id)
                .IsRequired().ValueGeneratedOnAdd();
            builder.Property(x=>x.RoomNumber)
                .HasMaxLength(255)
                .HasColumnType("varchar");

            builder.HasOne(x => x.Hotel)
                .WithMany(x => x.rooms)
                .HasForeignKey(x => x.HotelId);
           
           

            

           // builder.HasData(loaddata());
        }

        private static List<room> loaddata()
        {
            return new List<room>
            {
                new room{Id=1,RoomNumber="1", category= "sweet", price=90,HotelId=1,image="" },
                new room{Id=2,RoomNumber="2", category= "single", price=20,HotelId=1,image="" },
                new room{Id=3,RoomNumber="3", category= "Double", price=45,HotelId=1 , image = ""},
                new room{Id=4,RoomNumber="4", category= "trial", price=250,HotelId=1 , image = ""},
                new room{Id=5,RoomNumber="1", category= "four beds", price=500,HotelId=2,image="" },
                new room{Id=6,RoomNumber="2", category= " without view", price=20,HotelId=2 , image = ""},


            };
        }
    }
}
