using EgyVoyageApi.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Diagnostics;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace EgyVoyageApi.Data.Configuration
{
    public class HotelConfigration : IEntityTypeConfiguration<Hotel>
    {
        public void Configure(EntityTypeBuilder<Hotel> builder)
        {
            builder.HasKey(x => x.Id);

            builder.Property(x=>x.Id)
                .ValueGeneratedOnAdd();

            builder.Property(x => x.Name)
                .HasColumnType("varchar")
                .HasMaxLength(50);

            builder.Property(x => x.rating)
                   .HasColumnType("decimal(2,1)");
            builder.Property(x => x.location)
                .HasMaxLength(100)
                .HasColumnType("varchar");
            builder.Property(x => x.cordinate)
                .HasColumnType("varchar")
                .HasMaxLength(255)
                .IsRequired();
            //builder.HasData(loaddata());
        }

        private static List<Hotel> loaddata()
        {
            return new List<Hotel> {
                   new Hotel {Id=1, Name="InterContinental Cairo Semiramis", rating=8.4m ,location= "cairo",cordinate="30.04293591919304, 31.232465642327202" },
                   new Hotel {Id=2, Name="Staybridge Suites Cairo - Citystars" ,rating=9.4m, location="cairo",cordinate = "30.072862226923522, 31.3441160576728" },
                   new Hotel {Id=3, Name="Holiday Inn Cairo Maadi",rating=9.2m ,location="cairo" ,cordinate="29.966411199098626, 31.247869412926487"},
                   new Hotel {Id=4, Name="Hilton Alexandria Green Plaza",rating=8.8m ,location="alexandria" ,cordinate="31.206587299633576, 29.9655222"},
                   new Hotel {Id=5, Name="Le Metropole Luxury Heritage Hotel" ,rating=8.7m ,location="alexandria" ,cordinate="31.200553519537113, 29.900450286509205"},
                   new Hotel {Id=6, Name="Sunrise Alex Avenue Hotel" ,rating=8.9m ,location="alexandria" ,cordinate="31.234070186878224, 29.94575999999999"},
                   new Hotel {Id=7, Name="BAYT ZAINA - Nubian hospitality house" ,rating=8.0m ,location="aswan" ,cordinate="24.088829775266355, 32.88561"},
                   new Hotel {Id=8, Name="ASWAN NILE PALACE " ,rating=8.5m ,location="aswan" ,cordinate="24.072882985025814, 32.8807118576728"},
                   new Hotel {Id=9, Name="Eco Nubia" ,rating=8.8m ,location="aswan" ,cordinate="24.02199279822332, 32.882644244182"},
                   new Hotel {Id=10, Name="Steigenberger Nile Palace" ,rating=9.2m ,location="luxor",cordinate="25.68769348233419, 32.631230571163606"},
                   new Hotel {Id=11, Name="Sonesta St. George Hotel - Convention Center" ,rating=9.3m ,location="luxor" ,cordinate="25.688688471066975, 32.631247226981586"},//not sure with location
                   new Hotel {Id=12, Name="Jolie Ville Hotel & Spa Kings Island Luxor" ,rating=8.8m , location="luxor" ,cordinate="25.66566559456018, 32.6217391576728"},
                   new Hotel {Id=13, Name="Rixos Alamein - Full Board Plus" ,rating=9.0m ,location="north coast" ,cordinate="31.034908782599928, 28.5915378711636"},
                   new Hotel {Id=14,Name="Africana Hotel & Spa" ,rating=8.3m ,location="north coast" ,cordinate ="30.986769794210236, 29.681881055817993"},
                   new Hotel {Id=15, Name="Crystal Inn Hotel - El Alamein" ,rating=8.7m, location="north coast" ,cordinate="30.848485616482314, 28.948256101854803"},
                   new Hotel {Id=16, Name="The Makadi Spa Hotel" ,rating=9.5m, location="red sea" , cordinate="27.000614279705367, 33.9088669981452"},
                   new Hotel {Id=17, Name="Moon Beach Hotel Hurghad" ,rating=9.1m ,location="red sea" ,cordinate="27.302533376635402, 33.74602927228017"},
                   new Hotel {Id=18,Name="Sharm Inn Amarein - Boutique Hotel",rating=8.6m ,location="red sea" , cordinate="27.873942342029405, 34.3056422981452"},
            };
        }

    }
}
