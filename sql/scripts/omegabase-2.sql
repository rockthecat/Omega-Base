
update configuration set db_version = 2;

create index access_log_idx2 on access_log(table_id);

create index access_log_idx3 on access_log("date");

create index access_log_idx4 on access_log("user");

create index document_idx2 on "document"("name");

create index document_idx3 on "document"(id_owner);

create index editor_idx2 on editor(id_group);

drop table "object";

drop table embedded;

alter table access_log set (autovacuum_enabled=true);

alter table category set (autovacuum_enabled=true);

alter table configuration set (autovacuum_enabled=true);

alter table "document" set (autovacuum_enabled=true);

alter table "editor" set (autovacuum_enabled=true);

alter table file_blob set (autovacuum_enabled=true);

alter table "group" set (autovacuum_enabled=true);

alter table group_category set (autovacuum_enabled=true);


create table group_master (
id_slave integer,
id_master integer,

constraint group_masterpk primary key(id_slave, id_master),
constraint group_masterfk1 foreign key(id_slave) references "group" (id),
constraint group_masterfk2 foreign key(id_master) references "group" (id)

) with (autovacuum_enabled=true);


alter table access_log add column extra xml;


