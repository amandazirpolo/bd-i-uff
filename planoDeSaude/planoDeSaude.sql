drop schema if exists amanda_zirpolo cascade;
create schema amanda_zirpolo;

-- tabelas das entidades 

drop table if exists amanda_zirpolo.planoDeSaude;
create table amanda_zirpolo.planoDeSaude(
	sigla varchar(10) not null,
	primary key (sigla)
);

drop table if exists amanda_zirpolo.contrato;
create table amanda_zirpolo.contrato(
	numero int not null,
	vigencia varchar (10) not null,
	dataContrato varchar(12) not null,
	sigla varchar(10) not null, 
	primary key (numero),
	foreign key (sigla) references amanda_zirpolo.planoDeSaude (sigla)
);

drop table if exists amanda_zirpolo.cliente;
create table amanda_zirpolo.cliente(
	cpf varchar (14) not null,
	nome varchar (50) not null,
	endereco varchar (100) not null,
	primary key (cpf)
);

drop table if exists amanda_zirpolo.credenciado;
create table amanda_zirpolo.credenciado(
	cnpj varchar (20) not null,
	nome varchar (50) not null,
	primary key (cnpj)
);

drop table if exists amanda_zirpolo.procedimento;
create table amanda_zirpolo.procedimento(
	codigo int not null,
	descricao varchar(100) not null,
	primary key (codigo)
);

-- tabelas dos relacionamentos

drop table if exists amanda_zirpolo.participa;
create table amanda_zirpolo.participa(
	numero int not null, 
	cpf varchar(14) not null,
	papel varchar (50) not null,
	primary key(numero, cpf),
	foreign key (numero) references amanda_zirpolo.contrato (numero),
	foreign key (cpf) references amanda_zirpolo.cliente (cpf)
);

drop table if exists amanda_zirpolo.cobranca;
create table amanda_zirpolo.cobranca(
	-- atributos de cobrança
	dataCobranca varchar(12) not null,
	quantidade int not null,
	-- identificadores de participa
	cpf varchar(14) not null,
	numero int not null,
	-- identificadores de procedimento
	codigo int not null,
	-- identificadores de credenciado
	cnpj varchar(20) not null,
	primary key (dataCobranca, cpf, numero, codigo, cnpj),
	foreign key (cpf) references amanda_zirpolo.cliente (cpf),
	foreign key (numero) references amanda_zirpolo.contrato (numero),
	foreign key (codigo) references amanda_zirpolo.procedimento (codigo)
);

drop table if exists amanda_zirpolo.cobre;
create table amanda_zirpolo.cobre(
	sigla varchar (10) not null,
	codigo int not null,
	quantidade int not null,
	primary key(sigla, codigo),
	foreign key (sigla) references amanda_zirpolo.planoDeSaude (sigla),
	foreign key (codigo) references amanda_zirpolo.procedimento (codigo)
);
	
drop table if exists amanda_zirpolo.realiza;
create table amanda_zirpolo.realiza(
	cnpj varchar(20) not null,
	codigo int not null,
	primary key (cnpj, codigo),
	foreign key (cnpj) references amanda_zirpolo.credenciado (cnpj),
	foreign key (codigo) references amanda_zirpolo.procedimento (codigo)
);

-- inserções de dados nas tabelas
-- insert into amanda_zirpolo.PlanoDeSaude (sigla) values ("a"), ("aa"), ("aaa", "a")
-- insert into amanda_zirpolo.PlanoDeSaude (sigla) select sigla WHERE sigla = 'a';