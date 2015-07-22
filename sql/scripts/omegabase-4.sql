
update configuration set db_version = 4;

drop index document_idx2;
create index document_idx2_v2 on "document"(name) 
where active = true;


drop index document_idx3;
create index document_idx3_v2 on "document"(id_owner)
where active = true;

drop index editor_idx2;
create index editor_idx2_v2 on editor(id_group)
where active = true;



drop index document_idx;
CREATE INDEX document_idx_v2 ON document USING gin (keywords)
where active = true;



drop index editoridx1;
CREATE INDEX editoridx1_v2 ON editor USING btree (login)
where active = true;


drop index file_blob_idx1;
CREATE INDEX file_blob_idx1_v2 ON file_blob USING btree (id_document)
where active = true;



drop index fki_documentfk1;
CREATE INDEX fki_documentfk1_v2 ON document USING btree (id_category)
where active = true;




