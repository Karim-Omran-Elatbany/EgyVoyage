using EgyVoyageApi.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace EgyVoyageApi.Data.Configuration
{
    public class AdminConfigration : IEntityTypeConfiguration<Admin>
    {
        public void Configure(EntityTypeBuilder<Admin> builder)
        {
            builder.HasKey(x => x.Id);
            builder.Property(x=>x.Id).IsRequired()
                .ValueGeneratedOnAdd();
            builder.Property(x => x.Name)
                .HasColumnType("varchar")
                .HasDefaultValue("admin")
                .HasMaxLength(15);
            builder.Property(x=>x.Email).HasMaxLength(50);
            builder.Property(x=>x.Password).HasMaxLength(50);
            builder.HasIndex(x => x.Email);
            builder.HasIndex(x => x.Password);

            builder.HasData(loaddata());

        }

        private static List<Admin> loaddata()
        {
            return new List<Admin>
            {
                new Admin { Id = 1, Name="Karim", Email="kareememad612005@gamil.com", Password="karimemad" },
            };
        }
    }
}
