CREATE DATABASE IF NOT EXISTS tasks_symfony;
USE tasks_symfony;

CREATE TABLE IF NOT EXISTS users(
id                  int(255) auto_increment not null,
role                varchar(50),
name                varchar(100),
surname             varchar(200),
email               varchar(255),
password            varchar(255),
created_at          datetime,
CONSTRAINT pk_users PRIMARY KEY(id)
)ENGINE=InnoDb;

INSERT INTO users VALUES(NULL, 'ROLE_USER', 'Darío','Chiappello','dariochiappello@gmail.com', 'password', CURTIME());
INSERT INTO users VALUES(NULL, 'ROLE_USER', 'Juan','Gonzalez','juan@juan.com', 'password', CURTIME());
INSERT INTO users VALUES(NULL, 'ROLE_USER', 'Victor','Sanchez','victor@victor.com', 'password', CURTIME());

CREATE TABLE IF NOT EXISTS tasks(
id                  int(255) auto_increment not null,
user_id             int(255) not null,
title               varchar(255),
content             text,
priority            varchar(20),
hours               int(100),
created_at          datetime,
CONSTRAINT pk_tasks PRIMARY KEY(id),
CONSTRAINT fk_task_user FOREIGN KEY(user_id) REFERENCES users(id)
)ENGINE=InnoDb;

INSERT INTO tasks VALUES(NULL, 1, 'Tarea1','Contenido de prueba 1','high', 40, CURTIME());
INSERT INTO tasks VALUES(NULL, 1, 'Tarea2','Contenido de prueba 2','low', 20, CURTIME());
INSERT INTO tasks VALUES(NULL, 2, 'Tarea3','Contenido de prueba 3','medium', 30, CURTIME());
INSERT INTO tasks VALUES(NULL, 3, 'Tarea4','Contenido de prueba 4','high', 40, CURTIME());
