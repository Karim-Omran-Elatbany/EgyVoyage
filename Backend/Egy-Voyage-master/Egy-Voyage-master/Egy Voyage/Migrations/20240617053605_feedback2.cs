using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Egy_Voyage.Migrations
{
    /// <inheritdoc />
    public partial class feedback2 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "IX_feedbacks_HotelId_user_id",
                table: "feedbacks");

            migrationBuilder.CreateIndex(
                name: "IX_feedbacks_HotelId",
                table: "feedbacks",
                column: "HotelId");

            migrationBuilder.CreateIndex(
                name: "IX_feedbacks_user_id_HotelId",
                table: "feedbacks",
                columns: new[] { "user_id", "HotelId" },
                unique: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "IX_feedbacks_HotelId",
                table: "feedbacks");

            migrationBuilder.DropIndex(
                name: "IX_feedbacks_user_id_HotelId",
                table: "feedbacks");

            migrationBuilder.CreateIndex(
                name: "IX_feedbacks_HotelId_user_id",
                table: "feedbacks",
                columns: new[] { "HotelId", "user_id" },
                unique: true);
        }
    }
}
