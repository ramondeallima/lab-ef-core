using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace CursoEFCore.Migrations
{
    public partial class AjusteIndiceTelefone : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "idx_cliente_telefone",
                table: "Clientes",
                newName: "Contato");

            migrationBuilder.AlterColumn<DateTime>(
                name: "IniciadoEm",
                table: "Pedidos",
                nullable: false,
                defaultValueSql: "GETDATE()",
                oldClrType: typeof(DateTime),
                oldType: "datetime2");

            migrationBuilder.CreateIndex(
                name: "idx_cliente_telefone",
                table: "Clientes",
                column: "Contato");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "idx_cliente_telefone",
                table: "Clientes");

            migrationBuilder.RenameColumn(
                name: "Contato",
                table: "Clientes",
                newName: "idx_cliente_telefone");

            migrationBuilder.AlterColumn<DateTime>(
                name: "IniciadoEm",
                table: "Pedidos",
                type: "datetime2",
                nullable: false,
                oldClrType: typeof(DateTime),
                oldDefaultValueSql: "GETDATE()");
        }
    }
}
