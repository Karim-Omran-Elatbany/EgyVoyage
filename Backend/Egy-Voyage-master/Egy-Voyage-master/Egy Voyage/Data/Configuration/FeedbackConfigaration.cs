using EgyVoyageApi.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System.Reflection.Emit;

namespace EgyVoyageApi.Data.Configuration
{
    public class FeedbackConfigaration : IEntityTypeConfiguration<feedback_Hotel>
    {
        public void Configure(EntityTypeBuilder<feedback_Hotel> builder)
        {
            builder.HasKey(x => x.Id);
            builder.Property(x=>x.Id).ValueGeneratedOnAdd();
            builder.Property(x=>x.description).HasMaxLength(250);
            builder.Property(x => x.rating)
                  .HasColumnType("decimal(2,1)");

            builder.HasOne(x => x.Hotel)
                .WithMany(x => x.feedbacks)
                .HasForeignKey(x => x.HotelId);
            builder.HasOne(x => x.User)
               .WithMany(x => x.feedbacks)
               .HasForeignKey(x => x.user_id);
               


            builder.HasIndex(x => new { x.user_id, x.HotelId }).IsUnique();
        }
    }
}
