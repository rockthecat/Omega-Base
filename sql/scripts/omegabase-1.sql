
alter table configuration add column db_version Integer;

update configuration set db_version = 1;
