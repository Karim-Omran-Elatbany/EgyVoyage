using EgyVoyageApi.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace EgyVoyageApi.Data.Configuration
{
    public class HotelImageConfigration : IEntityTypeConfiguration<Hotel_Image>
    {
        public void Configure(EntityTypeBuilder<Hotel_Image> builder)
        {
            builder.HasKey(x => x.Id);
            builder.Property(x => x.Id)
                .ValueGeneratedOnAdd();
            builder.HasOne(u => u.hotel)
               .WithMany(i => i.images)
               .HasForeignKey(f => f.Hotelid);
           // builder.HasData(loaddata());
        }

        private static List<Hotel_Image> loaddata()
        {
            return new List<Hotel_Image>
            {
                new Hotel_Image { Id=1 , Hotelid=1 ,image="https://drive.google.com/file/d/1GtU3c3DJQZA4ui1pryB93FAHiYg24Sth/view?usp=drive_link" },
                new Hotel_Image { Id=2 , Hotelid=2 ,image="https://drive.google.com/file/d/1Nk740D9LYU-P0n-PyfrFGSX8SIb68d24/view?usp=drive_link" },
                new Hotel_Image { Id=3 , Hotelid=3 ,image="https://drive.google.com/file/d/1PZsCYJcHgMxyFd1jRdxqS7h8-bLfEPtX/view?usp=drive_link" },
                new Hotel_Image { Id=4 , Hotelid=4 ,image="https://drive.google.com/file/d/1JY4ZVtUdZAJ22wXJBeA1YxesM-qkh1yj/view?usp=drive_link" },
                new Hotel_Image { Id=5 , Hotelid=5 ,image="" },
                new Hotel_Image { Id=6 , Hotelid=6 ,image="" },
                new Hotel_Image { Id=7 , Hotelid=7 ,image="https://drive.google.com/file/d/137KCzwdjEw7NPO_lG3vRM78IDxJzqrvh/view?usp=drive_link" },
                new Hotel_Image { Id=8 , Hotelid=8 ,image="https://drive.google.com/file/d/18m9XJIVTvB7qR9hhNJ2e4Sd3V0Hf7MLg/view?usp=drive_link" },
                new Hotel_Image { Id=9 , Hotelid=9 ,image="https://drive.google.com/file/d/1yzawrN2T4djvMNF7X0a9DEhCG5uYe-gn/view?usp=drive_link" },
                new Hotel_Image { Id=10, Hotelid=10,image="https://drive.google.com/file/d/14_fZMBnLrfj8b9Pa77VSm155Ns79hyeb/view?usp=drive_link" },
                new Hotel_Image { Id=11, Hotelid=11,image="https://drive.google.com/file/d/1EEdUedib9ZBS8yKzW-khF67abdmTHy2a/view?usp=drive_link" },
                new Hotel_Image { Id=12, Hotelid=12,image="https://drive.google.com/file/d/1-3SqTbQJLiws_-6IvtqeGJSFAzgcN-mh/view?usp=drive_link" },
                new Hotel_Image { Id=13, Hotelid=13,image="https://drive.google.com/file/d/1YeiQcKG6u7rlIcDp1JwWyyxsgdqL2pfk/view?usp=drive_link" },
                new Hotel_Image { Id=14, Hotelid=14,image="https://drive.google.com/file/d/1KNL6PAyCieeFGBih2cYpYGnP6BLoi7z1/view?usp=drive_link" },
                new Hotel_Image { Id=15, Hotelid=15,image="https://drive.google.com/file/d/17d8sawRPEbu_0WTLn8yG-OqpjxE2VuuO/view?usp=drive_link" },
                new Hotel_Image { Id=16, Hotelid=16,image="https://drive.google.com/file/d/1fIKjDTYnH09lywS7thkUvVp_Okry53Ud/view?usp=drive_link" },
                new Hotel_Image { Id=17, Hotelid=17,image="https://drive.google.com/file/d/1_uFtCPqUbdcYjWGlKC6I-mS25cVUly1R/view?usp=drive_link" },
                new Hotel_Image { Id=18, Hotelid=18,image="https://drive.google.com/file/d/16U1O9QBQ0ON6HVRQMCzU8uI1qX3acHLg/view?usp=drive_link" },


            };
        }
    }
}
