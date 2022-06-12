using Microsoft.EntityFrameworkCore.Migrations;

namespace KaficiProjekat.DataAccess.Migrations
{
    public partial class bezDiskriminatora : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "KafeId",
                table: "Users");

            migrationBuilder.DropColumn(
                name: "Uloga",
                table: "Users");

            migrationBuilder.AddColumn<bool>(
                name: "IsSuperUser",
                table: "Users",
                type: "bit",
                nullable: false,
                defaultValue: false);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "IsSuperUser",
                table: "Users");

            migrationBuilder.AddColumn<int>(
                name: "KafeId",
                table: "Users",
                type: "int",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Uloga",
                table: "Users",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");
        }
    }
}
