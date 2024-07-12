CREATE DATABASE Euro2024;

USE Euro2024;
CREATE TABLE Pais (
    pkPais SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE Cidade (
    pkCidade SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    fkPais INT,
    FOREIGN KEY (fkPais) REFERENCES Pais(pkPais)
);

CREATE TABLE Estadio (
    pkEstadio SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    fkCidade INT,
    FOREIGN KEY (fkCidade) REFERENCES Cidade(pkCidade)
);

CREATE TABLE Calendario (
    pkCalendario SERIAL PRIMARY KEY,
    data DATE NOT NULL,
    fase VARCHAR(50),
    fkEstadio INT,
    FOREIGN KEY (fkEstadio) REFERENCES Estadio(pkEstadio)
);

CREATE TABLE Selecao (
    pkSelecao SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    fkPais INT,
    FOREIGN KEY (fkPais) REFERENCES Pais(pkPais)
);

CREATE TABLE Grupo (
    pkGrupo SERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL
);

CREATE TABLE GrupoSelecao (
    fkGrupo INT,
    fkSelecao INT,
    PRIMARY KEY (fkGrupo, fkSelecao),
    FOREIGN KEY (fkGrupo) REFERENCES Grupo(pkGrupo),
    FOREIGN KEY (fkSelecao) REFERENCES Selecao(pkSelecao)
);

CREATE TABLE Jogo (
    pkJogo SERIAL PRIMARY KEY,
    data DATE,
    fkGrupo INT,
    fkEstadio INT,
    fkSelecao1 INT,
    fkSelecao2 INT,
    resultado VARCHAR(10),
    FOREIGN KEY (fkGrupo) REFERENCES Grupo(pkGrupo),
    FOREIGN KEY (fkEstadio) REFERENCES Estadio(pkEstadio),
    FOREIGN KEY (fkSelecao1) REFERENCES Selecao(pkSelecao),
    FOREIGN KEY (fkSelecao2) REFERENCES Selecao(pkSelecao)
);


CREATE TABLE EstatisticaGlobal (
    pkEstatisticaGlobal SERIAL PRIMARY KEY,
    fkJogo INT,
    fkSelecao INT,
    remates INT,
    livres INT,
    foras_de_jogo INT,
    FOREIGN KEY (fkJogo) REFERENCES Jogo(pkJogo),
    FOREIGN KEY (fkSelecao) REFERENCES Selecao(pkSelecao)
);

CREATE TABLE Jogador (
    pkJogador SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    data_nascimento DATE DEFAULT CURRENT_DATE, -- Definindo o valor padrão como a data atual
    posicao VARCHAR(50),
    fkSelecao INT,
    FOREIGN KEY (fkSelecao) REFERENCES Selecao(pkSelecao) ON DELETE CASCADE
);

CREATE TABLE Golo (
    pkGolo SERIAL PRIMARY KEY,
    fkJogo INT,
    minuto INT,
    fkJogador INT,
    tipo VARCHAR(50),
    numgolo INT,
    FOREIGN KEY (fkJogo) REFERENCES Jogo(pkJogo) ON DELETE CASCADE,
    FOREIGN KEY (fkJogador) REFERENCES Jogador(pkJogador) ON DELETE CASCADE
);
CREATE TABLE Substituicao (
    pkSubstituicao SERIAL PRIMARY KEY,
    fkJogo INT,
    minuto INT,
    fkJogadorSai INT,
    fkJogadorEntra INT,
    FOREIGN KEY (fkJogo) REFERENCES Jogo(pkJogo) ON DELETE CASCADE,
    FOREIGN KEY (fkJogadorSai) REFERENCES Jogador(pkJogador) ON DELETE CASCADE,
    FOREIGN KEY (fkJogadorEntra) REFERENCES Jogador(pkJogador) ON DELETE CASCADE
);

CREATE TABLE Cartao (
    pkCartao SERIAL PRIMARY KEY,
    fkJogo INT,
    minuto INT,
    fkJogador INT,
    tipo VARCHAR(10),
    FOREIGN KEY (fkJogo) REFERENCES Jogo(pkJogo) ON DELETE CASCADE,
    FOREIGN KEY (fkJogador) REFERENCES Jogador(pkJogador) ON DELETE CASCADE
);

CREATE TABLE EstatisticaIndividual (
    pkEstatisticaIndividual SERIAL PRIMARY KEY,
    fkJogo INT,
    fkJogador INT,
    passes INT,
    assistencias INT,
    remates INT,
    minutos_jogados INT,
    FOREIGN KEY (fkJogo) REFERENCES Jogo(pkJogo) ON DELETE CASCADE,
    FOREIGN KEY (fkJogador) REFERENCES Jogador(pkJogador) ON DELETE CASCADE
);

-- Inserção dos países europeus
INSERT INTO Pais (nome) VALUES
('Albânia'),
('Andorra'),
('Armênia'),
('Áustria'),
('Azerbaijão'),
('Bielorrússia'),
('Bélgica'),
('Bósnia e Herzegovina'),
('Bulgária'),
('Croácia'),
('Chipre'),
('República Tcheca'),
('Dinamarca'),
('Estônia'),
('Finlândia'),
('França'),
('Geórgia'),
('Alemanha'),
('Grécia'),
('Hungria'),
('Islândia'),
('Irlanda'),
('Itália'),
('Cazaquistão'),
('Kosovo'),
('Letônia'),
('Liechtenstein'),
('Lituânia'),
('Luxemburgo'),
('Malta'),
('Moldávia'),
('Mônaco'),
('Montenegro'),
('Países Baixos'),
('Macedônia do Norte'),
('Noruega'),
('Polônia'),
('Portugal'),
('Romênia'),
('Rússia'),
('San Marino'),
('Sérvia'),
('Eslováquia'),
('Eslovênia'),
('Espanha'),
('Suécia'),
('Suíça'),
('Turquia'),
('Ucrânia'),
('Reino Unido'),
('Vaticano');
-- Insere registros na tabela Grupo
INSERT INTO Grupo (nome) VALUES ('Grupo A');
INSERT INTO Grupo (nome) VALUES ('Grupo B');
INSERT INTO Grupo (nome) VALUES ('Grupo C');
INSERT INTO Grupo (nome) VALUES ('Grupo D');
INSERT INTO Grupo (nome) VALUES ('Grupo E');
INSERT INTO Grupo (nome) VALUES ('Grupo F');


INSERT INTO Cidade (nome, fkPais) VALUES ('Lisboa', 1);
INSERT INTO Cidade (nome, fkPais) VALUES ('Paris', 2);
INSERT INTO Cidade (nome, fkPais) VALUES ('Berlim', 3);

-- Inserir alguns estádios com referência às cidades
INSERT INTO Estadio (nome, fkCidade) VALUES ('Estádio da Luz', 1);
INSERT INTO Estadio (nome, fkCidade) VALUES ('Parc des Princes', 2);
INSERT INTO Estadio (nome, fkCidade) VALUES ('Olympiastadion', 3);

