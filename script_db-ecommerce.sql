-- Criação do banco de dados
CREATE DATABASE EcommerceDB;
USE EcommerceDB;

-- Tabela Usuário
CREATE TABLE tblUsuario (
    idUsuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    endereco VARCHAR(255),
    telefone VARCHAR(15),
    dataCriacaoConta DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Tabela Categoria
CREATE TABLE tblCategoria (
    idCategoria INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

-- Tabela Produto
CREATE TABLE tblProduto (
    idProduto INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10, 2) NOT NULL,
    qtdeEstoque INT NOT NULL,
    idCategoria INT,
    imagem VARCHAR(255),
    FOREIGN KEY (idCategoria) REFERENCES tblCategoria(idCategoria)
);

-- Tabela Carrinho de Compras
CREATE TABLE tblCarrinhoCompras (
    idCarrinhoCompras INT AUTO_INCREMENT PRIMARY KEY,
    idUsuario INT,
    dataCriacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (idUsuario) REFERENCES tblUsuario(idUsuario)
);

-- Tabela Item do Carrinho
CREATE TABLE tblItemCarrinho (
    idItemCarrinho INT AUTO_INCREMENT PRIMARY KEY,
    idCarrinhoCompras INT,
    idProduto INT,
    qtde INT NOT NULL,
    precoUnitario DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (idCarrinhoCompras) REFERENCES tblCarrinhoCompras(idCarrinhoCompras),
    FOREIGN KEY (idProduto) REFERENCES tblProduto(idProduto)
);

-- Tabela Pedido
CREATE TABLE tblPedido (
    idPedido INT AUTO_INCREMENT PRIMARY KEY,
    idUsuario INT,
    dataPedido DATETIME DEFAULT CURRENT_TIMESTAMP,
    statusPedido VARCHAR(50) NOT NULL,
    valorTotal DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (idUsuario) REFERENCES tblUsuario(idUsuario)
);

-- Tabela Item do Pedido
CREATE TABLE tblItemPedido (
    idItemPedido INT AUTO_INCREMENT PRIMARY KEY,
    idPedido INT,
    idProduto INT,
    qtde INT NOT NULL,
    precoUnitario DECIMAL(10, 2) NOT NULL,
    totalItem DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (idPedido) REFERENCES tblPedido(idPedido),
    FOREIGN KEY (idProduto) REFERENCES tblProduto(idProduto)
);

-- Tabela Pagamento
CREATE TABLE tblPagamento (
    idPagamento INT AUTO_INCREMENT PRIMARY KEY,
    idPedido INT,
    tipoPagamento VARCHAR(50) NOT NULL,
    statusPagamento VARCHAR(50) NOT NULL,
    dataPagamento DATETIME DEFAULT CURRENT_TIMESTAMP,
    valorPago DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (idPedido) REFERENCES tblPedido(idPedido)
);

-- Tabela Endereço de Entrega
CREATE TABLE tblEnderecoEntrega (
    idEndereco INT AUTO_INCREMENT PRIMARY KEY,
    idUsuario INT,
    rua VARCHAR(255) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    estado VARCHAR(100) NOT NULL,
    cep VARCHAR(20) NOT NULL,
    pais VARCHAR(100) NOT NULL,
    FOREIGN KEY (idUsuario) REFERENCES tblUsuario(idUsuario)
);

-- Tabela Avaliação do Produto
CREATE TABLE tblAvaliacaoProduto (
    idAvaliacao INT AUTO_INCREMENT PRIMARY KEY,
    idProduto INT,
    idUsuario INT,
    avaliacao INT CHECK (Avaliacao BETWEEN 1 AND 5),
    comentario TEXT,
    dataAvaliacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (idProduto) REFERENCES tblProduto(idProduto),
    FOREIGN KEY (idUsuario) REFERENCES tblUsuario(idUsuario)
);
