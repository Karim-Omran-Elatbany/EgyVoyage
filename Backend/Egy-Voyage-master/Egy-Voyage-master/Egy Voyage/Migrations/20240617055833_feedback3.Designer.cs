﻿// <auto-generated />
using System;
using EgyVoyageApi.Data;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;

#nullable disable

namespace Egy_Voyage.Migrations
{
    [DbContext(typeof(AppDbContext))]
    [Migration("20240617055833_feedback3")]
    partial class feedback3
    {
        /// <inheritdoc />
        protected override void BuildTargetModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "7.0.16")
                .HasAnnotation("Relational:MaxIdentifierLength", 128);

            SqlServerModelBuilderExtensions.UseIdentityColumns(modelBuilder);

            modelBuilder.Entity("EgyVoyageApi.Entities.Admin", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<string>("Email")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("nvarchar(50)");

                    b.Property<string>("Name")
                        .IsRequired()
                        .ValueGeneratedOnAdd()
                        .HasMaxLength(15)
                        .HasColumnType("varchar")
                        .HasDefaultValue("admin");

                    b.Property<string>("Password")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("nvarchar(50)");

                    b.HasKey("Id");

                    b.HasIndex("Email");

                    b.HasIndex("Password");

                    b.ToTable("admin");

                    b.HasData(
                        new
                        {
                            Id = 1,
                            Email = "kareememad612005@gamil.com",
                            Name = "Karim",
                            Password = "karimemad"
                        });
                });

            modelBuilder.Entity("EgyVoyageApi.Entities.Hotel", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<string>("Description")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("varchar");

                    b.Property<string>("cordinate")
                        .IsRequired()
                        .HasMaxLength(255)
                        .HasColumnType("varchar");

                    b.Property<string>("day1")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("day2")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("day3")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("location")
                        .IsRequired()
                        .HasMaxLength(100)
                        .HasColumnType("varchar");

                    b.Property<string>("map")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<decimal>("rating")
                        .HasColumnType("decimal(2,1)");

                    b.HasKey("Id");

                    b.ToTable("hotels");
                });

            modelBuilder.Entity("EgyVoyageApi.Entities.Hotel_Image", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<int>("Hotelid")
                        .HasColumnType("int");

                    b.Property<string>("image")
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id");

                    b.HasIndex("Hotelid");

                    b.ToTable("HotelImages");
                });

            modelBuilder.Entity("EgyVoyageApi.Entities.Reservation", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<DateTime?>("End")
                        .HasColumnType("date");

                    b.Property<DateTime>("Start")
                        .HasColumnType("date");

                    b.Property<int>("UserId")
                        .HasColumnType("int");

                    b.Property<int>("receiptId")
                        .HasColumnType("int");

                    b.Property<int>("roomId")
                        .HasColumnType("int");

                    b.HasKey("Id");

                    b.HasIndex("UserId");

                    b.HasIndex("receiptId");

                    b.HasIndex("roomId");

                    b.ToTable("reservations");
                });

            modelBuilder.Entity("EgyVoyageApi.Entities.User", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<string>("Email")
                        .IsRequired()
                        .HasMaxLength(100)
                        .HasColumnType("nvarchar(100)");

                    b.Property<string>("FName")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("nvarchar(50)");

                    b.Property<string>("Gender")
                        .IsRequired()
                        .HasMaxLength(7)
                        .HasColumnType("nvarchar(7)");

                    b.Property<string>("LName")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("nvarchar(50)");

                    b.Property<string>("Nationality")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("nvarchar(50)");

                    b.Property<string>("Password")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("nvarchar(50)");

                    b.Property<string>("PhoneNumber")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("nvarchar(50)");

                    b.Property<string>("SSN")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("nvarchar(50)");

                    b.Property<DateTime>("birthdate")
                        .HasColumnType("date");

                    b.HasKey("Id");

                    b.HasIndex("Email")
                        .IsUnique();

                    b.HasIndex("Password")
                        .IsUnique();

                    b.HasIndex("PhoneNumber")
                        .IsUnique();

                    b.HasIndex("SSN")
                        .IsUnique();

                    b.ToTable("users");

                    b.HasData(
                        new
                        {
                            Id = 1,
                            Email = "marwanemad612005@gmail.com",
                            FName = "marwan",
                            Gender = "male",
                            LName = "Emad",
                            Nationality = "England",
                            Password = "marwanemad",
                            PhoneNumber = "01060708090",
                            SSN = "30210171402082",
                            birthdate = new DateTime(2005, 12, 1, 0, 0, 0, 0, DateTimeKind.Unspecified)
                        },
                        new
                        {
                            Id = 2,
                            Email = "kareememad612005@gmail.com",
                            FName = "Karim",
                            Gender = "male",
                            LName = "Emad",
                            Nationality = "Egypt",
                            Password = "karimemad",
                            PhoneNumber = "01032392337",
                            SSN = "30210171402092",
                            birthdate = new DateTime(2002, 10, 17, 0, 0, 0, 0, DateTimeKind.Unspecified)
                        });
                });

            modelBuilder.Entity("EgyVoyageApi.Entities.UserImage", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<int>("UserId")
                        .HasColumnType("int");

                    b.Property<string>("image")
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id");

                    b.HasIndex("UserId")
                        .IsUnique();

                    b.ToTable("UserImages");
                });

            modelBuilder.Entity("EgyVoyageApi.Entities.feedback_Hotel", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<int>("HotelId")
                        .HasColumnType("int");

                    b.Property<string>("description")
                        .IsRequired()
                        .HasMaxLength(250)
                        .HasColumnType("nvarchar(250)");

                    b.Property<decimal>("rating")
                        .HasColumnType("decimal(2,1)");

                    b.Property<int>("user_id")
                        .HasColumnType("int");

                    b.HasKey("Id");

                    b.HasIndex("HotelId");

                    b.HasIndex("user_id", "HotelId")
                        .IsUnique();

                    b.ToTable("feedbacks");
                });

            modelBuilder.Entity("EgyVoyageApi.Entities.place", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<string>("Description")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("varchar");

                    b.Property<string>("city")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("cordinate")
                        .IsRequired()
                        .HasMaxLength(50)
                        .HasColumnType("varchar");

                    b.Property<string>("end")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("image")
                        .IsRequired()
                        .HasMaxLength(250)
                        .HasColumnType("varchar");

                    b.Property<int>("pirce")
                        .HasColumnType("int");

                    b.Property<decimal>("rating")
                        .HasColumnType("decimal(2,1)");

                    b.Property<string>("start")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("url_location")
                        .IsRequired()
                        .HasMaxLength(100)
                        .HasColumnType("varchar");

                    b.HasKey("Id");

                    b.ToTable("places");
                });

            modelBuilder.Entity("EgyVoyageApi.Entities.room", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<int>("HotelId")
                        .HasColumnType("int");

                    b.Property<string>("RoomNumber")
                        .IsRequired()
                        .HasMaxLength(255)
                        .HasColumnType("varchar");

                    b.Property<bool>("breakfast")
                        .HasColumnType("bit");

                    b.Property<int>("capacity")
                        .HasColumnType("int");

                    b.Property<string>("category")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<bool>("freeWifi")
                        .HasColumnType("bit");

                    b.Property<string>("image")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<int>("price")
                        .HasColumnType("int");

                    b.Property<bool>("smoking")
                        .HasColumnType("bit");

                    b.HasKey("Id");

                    b.HasIndex("HotelId");

                    b.ToTable("rooms");
                });

            modelBuilder.Entity("Egy_Voyage.Entities.receipt", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<DateTime?>("End")
                        .HasColumnType("datetime2");

                    b.Property<int>("HotelId")
                        .HasColumnType("int");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<DateTime>("Start")
                        .HasColumnType("datetime2");

                    b.Property<string>("email")
                        .IsRequired()
                        .HasMaxLength(128)
                        .HasColumnType("nvarchar(128)");

                    b.Property<string>("pin_code")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<long>("processNumber")
                        .HasColumnType("bigint");

                    b.Property<DateTime>("reservation_date")
                        .HasColumnType("datetime2");

                    b.Property<int>("total_price")
                        .HasMaxLength(9)
                        .HasColumnType("int");

                    b.HasKey("Id");

                    b.HasIndex("HotelId");

                    b.ToTable("receipts");
                });

            modelBuilder.Entity("EgyVoyageApi.Entities.Hotel_Image", b =>
                {
                    b.HasOne("EgyVoyageApi.Entities.Hotel", "hotel")
                        .WithMany("images")
                        .HasForeignKey("Hotelid")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("hotel");
                });

            modelBuilder.Entity("EgyVoyageApi.Entities.Reservation", b =>
                {
                    b.HasOne("EgyVoyageApi.Entities.User", "user")
                        .WithMany("Reservations")
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("Egy_Voyage.Entities.receipt", "receipt")
                        .WithMany("Reservations")
                        .HasForeignKey("receiptId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("EgyVoyageApi.Entities.room", "room")
                        .WithMany("Reservations")
                        .HasForeignKey("roomId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("receipt");

                    b.Navigation("room");

                    b.Navigation("user");
                });

            modelBuilder.Entity("EgyVoyageApi.Entities.UserImage", b =>
                {
                    b.HasOne("EgyVoyageApi.Entities.User", "User")
                        .WithOne("Image")
                        .HasForeignKey("EgyVoyageApi.Entities.UserImage", "UserId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("User");
                });

            modelBuilder.Entity("EgyVoyageApi.Entities.feedback_Hotel", b =>
                {
                    b.HasOne("EgyVoyageApi.Entities.Hotel", "Hotel")
                        .WithMany("feedbacks")
                        .HasForeignKey("HotelId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("EgyVoyageApi.Entities.User", "User")
                        .WithMany("feedbacks")
                        .HasForeignKey("user_id")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Hotel");

                    b.Navigation("User");
                });

            modelBuilder.Entity("EgyVoyageApi.Entities.room", b =>
                {
                    b.HasOne("EgyVoyageApi.Entities.Hotel", "Hotel")
                        .WithMany("rooms")
                        .HasForeignKey("HotelId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Hotel");
                });

            modelBuilder.Entity("Egy_Voyage.Entities.receipt", b =>
                {
                    b.HasOne("EgyVoyageApi.Entities.Hotel", "Hotel")
                        .WithMany("receipts")
                        .HasForeignKey("HotelId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Hotel");
                });

            modelBuilder.Entity("EgyVoyageApi.Entities.Hotel", b =>
                {
                    b.Navigation("feedbacks");

                    b.Navigation("images");

                    b.Navigation("receipts");

                    b.Navigation("rooms");
                });

            modelBuilder.Entity("EgyVoyageApi.Entities.User", b =>
                {
                    b.Navigation("Image")
                        .IsRequired();

                    b.Navigation("Reservations");

                    b.Navigation("feedbacks");
                });

            modelBuilder.Entity("EgyVoyageApi.Entities.room", b =>
                {
                    b.Navigation("Reservations");
                });

            modelBuilder.Entity("Egy_Voyage.Entities.receipt", b =>
                {
                    b.Navigation("Reservations");
                });
#pragma warning restore 612, 618
        }
    }
}