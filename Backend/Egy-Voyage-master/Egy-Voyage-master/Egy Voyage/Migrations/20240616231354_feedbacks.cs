using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Egy_Voyage.Migrations
{
    /// <inheritdoc />
    public partial class feedbacks : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "IX_feedbacks_HotelId",
                table: "feedbacks");

            migrationBuilder.AddColumn<int>(
                name: "user_id",
                table: "feedbacks",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.CreateIndex(
                name: "IX_feedbacks_HotelId_user_id",
                table: "feedbacks",
                columns: new[] { "HotelId", "user_id" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_feedbacks_user_id",
                table: "feedbacks",
                column: "user_id",
                unique: true);

            migrationBuilder.AddForeignKey(
                name: "FK_feedbacks_users_user_id",
                table: "feedbacks",
                column: "user_id",
                principalTable: "users",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_feedbacks_users_user_id",
                table: "feedbacks");

            migrationBuilder.DropIndex(
                name: "IX_feedbacks_HotelId_user_id",
                table: "feedbacks");

            migrationBuilder.DropIndex(
                name: "IX_feedbacks_user_id",
                table: "feedbacks");

            migrationBuilder.DropColumn(
                name: "user_id",
                table: "feedbacks");

            migrationBuilder.CreateIndex(
                name: "IX_feedbacks_HotelId",
                table: "feedbacks",
                column: "HotelId");
        }
    }
}
