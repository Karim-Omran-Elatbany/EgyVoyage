using Egy_Voyage.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Egy_Voyage.Data.Configuration
{
    public class ReceiptConfigration : IEntityTypeConfiguration<receipt>
    {
        public void Configure(EntityTypeBuilder<receipt> builder)
        {
            builder.HasKey(x => x.Id);

            builder.Property(x=>x.Id).ValueGeneratedOnAdd();
            
            builder.Property(x=>x.email).HasMaxLength(128);
            
            builder.Property(x=>x.total_price).HasMaxLength(9);

            builder.HasOne(x => x.Hotel)
                .WithMany(x => x.receipts)
                .HasForeignKey(x => x.HotelId);






        }
    }
}
