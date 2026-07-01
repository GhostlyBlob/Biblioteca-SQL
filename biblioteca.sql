CREATE TABLE login (
    id  BIGSERIAL PRIMARY KEY,
    email    VARCHAR(250) NOT NULL UNIQUE,
    senha   VARCHAR(250) NOT NULL,
    nivel_acesso   INT NOT NULL CHECK (nivel_acesso >= 0 AND nivel_acesso <= 2)
)

CREATE TABLE clientes (
    id  BIGSERIAL   PRIMARY KEY,
    nome    VARCHAR(200)    NOT NULL,
    cpf     CHAR(11)    NOT NULL UNIQUE,
    telefone    VARCHAR(15),
    email   VARCHAR(250),
    endereco    VARCHAR(250),
    nascimento      DATE    NOT NULL
);

CREATE TABLE editoras (
    id  BIGSERIAL   PRIMARY KEY,
    nome    VARCHAR(250)    NOT NULL,
    pais    VARCHAR(200)    NOT NULL,
    email VARCHAR(250),
    telefone    VARCHAR(15),
    website     VARCHAR(250)
);

CREATE TABLE generos (
    id  BIGSERIAL   PRIMARY KEY,
    nome VARCHAR(250)   NOT NULL UNIQUE
);

CREATE TABLE autores (
    id  BIGSERIAL   PRIMARY KEY,
    nome    VARCHAR(250)    NOT NULL,
    nascimento  DATE,
    nacionalidade   VARCHAR(250)
);

CREATE TABLE livros (
    id  BIGSERIAL   PRIMARY KEY,
    nome    VARCHAR(250)    NOT NULL,
    ano_de_publicacao   INT,
    id_editora  BIGINT  REFERENCES editoras(id),
    id_genero   BIGINT  REFERENCES generos(id),
    id_autor    BIGINT  REFERENCES  autores(id)
);

CREATE TABLE exemplares (
    id  BIGSERIAL   PRIMARY KEY,
    id_livro    BIGINT NOT NULL REFERENCES livros(id),
    status VARCHAR(50)  DEFAULT 'Disponível'
);

CREATE TABLE emprestimos (
    id  BIGSERIAL   PRIMARY KEY,
    id_cliente  BIGINT NOT NULL REFERENCES clientes(id),
    id_exemplar BIGINT NOT NULL REFERENCES exemplares(id),
    data_emprestimo DATE NOT NULL DEFAULT CURRENT_DATE,
    data_devolucao_prevista DATE NOT NULL,
    data_devolucao_feita    DATE
);

CREATE TABLE multas (
    id  BIGSERIAL PRIMARY KEY,
    id_emprestimo   BIGINT NOT NULL REFERENCES emprestimos(id),
    valor   DECIMAL(10,2)   NOT NULL CHECK (valor >= 0),
    paga    BOOLEAN DEFAULT FALSE
);