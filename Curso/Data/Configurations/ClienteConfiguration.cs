using CursoEFCore.Domain;
using Microsoft.EntityFrameworkCore;

namespace CursoEFCore.Data.Configurations
{
    // A interface IEntityTypeConfiguration permite a configuração do modelo através da sua implementação
    public class ClienteConfiguration : IEntityTypeConfiguration<Cliente>
    {
        public void Configure(Microsoft.EntityFrameworkCore.Metadata.Builders.EntityTypeBuilder<Cliente> builder)
        {
            builder.ToTable("Clientes");
            builder.HasKey(p => p.Id);

            // Definição explicita do tipo caso seja necessário.
            builder.Property(p => p.Nome).HasColumnType("VARCHAR(80)").IsRequired();
            builder.Property(p => p.Telefone).HasColumnType("CHAR(11)");
            builder.Property(p => p.CEP).HasColumnType("CHAR(8)").IsRequired();
            builder.Property(p => p.Estado).HasColumnType("CHAR(2)").IsRequired();

            // Definição de tamanho máximo sem definição explicita do tipo.
            builder.Property(p => p.Estado).HasMaxLength(60).IsRequired();

            // Índice para otimizar buscas em campos que são muito utilizados para esse fim.
            builder.Property(i => i.Telefone).HasColumnName("idx_cliente_telefone");
        }
    }
}