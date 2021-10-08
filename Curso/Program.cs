using System;
using System.Linq;
using Curso.Data;
using Microsoft.EntityFrameworkCore;

namespace CursoEFCore
{
    class Program
    {
        static void Main(string[] args)
        {

            using var db = new ApplicationContext();

            // O Migrate é utilizado para atualizar o banco sempre que a aplicação for executada.
            // OBS: Esse procedimento é recomendado somente para para ambiente local/dev.
            // db.Database.Migrate();


            // Maneira para verificar se existem migrações pendentes.
            // Esse recurso pode ser útil para tratativas em ambientes local.

            var existsUpdates = db.Database.GetPendingMigrations().Any();

            if (existsUpdates)
            {
                
            }

            Console.WriteLine("Hello World!");
        }
    }
}
