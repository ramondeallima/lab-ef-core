IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20210914010848_Initial')
BEGIN
    CREATE TABLE [Clientes] (
        [Id] int NOT NULL IDENTITY,
        [Nome] VARCHAR(80) NOT NULL,
        [idx_cliente_telefone] CHAR(11) NULL,
        [CEP] CHAR(8) NOT NULL,
        [Estado] CHAR(2) NOT NULL,
        [Cidade] nvarchar(max) NULL,
        CONSTRAINT [PK_Clientes] PRIMARY KEY ([Id])
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20210914010848_Initial')
BEGIN
    CREATE TABLE [Produtos] (
        [Id] int NOT NULL IDENTITY,
        [CodigoBarras] VARCHAR(14) NOT NULL,
        [Descricao] VARCHAR(60) NULL,
        [Valor] decimal(18,2) NOT NULL,
        [TipoProduto] nvarchar(max) NOT NULL,
        [Ativo] bit NOT NULL,
        CONSTRAINT [PK_Produtos] PRIMARY KEY ([Id])
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20210914010848_Initial')
BEGIN
    CREATE TABLE [Pedidos] (
        [Id] int NOT NULL IDENTITY,
        [ClienteId] int NOT NULL,
        [IniciadoEm] datetime2 NOT NULL,
        [FinalizadoEm] datetime2 NOT NULL,
        [TipoFrete] int NOT NULL,
        [StatusPedido] nvarchar(max) NOT NULL,
        [Observacao] VARCHAR(512) NULL,
        CONSTRAINT [PK_Pedidos] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Pedidos_Clientes_ClienteId] FOREIGN KEY ([ClienteId]) REFERENCES [Clientes] ([Id]) ON DELETE CASCADE
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20210914010848_Initial')
BEGIN
    CREATE TABLE [PedidoItens] (
        [Id] int NOT NULL IDENTITY,
        [PedidoId] int NOT NULL,
        [ProdutoId] int NOT NULL,
        [Quantidade] int NOT NULL DEFAULT 1,
        [Valor] decimal(18,2) NOT NULL,
        [Desconto] int NOT NULL,
        CONSTRAINT [PK_PedidoItens] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_PedidoItens_Pedidos_PedidoId] FOREIGN KEY ([PedidoId]) REFERENCES [Pedidos] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_PedidoItens_Produtos_ProdutoId] FOREIGN KEY ([ProdutoId]) REFERENCES [Produtos] ([Id]) ON DELETE CASCADE
    );
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20210914010848_Initial')
BEGIN
    CREATE INDEX [IX_PedidoItens_PedidoId] ON [PedidoItens] ([PedidoId]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20210914010848_Initial')
BEGIN
    CREATE INDEX [IX_PedidoItens_ProdutoId] ON [PedidoItens] ([ProdutoId]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20210914010848_Initial')
BEGIN
    CREATE INDEX [IX_Pedidos_ClienteId] ON [Pedidos] ([ClienteId]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20210914010848_Initial')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20210914010848_Initial', N'3.1.5');
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20210914021445_AjusteIndiceTelefone')
BEGIN
    EXEC sp_rename N'[Clientes].[idx_cliente_telefone]', N'Contato', N'COLUMN';
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20210914021445_AjusteIndiceTelefone')
BEGIN
    DECLARE @var0 sysname;
    SELECT @var0 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Pedidos]') AND [c].[name] = N'IniciadoEm');
    IF @var0 IS NOT NULL EXEC(N'ALTER TABLE [Pedidos] DROP CONSTRAINT [' + @var0 + '];');
    ALTER TABLE [Pedidos] ALTER COLUMN [IniciadoEm] datetime2 NOT NULL;
    ALTER TABLE [Pedidos] ADD DEFAULT (GETDATE()) FOR [IniciadoEm];
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20210914021445_AjusteIndiceTelefone')
BEGIN
    CREATE INDEX [idx_cliente_telefone] ON [Clientes] ([Contato]);
END;

GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20210914021445_AjusteIndiceTelefone')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20210914021445_AjusteIndiceTelefone', N'3.1.5');
END;

GO

