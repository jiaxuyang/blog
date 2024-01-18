---
title: "Postgres跨数据库Join查询"
date: 2024-01-18T20:30:00+08:00
---

1.添加 postgres_fdw 扩展
postgres_fdw: postgres foreign data wrapper

CREATE EXTENSION postgres_fdw;

2.创建server

CREATE SERVER example_server_name FOREIGN DATA WRAPPER postgres_fdw OPTIONS (host 'localhost', dbname 'dbname', port '5432');
3.创建user mapping

CREATE USER MAPPING FOR example_user_name SERVER example_server_name OPTIONS (user '', password '');
4.引入外部表

IMPORT FOREIGN SCHEMA public LIMIT TO (example_table_name) FROM SERVER example_server_name INTO public;
