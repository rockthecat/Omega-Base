
update configuration set db_version = 3;

alter table category add column email varchar(10000);

alter table group_category add column can_comment boolean;

create table user_comment (
	id serial,
	msg varchar(10000),
	id_user integer,
	date_comm timestamp,
	id_document integer,
	
	constraint user_commentpk primary key(id),
	constraint user_commentfk1 foreign key(id_user) references editor(id),
	constraint user_commentfk2 foreign key(id_document) references "document"(id)
) with (autovacuum_enabled=true);


create index user_comment_idx1 on user_comment(id_user);
create index user_comment_idx2 on user_comment(id_document);


alter table configuration add column smtp_server varchar(4000);
alter table configuration add column smtp_crypto varchar(10);
alter table configuration add column smtp_port integer;
alter table configuration add column smtp_user varchar(4000);
alter table configuration add column smtp_pass varchar(4000);
alter table file_blob add column modification_date timestamp;
update file_blob set modification_date=now() 
where modification_date is null;
alter table file_blob add column active boolean;

update file_blob set
active = true
where active is null;

alter table configuration add column max_att_size integer;

update configuration set max_att_size = 15;
