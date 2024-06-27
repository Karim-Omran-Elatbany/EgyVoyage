using EgyVoyageApi.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace EgyVoyageApi.Data.Configuration
{
    public class ResevationConfigration : IEntityTypeConfiguration<Reservation>
    {
        public void Configure(EntityTypeBuilder<Reservation> builder)
        {
            builder.HasKey(x => x.Id);

            builder.Property(x=>x.Id)
                .IsRequired()
                .ValueGeneratedOnAdd();

            builder.Property(x => x.Start)
                .IsRequired()
                .HasColumnType("date");

            builder.Property(x => x.End)
                .IsRequired(false)
                .HasColumnType("date");
            builder.HasOne(x => x.user)
                .WithMany(x => x.Reservations)
                .HasForeignKey(x=>x.UserId);
            builder.HasOne(x=>x.room)
                .WithMany(room => room.Reservations)
                .HasForeignKey(x=>x.roomId);
            // builder.HasData(loaddata());
            builder.HasOne(x => x.receipt)
                .WithMany(x => x.Reservations)
                .HasForeignKey(x => x.receiptId);
        }

        private static List<Reservation> loaddata()
        {
            return new List<Reservation>
            {
                new Reservation {Id=1,UserId=2,roomId=1,Start=new DateTime(2024, 3, 10, 0, 0, 0),End=new DateTime(2024,3,15,0,0,0)},
                new Reservation {Id=2,UserId=2,roomId=1,Start=new DateTime(2024, 3, 4, 0, 0, 0),End=new DateTime(2024, 3, 10, 0, 0, 0)},
                 new Reservation {Id=1,UserId=2,roomId=15,Start=new DateTime(2024, 3, 10, 0, 0, 0),End=new DateTime(2024,3,15,0,0,0)},


            };
        }
    }
}
