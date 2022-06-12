using Microsoft.EntityFrameworkCore.Migrations;

namespace KaficiProjekat.DataAccess.Migrations
{
    public partial class third : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "CafeProductOrderId",
                table: "Orders");

            migrationBuilder.DropColumn(
                name: "CafeProductOrderId",
                table: "CafeProducts");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "CafeProductOrderId",
                table: "Orders",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<int>(
                name: "CafeProductOrderId",
                table: "CafeProducts",
                type: "int",
                nullable: false,
                defaultValue: 0);
        }
    }
}
