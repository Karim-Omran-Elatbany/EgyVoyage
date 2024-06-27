using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Egy_Voyage.Migrations
{
    /// <inheritdoc />
    public partial class feedback3 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "IX_feedbacks_user_id",
                table: "feedbacks");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateIndex(
                name: "IX_feedbacks_user_id",
                table: "feedbacks",
                column: "user_id",
                unique: true);
        }
    }
}
