
update configuration set db_version = 5;

alter table access_log drop column hostname;

drop index document_idx2_v2;

CREATE INDEX document_idx2_v3
   ON "document" (num_accesses DESC NULLS LAST) WHERE active = true;

drop index access_log_idx3;

CREATE INDEX access_log_idx3
  ON access_log
  USING btree
  (date desc nulls last);

alter table user_comment alter msg type text;

alter table "document" drop column keywords;

create index file_blob_idx2 on file_blob using gin(keywords) where keywords is not null and active=true;

create index document_idx4 on "document" using gin(to_tsvector('simple', name||' '||texthtml)) where active = true;


alter table file_blob add column source varchar(4000);

create index file_blob_soure_idx on file_blob(source) where active = true and source is not null;--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: language; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE language (
    lang character varying(10) NOT NULL,
    name character varying(50) NOT NULL,
    value text
);


--
-- Data for Name: language; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO language VALUES ('en', '﻿omega_base', 'Omega Base');
INSERT INTO language VALUES ('en', 'login', 'Log In');
INSERT INTO language VALUES ('en', 'username', 'Username:');
INSERT INTO language VALUES ('en', 'password', 'Password:');
INSERT INTO language VALUES ('en', 'invalid_password', 'Invalid username/password');
INSERT INTO language VALUES ('en', 'users', 'Users');
INSERT INTO language VALUES ('en', 'groups', 'Groups');
INSERT INTO language VALUES ('en', 'logout', 'Log Out');
INSERT INTO language VALUES ('en', 'new_group', 'New Group');
INSERT INTO language VALUES ('en', 'name', 'Name');
INSERT INTO language VALUES ('en', 'group_name', 'Group name:');
INSERT INTO language VALUES ('en', 'save', 'Save');
INSERT INTO language VALUES ('en', 'delete', 'Delete');
INSERT INTO language VALUES ('en', 'slave_groups', 'Can send to groups (slaves)');
INSERT INTO language VALUES ('en', 'published', 'Published');
INSERT INTO language VALUES ('en', 'dsketch', 'Sketchs');
INSERT INTO language VALUES ('en', 'private', 'Privates');
INSERT INTO language VALUES ('en', 'email_comments', 'Email for comments (empty for none):');
INSERT INTO language VALUES ('en', 'email_exceeds_10000', 'Email cannot be bigger than 10000 characters');
INSERT INTO language VALUES ('en', 'can_comment', 'Can send comments');
INSERT INTO language VALUES ('en', 'comments', 'Comments');
INSERT INTO language VALUES ('en', 'add_comment', 'Add comment:');
INSERT INTO language VALUES ('en', 'comment', 'Comment');
INSERT INTO language VALUES ('en', 'max_size_att', 'Attachment maximum size (MB)');
INSERT INTO language VALUES ('en', 'email_send_server', 'Servidor de email');
INSERT INTO language VALUES ('en', 'email_send_port', 'Porta');
INSERT INTO language VALUES ('en', 'email_send_tls', 'TLS');
INSERT INTO language VALUES ('en', 'email_send_ssl', 'SSL');
INSERT INTO language VALUES ('en', 'email_send_nocrypt', 'Sem criptgrafia');
INSERT INTO language VALUES ('en', 'email_send_user', 'User (empty for "no authentication")');
INSERT INTO language VALUES ('en', 'email_send_pass', 'Senha');
INSERT INTO language VALUES ('en', 'filename', 'Name');
INSERT INTO language VALUES ('en', 'filedate', 'Modification date');
INSERT INTO language VALUES ('en', 'versioning', 'Versioning');
INSERT INTO language VALUES ('en', 'selected', 'Sel.');
INSERT INTO language VALUES ('en', 'del_selected', 'Delete selected');
INSERT INTO language VALUES ('en', 'ask_delete_docs', 'Delete selected documents?');
INSERT INTO language VALUES ('en', 'syncro', 'Import ZIP file');
INSERT INTO language VALUES ('en', 'syncro_text1', 'You can synchronize a whole directory with Omega Syncro just putting it in a ZIP file and uploading it!');
INSERT INTO language VALUES ('en', 'syncro_text2', 'Documents which have already this file as attachment will be pulled from the import, older files will be updated. Omega Syncro checks its modification date and file name');
INSERT INTO language VALUES ('en', 'zipfile', 'ZIP file');
INSERT INTO language VALUES ('en', 'can_modify_documents', 'Can modify documents');
INSERT INTO language VALUES ('en', 'can_modify_documents_groups', 'Can modify documents of other groups');
INSERT INTO language VALUES ('en', 'can_administrate_users', 'Can modify users');
INSERT INTO language VALUES ('en', 'can_see_documents_groups', 'Can see documents of other groups');
INSERT INTO language VALUES ('en', 'can_validate', 'Can validate documents');
INSERT INTO language VALUES ('en', 'login_exceeds_128', 'Login name cannot have more than 128 characters');
INSERT INTO language VALUES ('en', 'name_exceeds_200', 'Name cannot have more than 200 characters');
INSERT INTO language VALUES ('en', 'name_isempty', 'Name cannot be empty');
INSERT INTO language VALUES ('en', 'group_inserted', 'Group inserted with success');
INSERT INTO language VALUES ('en', 'group_updated', 'Group updated with success');
INSERT INTO language VALUES ('en', 'group_deleted', 'Group deleted with success');
INSERT INTO language VALUES ('en', 'ask_delete_user', 'Do you really wish to delete this user?');
INSERT INTO language VALUES ('en', 'select_group', 'Select a group');
INSERT INTO language VALUES ('en', 'new_user', 'New user');
INSERT INTO language VALUES ('en', 'group', 'Group');
INSERT INTO language VALUES ('en', 'new_category', 'New category');
INSERT INTO language VALUES ('en', 'categories', 'Categories');
INSERT INTO language VALUES ('en', 'category', 'Category');
INSERT INTO language VALUES ('en', 'category_name', 'Name:');
INSERT INTO language VALUES ('en', 'name_already_exists', 'This name already exists');
INSERT INTO language VALUES ('en', 'group_nothing', 'No');
INSERT INTO language VALUES ('en', 'group_read', 'Read');
INSERT INTO language VALUES ('en', 'group_read_write', 'Read and write');
INSERT INTO language VALUES ('en', 'group_read_write_val', 'Read, write and validate');
INSERT INTO language VALUES ('en', 'permission_denied', 'Permission denied');
INSERT INTO language VALUES ('en', 'old_password', 'Old password');
INSERT INTO language VALUES ('en', 'new_password', 'New password');
INSERT INTO language VALUES ('en', 'new_password2', 'Re-enter new password');
INSERT INTO language VALUES ('en', 'wrong_password', 'Wrong password');
INSERT INTO language VALUES ('en', 'passwords_not_match', 'Passwords doesn''t match');
INSERT INTO language VALUES ('en', 'change_password', 'Change account');
INSERT INTO language VALUES ('en', 'configuration', 'Configuration');
INSERT INTO language VALUES ('en', 'anon_can_write', 'Anonymous can use');
INSERT INTO language VALUES ('en', 'anon_can_inscribe', 'People can inscribe');
INSERT INTO language VALUES ('en', 'anom_group', 'Anonymous''s group');
INSERT INTO language VALUES ('en', 'anom_inscribe_group', 'People inscribed''s group');
INSERT INTO language VALUES ('en', 'search', 'Search');
INSERT INTO language VALUES ('en', 'search_doc', 'Search document');
INSERT INTO language VALUES ('en', 'ALL', 'ALL');
INSERT INTO language VALUES ('en', 'edit', 'Edit');
INSERT INTO language VALUES ('en', 'back', 'Back');
INSERT INTO language VALUES ('en', 'new_document', 'New document');
INSERT INTO language VALUES ('en', 'richtext', 'Rich text');
INSERT INTO language VALUES ('en', 'view', 'View');
INSERT INTO language VALUES ('en', 'document_exists_category', 'There are documents of this category, cannot delete it');
INSERT INTO language VALUES ('en', 'save_and_publish', 'Save and publish');
INSERT INTO language VALUES ('en', 'copy_to_mydocs', 'Copy to My Documents');
INSERT INTO language VALUES ('en', 'put_as_sketch', 'Publish as sketchs');
INSERT INTO language VALUES ('en', 'sketch', '&nbsp;(Sketch)');
INSERT INTO language VALUES ('en', 'my_documents', 'My Documents');
INSERT INTO language VALUES ('en', 'ask_delete_document', 'Do you really wish to delete this document?');
INSERT INTO language VALUES ('en', 'text_exceeds_8000000', 'Text cannot exceed 8.000.000 characters.');
INSERT INTO language VALUES ('en', 'user', 'User');
INSERT INTO language VALUES ('en', 'date_from', 'Date from');
INSERT INTO language VALUES ('en', 'to', 'to');
INSERT INTO language VALUES ('en', 'date', 'Date');
INSERT INTO language VALUES ('en', 'addr', 'Address');
INSERT INTO language VALUES ('en', 'hostname', 'Host');
INSERT INTO language VALUES ('en', 'action', 'Action');
INSERT INTO language VALUES ('en', 'table', 'Table');
INSERT INTO language VALUES ('en', 'id', 'ID');
INSERT INTO language VALUES ('en', 'accesses', 'Accesses');
INSERT INTO language VALUES ('en', 'ok', 'OK');
INSERT INTO language VALUES ('en', 'attach', 'Attach');
INSERT INTO language VALUES ('en', 'attach_file', 'Attach file:');
INSERT INTO language VALUES ('en', 'attachments', 'Attachments');
INSERT INTO language VALUES ('en', 'ask_delete_attachment', 'Do you really wish to delete this attachment?');
INSERT INTO language VALUES ('en', 'title_delete_image', 'Delete this image');
INSERT INTO language VALUES ('en', 'ask_delete_image', 'Do you really wish to delete this image?');
INSERT INTO language VALUES ('en', 'pdf_odf_indexed', 'Files indexed for search:<ul><li>PDF Files</li><li>MS Office XML: (.DOCX, .PPTX, .XLSX).</li><li>OpenOffice ODF: (.ODT, .ODS, .ODP).</li><li>Freemind: (.MM).</li><li>Dia: (.DIA).</li></ul>');
INSERT INTO language VALUES ('en', 'conf_tomcat', 'Tomcat Configuration');
INSERT INTO language VALUES ('en', 'login_already_exists', 'Login name already exists, use another name');
INSERT INTO language VALUES ('en', 'conf_catalina_home', 'Tomcat base dir');
INSERT INTO language VALUES ('en', 'conf_catalina_engine', 'Catalina engine name (default: Catalina)');
INSERT INTO language VALUES ('en', 'conf_catalina_host', 'Catalina host name (default: localhost)');
INSERT INTO language VALUES ('en', 'conf_postgresql', 'PostgreSQL Database Configuration');
INSERT INTO language VALUES ('en', 'conf_postgresql_host', 'Server host');
INSERT INTO language VALUES ('en', 'ask_delete_group', 'Do you really wish to delete this group and all its users?');
INSERT INTO language VALUES ('en', 'language', 'Language');
INSERT INTO language VALUES ('en', 'conf_postgresql_port', 'Port');
INSERT INTO language VALUES ('en', 'conf_postgresql_superuser', 'Superuser');
INSERT INTO language VALUES ('en', 'conf_postgresql_db', 'Database name');
INSERT INTO language VALUES ('en', 'conf_postgresql_user', 'Db User');
INSERT INTO language VALUES ('en', 'conf_postgresql_pass', 'Db Pass (create)');
INSERT INTO language VALUES ('en', 'conf_postgresql_cons', 'The installer will upgrade an old version of omegabase, if found');
INSERT INTO language VALUES ('en', 'conf_end1', 'This instalator created 2 files. Delete-them if you want to run the installer again.');
INSERT INTO language VALUES ('en', 'conf_end2', 'A user was created in PostgreSQL. It has the password you chose.');
INSERT INTO language VALUES ('en', 'conf_end3', 'Now, restart Tomcat service to begin.');
INSERT INTO language VALUES ('en', 'conf_end4', 'After this, log as user ''administrator'' and password ''changeit''');
INSERT INTO language VALUES ('en', 'historic', 'Historic');
INSERT INTO language VALUES ('en', 'password_blank', 'To keep the same password, leave it in blank');
INSERT INTO language VALUES ('en', 'save_success', 'Saved with success');
INSERT INTO language VALUES ('en', 'your_name', 'Your name:');
INSERT INTO language VALUES ('en', 'email_address', 'Email address:');
INSERT INTO language VALUES ('en', 'server_hostname', 'Server hostname');
INSERT INTO language VALUES ('en', 'port', 'Port');
INSERT INTO language VALUES ('en', 'ssl', 'SSL');
INSERT INTO language VALUES ('en', 'authentication', 'Authentication');
INSERT INTO language VALUES ('en', 'incoming', 'Incoming:');
INSERT INTO language VALUES ('en', 'outcoming', 'Outcoming:');
INSERT INTO language VALUES ('en', 'port_blank', 'Leave it in blank to use the default port');
INSERT INTO language VALUES ('en', 'add_email', 'Add mail account');
INSERT INTO language VALUES ('en', 'remove_email', 'Remove mail account');
INSERT INTO language VALUES ('en', 'port_empty', 'Empty(Default)');
INSERT INTO language VALUES ('pt_BR', '﻿omega_base', 'Base Ômega');
INSERT INTO language VALUES ('pt_BR', 'login', 'Login');
INSERT INTO language VALUES ('pt_BR', 'username', 'Usuário:');
INSERT INTO language VALUES ('pt_BR', 'password', 'Senha:');
INSERT INTO language VALUES ('pt_BR', 'invalid_password', 'Usuário/Senha inválido');
INSERT INTO language VALUES ('pt_BR', 'users', 'Usuários');
INSERT INTO language VALUES ('pt_BR', 'groups', 'Grupos');
INSERT INTO language VALUES ('pt_BR', 'logout', 'Logout');
INSERT INTO language VALUES ('pt_BR', 'new_group', 'Novo Grupo');
INSERT INTO language VALUES ('pt_BR', 'name', 'Nome');
INSERT INTO language VALUES ('pt_BR', 'group_name', 'Nome do grupo:');
INSERT INTO language VALUES ('pt_BR', 'save', 'Salvar');
INSERT INTO language VALUES ('pt_BR', 'delete', 'Deletar');
INSERT INTO language VALUES ('pt_BR', 'slave_groups', 'Pode mandar para os grupos (escravos)');
INSERT INTO language VALUES ('pt_BR', 'published', 'Publicados');
INSERT INTO language VALUES ('pt_BR', 'dsketch', 'Rascunhos');
INSERT INTO language VALUES ('pt_BR', 'private', 'Privados');
INSERT INTO language VALUES ('pt_BR', 'email_comments', 'Email para comentários (vazio para nenhum):');
INSERT INTO language VALUES ('pt_BR', 'email_exceeds_10000', 'Email não pode ser maior que 10000 caracteres');
INSERT INTO language VALUES ('pt_BR', 'can_comment', 'Pode enviar comentários');
INSERT INTO language VALUES ('pt_BR', 'comments', 'Comentários');
INSERT INTO language VALUES ('pt_BR', 'add_comment', 'Adicionar comentário:');
INSERT INTO language VALUES ('pt_BR', 'comment', 'Comentário');
INSERT INTO language VALUES ('pt_BR', 'max_size_att', 'Tamanho máximo de anexos (MB)');
INSERT INTO language VALUES ('pt_BR', 'email_send_server', 'Servidor de email');
INSERT INTO language VALUES ('pt_BR', 'email_send_port', 'Porta');
INSERT INTO language VALUES ('pt_BR', 'email_send_tls', 'TLS');
INSERT INTO language VALUES ('pt_BR', 'email_send_ssl', 'SSL');
INSERT INTO language VALUES ('pt_BR', 'email_send_nocrypt', 'Sem criptgrafia');
INSERT INTO language VALUES ('pt_BR', 'email_send_user', 'Usuário (vazio para "sem autenticação")');
INSERT INTO language VALUES ('pt_BR', 'email_send_pass', 'Senha');
INSERT INTO language VALUES ('pt_BR', 'filename', 'Nome');
INSERT INTO language VALUES ('pt_BR', 'filedate', 'Data modificação');
INSERT INTO language VALUES ('pt_BR', 'versioning', 'Versionamento');
INSERT INTO language VALUES ('pt_BR', 'selected', 'Sel.');
INSERT INTO language VALUES ('pt_BR', 'del_selected', 'Deletar selecionados');
INSERT INTO language VALUES ('pt_BR', 'ask_delete_docs', 'Deletar documentos selecionados?');
INSERT INTO language VALUES ('pt_BR', 'syncro', 'Importar arquivo ZIP');
INSERT INTO language VALUES ('pt_BR', 'syncro_text1', 'Você pode sincronizar um diretório inteiro com Omega Syncro simplesmente colocando em um arquico ZIP e uploadeando!');
INSERT INTO language VALUES ('pt_BR', 'syncro_text2', 'Documentos que já tem este arquivo como anexo vão ser pulados da importação, arquivos com data menor serão atualizados. Omega Syncro checa pela data de modificação e nome de arquivo');
INSERT INTO language VALUES ('pt_BR', 'zipfile', 'Arquivo ZIP');
INSERT INTO language VALUES ('pt_BR', 'can_modify_documents', 'Pode modificar documentos');
INSERT INTO language VALUES ('pt_BR', 'can_modify_documents_groups', 'Pode modificar documentos de outros grupos');
INSERT INTO language VALUES ('pt_BR', 'can_administrate_users', 'Pode administrar usuários');
INSERT INTO language VALUES ('pt_BR', 'can_see_documents_groups', 'Pode ver documentos de outros grupos');
INSERT INTO language VALUES ('pt_BR', 'can_validate', 'Pode validar documentos');
INSERT INTO language VALUES ('pt_BR', 'login_exceeds_128', 'Nome de login não pode ter mais que 128 caracteres');
INSERT INTO language VALUES ('pt_BR', 'name_exceeds_200', 'Nome não pode ter mais que 200 caracteres');
INSERT INTO language VALUES ('pt_BR', 'name_isempty', 'Nome não pode ser vazio');
INSERT INTO language VALUES ('pt_BR', 'group_inserted', 'Grupo inserido com sucesso');
INSERT INTO language VALUES ('pt_BR', 'group_updated', 'Group atualizado com sucesso');
INSERT INTO language VALUES ('pt_BR', 'group_deleted', 'Group deletado com sucesso');
INSERT INTO language VALUES ('pt_BR', 'select_group', 'Selecione um grupo');
INSERT INTO language VALUES ('pt_BR', 'ask_delete_user', 'Você deseja realmente deletar este usuário?');
INSERT INTO language VALUES ('pt_BR', 'new_user', 'Novo usuário');
INSERT INTO language VALUES ('pt_BR', 'group', 'Grupo');
INSERT INTO language VALUES ('pt_BR', 'new_category', 'Nova categoria');
INSERT INTO language VALUES ('pt_BR', 'categories', 'Categorias');
INSERT INTO language VALUES ('pt_BR', 'category', 'Categoria');
INSERT INTO language VALUES ('pt_BR', 'category_name', 'Nome:');
INSERT INTO language VALUES ('pt_BR', 'name_already_exists', 'Este nome já existe');
INSERT INTO language VALUES ('pt_BR', 'group_nothing', 'Nada');
INSERT INTO language VALUES ('pt_BR', 'group_read', 'Ler');
INSERT INTO language VALUES ('pt_BR', 'group_read_write', 'Ler e escrever');
INSERT INTO language VALUES ('pt_BR', 'group_read_write_val', 'Ler escrever e validar');
INSERT INTO language VALUES ('pt_BR', 'permission_denied', 'Permissão negada');
INSERT INTO language VALUES ('pt_BR', 'old_password', 'Senha antiga');
INSERT INTO language VALUES ('pt_BR', 'new_password', 'Senha nova');
INSERT INTO language VALUES ('pt_BR', 'new_password2', 'Re-entrar senha nova');
INSERT INTO language VALUES ('pt_BR', 'wrong_password', 'Senha incorreta');
INSERT INTO language VALUES ('pt_BR', 'passwords_not_match', 'Senhas não coincidem');
INSERT INTO language VALUES ('pt_BR', 'change_password', 'Mudar conta');
INSERT INTO language VALUES ('pt_BR', 'configuration', 'Configuração');
INSERT INTO language VALUES ('pt_BR', 'login_already_exists', 'Nome de login já existe, use outro nome');
INSERT INTO language VALUES ('pt_BR', 'anon_can_write', 'Anônimos pode usar');
INSERT INTO language VALUES ('pt_BR', 'anon_can_inscribe', 'Pessoas podem se inscrever');
INSERT INTO language VALUES ('pt_BR', 'anom_group', 'Grupo de anônimos');
INSERT INTO language VALUES ('pt_BR', 'anom_inscribe_group', 'Grupo das pessoas inscritas');
INSERT INTO language VALUES ('pt_BR', 'search', 'Pesquisar');
INSERT INTO language VALUES ('pt_BR', 'search_doc', 'Pesquisar documento');
INSERT INTO language VALUES ('pt_BR', 'ALL', 'TODOS');
INSERT INTO language VALUES ('pt_BR', 'edit', 'Editar');
INSERT INTO language VALUES ('pt_BR', 'back', 'Voltar');
INSERT INTO language VALUES ('pt_BR', 'new_document', 'Novo documento');
INSERT INTO language VALUES ('pt_BR', 'richtext', 'Rich text');
INSERT INTO language VALUES ('pt_BR', 'view', 'Visualizar');
INSERT INTO language VALUES ('pt_BR', 'view_old', 'Visualizar antigo doc.');
INSERT INTO language VALUES ('pt_BR', 'ask_delete_group', 'Você deseja realmente deletar este grupo e todos os seus usuários?');
INSERT INTO language VALUES ('pt_BR', 'language', 'Língua');
INSERT INTO language VALUES ('pt_BR', 'document_exists_category', 'Existem documentos desta categoria, não é possível deletá-la');
INSERT INTO language VALUES ('pt_BR', 'save_and_publish', 'Salvar e publicar');
INSERT INTO language VALUES ('pt_BR', 'save_and_unpublish', 'Salvar como rascunho');
INSERT INTO language VALUES ('pt_BR', 'copy_to_mydocs', 'Copiar para Meus Documentos');
INSERT INTO language VALUES ('pt_BR', 'put_as_sketch', 'Publicar como Rascunho');
INSERT INTO language VALUES ('pt_BR', 'sketch', '&nbsp;(Rascunho)');
INSERT INTO language VALUES ('pt_BR', 'my_documents', 'Meus Documentos');
INSERT INTO language VALUES ('pt_BR', 'ask_delete_document', 'Você realmente deseja excluir este documento?');
INSERT INTO language VALUES ('pt_BR', 'text_exceeds_8000000', 'Texto não pode ser maior que 8.000.000 caracteres.');
INSERT INTO language VALUES ('pt_BR', 'user', 'Usuário');
INSERT INTO language VALUES ('pt_BR', 'date_from', 'Data de');
INSERT INTO language VALUES ('pt_BR', 'to', 'para');
INSERT INTO language VALUES ('pt_BR', 'date', 'Data');
INSERT INTO language VALUES ('pt_BR', 'addr', 'Endereço');
INSERT INTO language VALUES ('pt_BR', 'hostname', 'Host');
INSERT INTO language VALUES ('pt_BR', 'action', 'Ação');
INSERT INTO language VALUES ('pt_BR', 'table', 'Tabela');
INSERT INTO language VALUES ('pt_BR', 'id', 'ID');
INSERT INTO language VALUES ('pt_BR', 'accesses', 'Acessos');
INSERT INTO language VALUES ('pt_BR', 'ok', 'OK');
INSERT INTO language VALUES ('pt_BR', 'attach', 'Anexar');
INSERT INTO language VALUES ('pt_BR', 'attach_file', 'Anexar arquivo:');
INSERT INTO language VALUES ('pt_BR', 'attachments', 'Anexos');
INSERT INTO language VALUES ('pt_BR', 'ask_delete_attachment', 'Você realmente deseja deletar este anexo?');
INSERT INTO language VALUES ('pt_BR', 'title_delete_image', 'Deletar esta imagem');
INSERT INTO language VALUES ('pt_BR', 'ask_delete_image', 'Você realemente deseja deletar esta imagem?');
INSERT INTO language VALUES ('pt_BR', 'pdf_odf_indexed', 'Arquivos indexados para busca:<ul><li>Arquivos PDF</li><li>MS Office XML: (.DOCX, .PPTX, .XLSX).</li><li>OpenOffice ODF: (.ODT, .ODS, .ODP).</li><li>Freemind: (.MM).</li><li>Dia: (.DIA).</li></ul>');
INSERT INTO language VALUES ('pt_BR', 'conf_tomcat', 'Configuração do Tomcat');
INSERT INTO language VALUES ('pt_BR', 'conf_catalina_home', 'Diretório base do Tomcat');
INSERT INTO language VALUES ('pt_BR', 'conf_catalina_engine', 'Nome da engine do Catalina (default: Catalina)');
INSERT INTO language VALUES ('pt_BR', 'conf_catalina_host', 'Nome do host do Catalina (default: localhost)');
INSERT INTO language VALUES ('pt_BR', 'conf_postgresql', 'Configuração do banco de dados PostgreSQL');
INSERT INTO language VALUES ('pt_BR', 'conf_postgresql_host', 'Host do servidor');
INSERT INTO language VALUES ('pt_BR', 'conf_postgresql_port', 'Porta');
INSERT INTO language VALUES ('pt_BR', 'conf_postgresql_superuser', 'Superusuário');
INSERT INTO language VALUES ('pt_BR', 'conf_postgresql_db', 'Nome da database:');
INSERT INTO language VALUES ('pt_BR', 'conf_postgresql_user', 'Usuário do db');
INSERT INTO language VALUES ('pt_BR', 'conf_postgresql_pass', 'Senha do db(criar)');
INSERT INTO language VALUES ('pt_BR', 'conf_postgresql_cons', 'O instalador vai atualizar uma versão antiga do omegabase, se encontrada');
INSERT INTO language VALUES ('pt_BR', 'conf_end1', 'Este instalador criou 2 arquivos. Delete-os se quiser rodar o instalador de novo.');
INSERT INTO language VALUES ('pt_BR', 'conf_end2', 'Foi criado um usuário no banco PostgreSQL. Ele possui a senha que você criou.');
INSERT INTO language VALUES ('pt_BR', 'conf_end3', 'Agora, reinicie o serviço do Tomcat para começar.');
INSERT INTO language VALUES ('pt_BR', 'conf_end4', 'Depois disso, logue-se como usuário ''administrator'' e senha ''changeit''');
INSERT INTO language VALUES ('pt_BR', 'historic', 'Histórico');
INSERT INTO language VALUES ('pt_BR', 'password_blank', 'Para manter a mesma senha, deixe-a em branco');
INSERT INTO language VALUES ('pt_BR', 'save_success', 'Salvo com sucesso');
INSERT INTO language VALUES ('pt_BR', 'your_name', 'Seu nome:');
INSERT INTO language VALUES ('pt_BR', 'email_address', 'Endereço de email:');
INSERT INTO language VALUES ('pt_BR', 'server_hostname', 'Servidor');
INSERT INTO language VALUES ('pt_BR', 'port', 'Porta');
INSERT INTO language VALUES ('pt_BR', 'ssl', 'SSL');
INSERT INTO language VALUES ('pt_BR', 'authentication', 'Autenticação');
INSERT INTO language VALUES ('pt_BR', 'incoming', 'Entrada:');
INSERT INTO language VALUES ('pt_BR', 'outcoming', 'Saída:');
INSERT INTO language VALUES ('pt_BR', 'port_blank', 'Deixe em branco para a porta default');
INSERT INTO language VALUES ('pt_BR', 'add_email', 'Adicionar e-mail');
INSERT INTO language VALUES ('pt_BR', 'remove_email', 'Remover e-mail');
INSERT INTO language VALUES ('pt_BR', 'port_empty', 'Vazia(Default)');
INSERT INTO language VALUES ('en', 'index', 'Omega Base is an Open Source knowledge base.');
INSERT INTO language VALUES ('pt_BR', 'index', 'Base Ômega é uma Base de Conhecimento de código livre.');
INSERT INTO language VALUES ('en', 'unlogged', 'Unlogged');
INSERT INTO language VALUES ('pt_BR', 'unlogged', 'Deslogado');
INSERT INTO language VALUES ('en', 'do_login', 'Login');
INSERT INTO language VALUES ('pt_BR', 'do_login', 'Fazer login');
INSERT INTO language VALUES ('en', 'lang', 'English');
INSERT INTO language VALUES ('pt_BR', 'lang', 'Português do Brasil');
INSERT INTO language VALUES ('en', 'ask_page_refresh', 'Changes may be lost, do you wish to refresh the page now?');
INSERT INTO language VALUES ('pt_BR', 'ask_page_refresh', 'Mudanças podem ser perdidas, você gostaria de dar refresh na página agora?');
INSERT INTO language VALUES ('en', 'login_isempty', 'Login name cannot be empty');
INSERT INTO language VALUES ('pt_BR', 'login_isempty', 'Nome de login não pode ser nulo');
INSERT INTO language VALUES ('pt_BR', 'new_account_disc', 'Criar nova conta');
INSERT INTO language VALUES ('pt_BR', 'ask_new_user', 'Você deseja criar uma nova conta? Clique aqui');
INSERT INTO language VALUES ('en', 'ask_new_user', 'Do you wish to Create an Account? Click here');
INSERT INTO language VALUES ('pt_BR', 'new_login', 'Novo login:');
INSERT INTO language VALUES ('en', 'new_account_disc', 'Create a new account');
INSERT INTO language VALUES ('en', 'new_login', 'New login:');
INSERT INTO language VALUES ('en', 'password_isempty', 'Password cannot be empty');
INSERT INTO language VALUES ('pt_BR', 'password_isempty', 'Senha não pode ser vazia');
INSERT INTO language VALUES ('en', 'create_account', 'Create account');
INSERT INTO language VALUES ('pt_BR', 'create_account', 'Criar conta');
INSERT INTO language VALUES ('en', 'text_isempty', 'Text cannot be empty');
INSERT INTO language VALUES ('pt_BR', 'text_isempty', 'Texto não pode ser vazio');
INSERT INTO language VALUES ('en', 'save_and_unpublish', 'Save as draft');
INSERT INTO language VALUES ('en', 'select_one', 'Select one');
INSERT INTO language VALUES ('pt_BR', 'select_one', 'Selecione um');
INSERT INTO language VALUES ('en', 'invalid_argument', 'Invalid argument');
INSERT INTO language VALUES ('pt_BR', 'invalid_argument', 'Argumento inválido');
INSERT INTO language VALUES ('en', 'select_one_category', 'Select one category');
INSERT INTO language VALUES ('pt_BR', 'select_one_category', 'Selecione uma categoria');
INSERT INTO language VALUES ('en', 'db', 'Omega Base');
INSERT INTO language VALUES ('pt_BR', 'db', 'Base Ômega');
INSERT INTO language VALUES ('en', 'save_att', 'Save attach');
INSERT INTO language VALUES ('pt_BR', 'save_att', 'Salvar anexo');
INSERT INTO language VALUES ('en', 'del_att', 'Delete attach');
INSERT INTO language VALUES ('pt_BR', 'del_att', 'Deletar anexo');
INSERT INTO language VALUES ('en', 'ask_delete_comment', 'Are you sure to delete this comment?');
INSERT INTO language VALUES ('pt_BR', 'ask_delete_comment', 'Você deseja realmente deletar este comentário?');
INSERT INTO language VALUES ('pt_BR', 'msggoo', 'Procurando por:');
INSERT INTO language VALUES ('en', 'msggoo', 'Searching for:');
INSERT INTO language VALUES ('en', 'data_saved', 'Data saved with success');
INSERT INTO language VALUES ('pt_BR', 'data_saved', 'Dados salvos com sucesso');
INSERT INTO language VALUES ('en', 'date_to', 'Date to:');
INSERT INTO language VALUES ('pt_BR', 'date_to', 'Data até:');
INSERT INTO language VALUES ('en', 'update', 'Update');
INSERT INTO language VALUES ('pt_BR', 'update', 'Atualizar');
INSERT INTO language VALUES ('en', 'tryedit_old', 'Try edit old doc.');
INSERT INTO language VALUES ('en', 'view_old', 'View old doc.');
INSERT INTO language VALUES ('pt_BR', 'tryedit_old', 'Tentar editar antigo doc.');
INSERT INTO language VALUES ('en', 'tryedit', 'Try edit doc.');
INSERT INTO language VALUES ('pt_BR', 'import', 'Importar doc.');
INSERT INTO language VALUES ('en', 'import', 'Import doc.');
INSERT INTO language VALUES ('pt_BR', 'tryedit', 'Tentar editar doc.');
INSERT INTO language VALUES ('pt_BR', 'num_users', 'Usuários ativos');
INSERT INTO language VALUES ('en', 'num_users', 'Active users');
INSERT INTO language VALUES ('en', 'superuser', 'Superuser');
INSERT INTO language VALUES ('pt_BR', 'superuser', 'Superusuário');
INSERT INTO language VALUES ('en', 'administrator', 'Administrator');
INSERT INTO language VALUES ('pt_BR', 'administrator', 'Administrador');
INSERT INTO language VALUES ('pt_BR', 'can_administrate_groups', 'Superusuário');
INSERT INTO language VALUES ('en', 'can_administrate_groups', 'Superuser');
INSERT INTO language VALUES ('en', 'priviledge', 'Priviledge');
INSERT INTO language VALUES ('pt_BR', 'priviledge', 'Privilégio');
INSERT INTO language VALUES ('en', 'priv_read', 'Read');
INSERT INTO language VALUES ('en', 'priv_none', 'None');
INSERT INTO language VALUES ('pt_BR', 'priv_none', 'Nenhum');
INSERT INTO language VALUES ('pt_BR', 'priv_read', 'Ler');
INSERT INTO language VALUES ('en', 'priv_readwrite', 'Read and write');
INSERT INTO language VALUES ('pt_BR', 'priv_readwrite', 'Ler e escrever');
INSERT INTO language VALUES ('en', 'priv_all', 'Full control');
INSERT INTO language VALUES ('pt_BR', 'priv_all', 'Controle total');
INSERT INTO language VALUES ('en', 'ask_delete_category', 'Do you really wish to delete this category and all its documents?');
INSERT INTO language VALUES ('pt_BR', 'ask_delete_category', 'Você deseja realmente deletar esta categoria e todos os seus documentos?');


--
-- Name: language_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY language
    ADD CONSTRAINT language_pkey PRIMARY KEY (lang, name);


--
-- PostgreSQL database dump complete
--

 CREATE  OR  REPLACE  FUNCTION  public.check_attach2(cmp  integer,  pid  integer,  plevel  integer)
  RETURNS  void
  LANGUAGE  plpgsql
  STABLE
AS  $function$
declare        
	iddoc        int;
begin
	if        pid        is        null        or        pid=0        then
		raise        exception        '%|%',        cmp,        get_msg('invalid_argument');
	end        if;

	select        into        iddoc
	id_document        from        file_blob        
	where        id        =        pid        and        active        =        true;

	if        not        found        then
		raise        exception        '%|%',        cmp,        get_msg('invalid_argument');
	end        if;

	perform        check_document(iddoc,        plevel);
end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.check_bool(pval  boolean)
  RETURNS  boolean
  LANGUAGE  plpgsql
  IMMUTABLE
AS  $function$
begin
	if        pval        is        null        then
		pval:=false;
	end        if;

	return        pval;
end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.check_logged()
  RETURNS  void
  LANGUAGE  plpgsql
  STABLE
AS  $function$
begin
	if        not        exists(select        1        from        user_info        where        id        is        not        null        and        id<>0)        then
		raise        exception        '-1|%',        get_msg('access_denied');
	end        if;
end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.check_can_comment(piddoc  integer)
  RETURNS  void
  LANGUAGE  plpgsql
  STABLE
AS  $function$
begin
	perform        check_notnull(-1,        piddoc);
	perform        check_document(piddoc,        1);

	if        not        is_superuser()        and        not        
		exists(select        1        from        group_category        a,        document        b
		where        a.id_group        =        get_group()
		and        a.id_category        =        b.id_category
		and        b.id        =        piddoc
		and        a.can_comment        =        true)        then

		raise        exception        '-1|%',        get_msg('permission_denied');
		
	end        if;

end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.check_can_comment2(pidcomm  integer)
  RETURNS  void
  LANGUAGE  plpgsql
  STABLE
AS  $function$
declare
	iddoc        int;
begin
	perform        check_notnull(-1,        pidcomm);
	select        into        iddoc
	id_document        from        user_comment        where        id        =        pidcomm;

	if        not        found        then
		raise        exception        '-1|%',        get_msg('invalid_argument');
	end        if;

	perform        check_document(iddoc,        3);
end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.check_can_inscribe()
  RETURNS  void
  LANGUAGE  plpgsql
  STABLE
AS  $function$
begin
	if        not        exists(select        1        from        "configuration"        where        anonymous_can_inscribe=true)        then
		raise        exception        '-1|%',        get_msg('permission_denied');
	end        if;
end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.check_can_manage()
  RETURNS  void
  LANGUAGE  plpgsql
  STABLE
AS  $function$
begin
	if        not        exists(select        1        from        
		"editor"        a,        "group"        b
		where        a.id_group        =        b.id
		and        a.active        =        true
		and        b.active        =        true
		and        (b.perm_administrator_groups=true        or        b.perm_administrator_users=true)
		and        a.id        =        (select        id        from        user_info        limit        1))        then

		raise        exception        '-1|%',        get_msg('permission_denied');
		
	end        if;

end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.check_can_use()
  RETURNS  void
  LANGUAGE  plpgsql
  STABLE
AS  $function$
begin
	if        coalesce((select        id        from        user_info),        0)=0        and        not        exists(select        1        from        "configuration"        where        id=1        and        anonymous_can_use=true)        then
		raise        exception        '-1|%',        get_msg('permission_denied');
	end        if;
end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.check_group(pcmp  integer,  pgroup  integer)
  RETURNS  void
  LANGUAGE  plpgsql
  STABLE
AS  $function$
begin
	if        not        exists(select        1        from        "group"        where        id        =        pgroup        and        active        =        true)        then
		raise        exception        '%|%',        pcmp,        get_msg('invalid_argument');
	end        if;

end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.check_login(cmp  integer,  plogin  character  varying)
  RETURNS  void
  LANGUAGE  plpgsql
  STABLE
AS  $function$
begin
	if        plogin        is        null        or        trim(plogin)=''        then
		raise        exception        '%|%',        cmp,        get_msg('login_isempty');
	end        if;

	if        length(plogin)>128        then
		raise        exception        '%|%',        cmp,        get_msg('login_exceeds_128');
	end        if;

	if        exists(select        1        from        "editor"        where        login=lower(plogin)        and        active=true)        then
		raise        exception        '%|%',        cmp,        get_msg('login_already_exists');
	end        if;
end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.check_login2(cmp  integer,  plogin  character  varying,  pid  integer)
  RETURNS  void
  LANGUAGE  plpgsql
  STABLE
AS  $function$
begin
	if        plogin        is        null        or        trim(plogin)=''        then
		raise        exception        '%|%',        cmp,        get_msg('login_isempty');
	end        if;

	if        length(plogin)>128        then
		raise        exception        '%|%',        cmp,        get_msg('login_exceeds_128');
	end        if;

	if        exists(select        1        from        "editor"        where        login=lower(plogin)        and        active=true        and        (pid        is        null        or        pid=0        or        id<>pid))        then
		raise        exception        '%|%',        cmp,        get_msg('login_already_exists');
	end        if;
end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.check_manages_group(cmp  integer,  id_group  integer)
  RETURNS  void
  LANGUAGE  plpgsql
  STABLE
AS  $function$
begin
	if        id_group        is        null        or        id_group=0        or        not        id_group        =        any(select        get_managed_groups())        then
		raise        exception        '%|%',        cmp,        get_msg('permission_denied');
	end        if;

end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.ws_delete_editor(pid  integer)
  RETURNS  void
  LANGUAGE  plpgsql
AS  $function$
begin
	perform        check_can_use();
	perform        check_manages_user(-1,        pid);


	update        "editor"        set        
	active        =        false
	where        id        =        pid;

	insert        into        access_log("action",        "table",        table_id)        values        (
	'delete',        'editor',        pid);
end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.ws_get_category_info(pid  integer,  OUT  name  character  varying,  OUT  email  character  varying)
  RETURNS  record
  LANGUAGE  plpgsql
  STABLE
AS  $function$
begin
	perform        check_can_use();
	perform        check_superuser();

	select        into        name,        email
	a.name,        a.email        from        category        a
	where        a.id        =        pid        and        a.active        =        true;
end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.check_name(cmp  integer,  pname  character  varying)
  RETURNS  void
  LANGUAGE  plpgsql
  STABLE
AS  $function$
begin
	if        pname        is        null        or        trim(pname)=''        then
		raise        exception        '%|%',        cmp,        get_msg('name_isempty');
	end        if;

	if        length(pname)>200        then
		raise        exception        '%|%',        cmp,        get_msg('name_exceeds_200');
	end        if;
end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.check_notnull(cmp  integer,  pi  integer)
  RETURNS  void
  LANGUAGE  plpgsql
  IMMUTABLE
AS  $function$
begin
	if        pi        is        null        or        pi=0        then
		raise        exception        '%|%',        cmp,        get_msg('invalid_argument');
	end        if;
end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.check_notnull_timestamp(cmp  integer,  t  timestamp  without  time  zone)
  RETURNS  void
  LANGUAGE  plpgsql
  IMMUTABLE
AS  $function$
begin
	if        t        is        null        then
		raise        exception        '%|%',        cmp,        get_msg('invalid_argument');
	end        if;

end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.check_password(cmp  integer,  cmp2  integer,  ppass  character  varying,  ppass2  character  varying)
  RETURNS  void
  LANGUAGE  plpgsql
  IMMUTABLE
AS  $function$
begin
	if        ppass        is        null        or        trim(ppass)=''        then
		raise        exception        '%|%',        cmp,        get_msg('password_isempty');
	end        if;

	if        ppass2        is        null        or        trim(ppass2)=''        then
		raise        exception        '%|%',        cmp2,        get_msg('password_isempty');
	end        if;

	if        ppass<>ppass2        then
		raise        exception        '%|%',        cmp2,        get_msg('passwords_not_match');
	end        if;

	
end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.check_password2(cmp  integer,  cmp2  integer,  ppass  character  varying,  ppass2  character  varying)
  RETURNS  void
  LANGUAGE  plpgsql
  IMMUTABLE
AS  $function$
begin

	if        ppass<>ppass2        then
		raise        exception        '%|%',        cmp2,        get_msg('passwords_not_match');
	end        if;

	
end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.check_superuser()
  RETURNS  void
  LANGUAGE  plpgsql
  STABLE
AS  $function$
begin
	if        not        is_superuser()        then
		raise        exception        '-1|%',        get_msg('permission_denied');
	end        if;

end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.check_text(cmp  integer,  ptxt  character  varying)
  RETURNS  void
  LANGUAGE  plpgsql
  STABLE
AS  $function$
begin
	if        ptxt        is        null        or        trim(ptxt)=''        then
		raise        exception        '%|%',cmp,get_msg('text_isempty');
	end        if;

	if        length(ptxt)>8000000        then
		raise        exception        '%|%',cmp,get_msg('text_exceeds_8000000');
	end        if;
end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.get_addr()
  RETURNS  character  varying
  LANGUAGE  plpgsql
  STABLE
AS  $function$
begin
		return        (select        addr        from        user_info);

end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.is_superuser()
  RETURNS  boolean
  LANGUAGE  plpgsql
  STABLE
AS  $function$
begin
	return        exists(select        1        from        "group"        
		where        id        =        get_group()        
		and        active        =        true
		and        perm_administrator_groups=true
		);
end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.get_categories(pall  boolean,  plevel  integer)
  RETURNS  SETOF  category
  LANGUAGE  plpgsql
  STABLE
AS  $function$
begin
	if        pall=true        or        is_superuser()        then
		return        query        select        *        from        category        
		where        active        =        true
		order        by        name;
	else
		return        query        select        a.*        from        category        a,        group_category        b
		where        a.active        =        true
		and        a.id        =        b.id_category
		and        b.id_group        =        get_group()
		and        b.level_priviledge        >=        plevel
		order        by        a.name;
	end        if;
end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.get_configuration()
  RETURNS  configuration
  LANGUAGE  plpgsql
  STABLE
AS  $function$
declare        
	ret        configuration;
begin
	select        into        ret
	*        from        configuration;

	return        ret;
end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.get_group()
  RETURNS  integer
  LANGUAGE  plpgsql
  STABLE
AS  $function$
declare
	id_user        int;
	id_group        int;
begin
	id_user:=(select        id        from        user_info        limit        1);
	
	if        id_user=0        then
		select        into        id_group
		anonymous_group        from        "configuration"
		where        id        =        1        and        anonymous_can_use=true;
	else
		select        into        id_group
		a.id_group        from        "editor"        a
		where        a.active        =        true        and        a.id        =        id_user;
	end        if;

	return        id_group;
end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.get_languages()
  RETURNS  SETOF  language
  LANGUAGE  plpgsql
  STABLE
AS  $function$
begin
	return        query        select        *        from        "language";
end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.get_managed_users()
  RETURNS  SETOF  integer
  LANGUAGE  plpgsql
  STABLE
AS  $function$
declare
	grps        int[];
begin
	grps:=array(select        get_managed_groups());

	return        query
	select        a.id        
	from        "editor"        a
	where        a.active        =        true
	and        a.id_group        =        any(grps);

end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.get_msg(pname  character  varying)
  RETURNS  text
  LANGUAGE  plpgsql
  STABLE
AS  $function$
declare
	ret        text;
begin
	select        into        ret
	a.value        from        language        a,        user_info        b
	where        a.name=pname
	and        a.lang=b.lang;

	if        not        found        then
		ret:='';
	end        if;

	return        ret;
end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.check_old_document(cmp  integer,  pid  integer,  plevel  integer)
  RETURNS  void
  LANGUAGE  plpgsql
  STABLE
AS  $function$
declare
	iddoc        int;
	extr        xml;
begin
	select        into        extr,        iddoc
	extra,        table_id        from        access_log
	where        id        =        pid
	and        "table"=        'document';

	if        (extr        is        null)        or        
		(
		(array_length(xpath('/document/doc/table/row/id/text()',        extr),1)        is        null)
		and        (array_length(xpath('/java/object/void[@property=''id'']/int[1]/text()',        extr),1)        is        null)
		)
		        then
		raise        exception        '%|%',        cmp,        get_msg('invalid_argument');
	end        if;

	perform        check_document(iddoc,        plevel);
end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.get_old_javabean_document(extra  xml,  plevel  integer,  OUT  id  integer,  OUT  name  character  varying,  OUT  texthtml  character  varying,  OUT  status  character,  OUT  isrichtext  boolean,  OUT  id_category  integer,  OUT  level_priviledge  integer,  OUT  atts  character  varying)
  RETURNS  record
  LANGUAGE  plpgsql
  IMMUTABLE
AS  $function$
declare
	active        bool;
	xatt        xml;
	xatts        xml[];
	n        varchar;
	f        varchar;
	i        int;
	len        int;
begin

active:=coalesce((xpath('/java/object/void[@property=''active'']/boolean[1]/text()',        extra))[1]::varchar='true',        false);

if        active<>true        then
	raise        exception        '-1|%',        get_msg('permission_denied');
end        if;

id:=(xpath('/java/object/void[@property=''id'']/int[1]/text()',        extra))[1]::varchar::int;
name:=((xpath('/java/object/void[@property=''name'']/string[1]/text()',        extra))[1]::varchar);
texthtml:=((xpath('/java/object/void[@property=''texthtml'']/string[1]/text()',        extra))[1]::varchar);
status:=((xpath('/java/object/void[@property=''status'']/string[1]/text()',        extra))[1]::varchar);
isrichtext:=coalesce((xpath('/java/object/void[@property=''isrichtext'']/boolean[1]/text()',        extra))[1]::varchar='true',        false);
id_category:=(xpath('/java/object/void[@property=''idCategory'']/int[1]/text()',        extra))[1]::varchar::int;

perform        check_document(id,        plevel);

if        is_superuser()        then
	level_priviledge:=3;
else        
	i:=id;
	level_priviledge:=coalesce((
	select        a.level_priviledge        
	from        group_category        a,        "document"        b
	where        b.id_category        =        a.id_category        
	and        a.id_group        =        get_group()
	and        b.id        =        i),        0);
end        if;


atts:='';
i:=1;
xatts:=xpath('/java/array/void',        extra);
len:=array_length(xatts,        1);
loop
	xatt:=xatts[i];

	if        i>len        or        len        is        null        then
		exit;
	end        if;
	i:=i+1;
	
	n:=(xpath('/void/object/void[@property=''name'']/string[1]/text()',        xatt))[1]::varchar;
	f:=(xpath('/void/object/void[@property=''folder'']/string[1]/text()',        xatt))[1]::varchar;

	
	if        atts=''        then
		atts:=get_att_extension(n)||';'||f||';'||n;
	else
		atts:=atts||'|'||get_att_extension(n)||';'||f||';'||n;
	end        if;
		
end        loop;

/*
"<java        version="1.8.0_25"        class="java.beans.XMLDecoder">
        <object        class="omegabase.dao.Document">
                <void        property="active">
                        <boolean>true</boolean>
                </void>
                <void        property="dateCreation">
                        <object        class="java.sql.Timestamp">
                                <long>1423260160466</long>
                        </object>
                </void>
                <void        property="dateModification">
                        <object        class="java.sql.Timestamp">
                                <long>1423260194588</long>
                        </object>
                </void>
                <void        property="id">
                        <int>1</int>
                </void>
                <void        property="idCategory">
                        <int>1</int>
                </void>
                <void        property="keywords">
                        <string>&apos;coisa&apos;:5        &apos;documento&apos;:2        &apos;eca&apos;:3        &apos;lixo&apos;:4        &apos;novo&apos;:1        &apos;podreÃ©Ã©Ã©Ã©&apos;:6</string>
                </void>
                <void        property="name">
                        <string>Novo        documento</string>
                </void>
                <void        property="numAccesses">
                        <int>3</int>
                </void>
                <void        property="status">
                        <string>P</string>
                </void>
                <void        property="texthtml">
                        <string>Eca        lixo

Coisa        podreÃ©Ã©Ã©Ã©</string>
                </void>
        </object>
        <array        class="omegabase.dao.FileBlob"        length="1">
                <void        index="0">
                        <object        class="omegabase.dao.FileBlob">
                                <void        property="active">
                                        <boolean>true</boolean>
                                </void>
                                <void        property="date">
                                        <object        class="java.sql.Timestamp">
                                                <long>1423260419338</long>
                                        </object>
                                </void>
                                <void        property="folder">
                                        <string>file</string>
                                </void>
                                <void        property="id">
                                        <int>1</int>
                                </void>
                                <void        property="idDocument">
                                        <int>1</int>
                                </void>
                                <void        property="modificationDate">
                                        <object        class="java.sql.Timestamp">
                                                <long>1423260419338</long>
                                        </object>
                                </void>
                                <void        property="name">
                                        <string>blackt_i386.exe</string>
                                </void>
                        </object>
                </void>
        </array>
</java>
*/

end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.get_user()
  RETURNS  integer
  LANGUAGE  plpgsql
  STABLE
AS  $function$
begin
	return        (select        id        from        user_info);

end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.make_log_document(pid  integer,  ac  character  varying)
  RETURNS  void
  LANGUAGE  plpgsql
AS  $function$
begin

	insert        into        access_log("action",        "table",        table_id,        extra)        values        (
	ac,        'document',        pid,        
	
		xmlelement(name        document,
			xmlelement(name        doc,
				query_to_xml('select        *        from        document        where        id        =        '||pid,        false,        false,        '')
			),        xmlelement(name        attachs,
				query_to_xml('select        id        from        file_blob        where        active        =        true        and        id_document        =        '||pid,        false,        false,        '')
			)
		));

end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.make_logout()
  RETURNS  void
  LANGUAGE  plpgsql
AS  $function$
begin
	insert        into        access_log("table",        "action")        values('editor',        'logout');
	drop        table        user_info;
end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.make_unxml(x  character  varying)
  RETURNS  character  varying
  LANGUAGE  plpgsql
  IMMUTABLE
AS  $function$
begin
	x:=replace(x,        '&lt;',        '<');
	x:=replace(x,        '&gt;',        '>');
	x:=replace(x,        '&amp;',        '&');

	return        x;
end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.set_user_info(pid  integer,  paddr  character  varying,  plang  character  varying)
  RETURNS  void
  LANGUAGE  plpgsql
AS  $function$
begin
	create        temp        table        user_info        (
	id        int,
	addr        varchar(20),
	lang        varchar(20)
	)        on        commit        drop;
	
	insert        into        user_info        values        (pid,        paddr,        plang);
end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.syncro_save_file(piddoc  integer,  pidfile  integer,  pstatus  character,  pname  character  varying,  psource  character  varying,  pfilename  character  varying,  pctdo  bytea,  pkeys  character  varying,  pdate  timestamp  without  time  zone,  pcategory  integer,  OUT  line  character  varying)
  RETURNS  character  varying
  LANGUAGE  plpgsql
AS  $function$
declare
	str        varchar;
	
begin
	if        piddoc        is        null        or        piddoc=0        then
		perform        check_document(piddoc,        2);
	
		insert        into        "document"        (name,        date_creation,        date_modification,        texthtml,        id_category,        active,        num_accesses,        isrichtext,        id_owner,        status)
		values(pname,        now(),        now(),        '        ',        pcategory,        true,        0,        false,        
		case        when        pstatus='R'        then        (select        id        from        user_info        limit        1)        else        null        end,
		pstatus);

		piddoc:=currval('document_id_seq');

		str:='INSERTED';
	else
		perform        check_document2(-1,        piddoc,        pcategory,        pstatus,        2,        false);

		update        "document"        set        date_modification=now()
		where        id        =        piddoc;

		str:='INSERTED';
	end        if;

	if        pidfile        is        not        null        then
		update        file_blob        set        active        =        false        where        id        =        pidfile;
		str:='UPDATED';
	end        if;

	insert        into        file_blob(name,        date,        id_document,        blob,        folder,        keywords,        modification_date,        active,        source)
	values(pfilename,        pdate,        piddoc,        pctdo,        'file',        to_tsvector('simple',        pkeys),        now(),        true,        psource);


	perform        make_log_document(piddoc,        'import');
/*
	insert        into        access_log("action",        "table",        table_id,        extra)        values        
	('import',        'file_blob',        currval('file_blob_id_seq')::int,        
	query_to_xml('select        id,name,folder,date,id_document,modification_date        from        file_blob        where        id        =        '||currval('file_blob_id_seq'),false,false,''));
*/

	line:=pfilename||'|'||str;
end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.ws_del_attach(pid  integer)
  RETURNS  void
  LANGUAGE  plpgsql
AS  $function$
declare        
	iddoc        int;
	keynull        bool;
begin
	perform        check_can_use();
	perform        check_attach2(-1,        pid,        2);
	

	update        file_blob        set
	active        =        false,
	modification_date        =        now()
	where        id        =        pid;


	select        into        iddoc,        keynull
	id_document,        keywords        is        null        from        file_blob        
	where        id        =        pid;

	
	if        found        then
		perform        make_log_document(iddoc,        'del_att');
	end        if;
end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.ws_del_many_documents(pdocs  character  varying)
  RETURNS  void
  LANGUAGE  plpgsql
AS  $function$
declare
	i        int;
	str        varchar;
	doc        int;
begin
	perform        check_can_use();

	i:=1;

	loop
		str:=split_part(pdocs,        '|',        i);
		exit        when        str='';

		doc:=str::int;

		perform        check_document(doc,        2);
		update        file_blob        set        active        =        false        where        id_document        =        doc        and        active=true;
		delete        from        user_comment        where        id_document        =        doc;
		update        document        set        active=false        where        id        =        doc;

		perform        make_log_document(doc,        'delete');
		i:=i+1;
	end        loop;

end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.ws_get_attachs(piddoc  integer,  pfolder  character  varying,  OUT  id  integer,  OUT  name  character  varying,  OUT  icon  character  varying)
  RETURNS  SETOF  record
  LANGUAGE  plpgsql
  STABLE
AS  $function$
begin
	perform        check_can_use();
	perform        check_name(-1,        pfolder);
	perform        check_notnull(-1,        piddoc);
	perform        check_document(piddoc,        1);

	return        query        select        a.id,        a.name,        get_att_extension(a.name)        from        file_blob        a
	where        a.id_document        =        piddoc
	and        a.active        =        true
	and        a.folder        =        pfolder
	order        by        a.date        desc;
end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.ws_login(puser  character  varying,  ppass  character  varying,  pcaptcha  character  varying,  pcaptcha_try  character  varying,  OUT  id  integer,  OUT  name  character  varying,  OUT  id_group  integer,  OUT  superusr  boolean,  OUT  admusers  boolean)
  RETURNS  record
  LANGUAGE  plpgsql
AS  $function$
begin
	perform        check_captcha(-1,        pcaptcha,        pcaptcha_try);

	select        into        id,        name,        id_group,        superusr,        admusers
	a.id,        a.name,        a.id_group,        b.perm_administrator_groups,        b.perm_administrator_users        
	from        editor        a,        "group"        b
	where        a.login=puser
	and        a.password        =        md5(ppass)
	and        a.active        =        true
	and        b.id        =        a.id_group
	and        b.active        =        true;

	if        not        found        then
		raise        exception        '-1|%',        get_msg('invalid_password');
	end        if;

	
	update        user_info        set
		id        =        $5;

	insert        into        access_log("table","action")        values('editor',        'login');

end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.ws_get_document(pid  integer,  plevel  integer,  OUT  id  integer,  OUT  name  character  varying,  OUT  texthtml  character  varying,  OUT  status  character,  OUT  isrichtext  boolean,  OUT  id_category  integer,  OUT  level_priviledge  integer,  OUT  category_name  character  varying,  OUT  can_comment  boolean)
  RETURNS  record
  LANGUAGE  plpgsql
AS  $function$
declare
	rec        record;
	ac        varchar;
begin
	perform        check_can_use();
	perform        check_notnull(-1,        pid);
	perform        check_notnull(-1,        abs(plevel));
	perform        check_document(pid,        abs(plevel));

	if        is_superuser()        then
	
		select        into        id,        name,        texthtml,        status,        isrichtext,        id_category,        level_priviledge,        category_name,        can_comment
		a.id,        a.name,        a.texthtml,        a.status,        a.isrichtext,        a.id_category,        3,        b.name,        true
		from        "document"        a,        category        b
		where        a.active        =        true
		and        b.active        =        true
		and        b.id        =        a.id_category
		and        a.id        =        pid;
		
	else        
		select        into        id,        name,        texthtml,        status,        isrichtext,        id_category,        level_priviledge,        category_name,        can_comment
		a.id,        a.name,        a.texthtml,        a.status,        a.isrichtext,        a.id_category,        b.level_priviledge,        c.name,        b.can_comment
		from        "document"        a,        group_category        b,        category        c
		where        a.id        =        pid
		and        a.id_category        =        b.id_category
		and        b.id_group        =        get_group()
		and        a.active        =        true
		and        c.id        =        a.id_category
		and        c.active        =        true;
	end        if;


	if        plevel=1        then

	ac:='view';
	
	update        "document"                set
		num_accesses        =        num_accesses+1
	where        "document".id        =        pid;

	else
	
	ac:='tryedit';
		
	end        if;

	insert        into        access_log("table",        table_id,        "action")        
	values('document',        pid,        ac);
end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.ws_get_groups(OUT  id  integer,  OUT  name  character  varying)
  RETURNS  SETOF  record
  LANGUAGE  plpgsql
  STABLE
AS  $function$
begin
	perform        check_can_use();
	
	return        query        select        "group".id,"group"."name"        from        "group"        
	where        active=true
	order        by        "group"."name";
end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.ws_get_managed_groups(OUT  id  integer,  OUT  name  character  varying)
  RETURNS  SETOF  record
  LANGUAGE  plpgsql
  STABLE
AS  $function$
declare
	grps        int[];
begin
	perform        check_can_use();
	perform        check_can_manage();

	grps:=array(select        get_managed_groups());

	return        query
	select        a.id,        a.name        from        "group"        a
	where        a.active        =        true        and        a.id        =        any(grps)
	order        by        a.name;
end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.ws_get_managed_user_info(pcmp  integer,  pid  integer,  OUT  name  character  varying,  OUT  id_group  character  varying,  OUT  login  character  varying)
  RETURNS  record
  LANGUAGE  plpgsql
  STABLE
AS  $function$
begin
	perform        check_can_use();
	perform        check_manages_user(pcmp,        pid);

	select        into        "name",        id_group,        "login"
	a.name,        a.id_group,        a.login        from        "editor"        a
	where        a.id        =        pid;
end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.ws_get_historic(piddoc  integer,  pjustedit  boolean,  OUT  id  integer,  OUT  action  character  varying,  OUT  date  timestamp  with  time  zone,  OUT  addr  character  varying,  OUT  id_user  integer,  OUT  name_user  character  varying)
  RETURNS  SETOF  record
  LANGUAGE  plpgsql
  STABLE
AS  $function$
begin
	perform        check_can_use();
	perform        check_notnull(-1,        piddoc);
	perform        check_document(piddoc,        3);
	pjustedit:=check_bool(pjustedit);


	return        query        select        a.id,        get_msg(a.action)::varchar,        a.date,        a.ip,        a.user,        b.name
	from        access_log        a
	left        join        "editor"        b        on        a.user        =        b.id        and        b.active        =        true
	where        a.table_id        =        piddoc
	and        a.table        =        'document'
	and        a.action        =        'save'
	and        a.extra        is        not        null
	order        by        a.date        desc        nulls        last        limit        1000;

end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.ws_save_attach(piddoc  integer,  pname  character  varying,  pblob  bytea,  pkeys  character  varying,  pfolder  character  varying)
  RETURNS  integer
  LANGUAGE  plpgsql
AS  $function$
declare
	oldid        int;
	datec        timestamp;
begin
	perform        check_can_use();
	perform        check_notnull(0,        piddoc);
	perform        check_name(1,        pname);
	perform        check_document(piddoc,        2);
	perform        check_attach(1,        pblob);
	perform        check_name(2,        pfolder);

	select        into        oldid,        datec
	id,        date        from        file_blob        
	where        id_document        =        piddoc
	and        active        =        true
	and        folder        =        pfolder
	and        "name"        =        pname;

	if        found        then
		update        file_blob        set        
			active=false        
		where        id        =        oldid;
	else
		datec:=now();
	end        if;

	insert        into        file_blob        (name,        id_document,        date,        blob,        folder,        modification_date,        keywords,        active)        values        (
	pname,        piddoc,        datec,        pblob,        pfolder,        now(),        to_tsvector('simple',        pkeys),        true);


	perform        make_log_document(piddoc,        'save_att');

	

	return        currval('file_blob_id_seq');
	
end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.ws_save_configuration(panon_use  boolean,  panon_group  integer,  panon_inscr  boolean,  panon_inscr_group  integer,  psmtp_server  character  varying,  psmtp_crypto  character  varying,  pemail_port  integer,  pemail_user  character  varying,  pemail_pass  character  varying,  pmax_att_size  integer)
  RETURNS  void
  LANGUAGE  plpgsql
AS  $function$
begin
	perform        check_can_use();
	perform        check_superuser();
	perform        check_group(1,        panon_group);
	perform        check_group(3,        panon_inscr_group);
	--perform        check_notnull(6,        pemail_port);
	perform        check_notnull(9,        pmax_att_size);

	panon_use:=check_bool(panon_use);
	panon_inscr:=check_bool(panon_inscr);

	if        panon_use=false        then
		panon_group:=null;
	end        if;

	if        panon_inscr=false        then
		panon_inscr_group:=null;
	end        if;

	if        psmtp_server        is        null        or        psmtp_server=''        then
		psmtp_crypto:=null;
		pemail_port:=0;
		pemail_user:=null;
		pemail_pass:=null;
	end        if;
	

	update        "configuration"        set        
	anonymous_can_use        =        panon_use,
	anonymous_group        =        panon_group,
	anonymous_can_inscribe        =        panon_inscr,
	anonymous_inscribe_group        =        panon_inscr_group,
	smtp_Server        =        psmtp_server,
	smtp_crypto        =        psmtp_crypto,
	smtp_port        =        pemail_port,
	smtp_user        =        pemail_user,
	smtp_pass        =        pemail_pass,
	max_att_size        =        pmax_att_size
	where        id        =        1;
	
	
end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.ws_save_document(pname  character  varying,  pisrich  boolean,  ptxt  character  varying,  pid  integer,  pid_category  integer,  pstatus  character,  del  boolean)
  RETURNS  void
  LANGUAGE  plpgsql
AS  $function$
declare
	idowner        int;
	oldstatus        char;
	forceCopy        bool;
begin
	perform        check_can_use();
	perform        check_document(pid,        2);
	perform        check_document2(4,        pid,        pid_category,        pstatus,        2,        del);
	pisrich:=check_bool(pisrich);
	del:=check_bool(del);

	if        del=false        then
		perform        check_name(0,        pname);
		perform        check_text(2,        ptxt);
	end        if;


	if        pid        is        not        null        and        pid<>0        then
		select        into        oldstatus
		status        from        "document"        where        id        =        pid;
	end        if;
	
	forceCopy:=pid        is        not        null        and        pid<>0        and        oldstatus<>'E'        and        pstatus='R';

	if        pstatus='        '        then
		select        into        pstatus
		status        from        "document"
		where        id        =        pid;
	end        if;
		

	if        pstatus='R'        then
		idowner:=nullif((select        id        from        user_info        limit        1),        0);
	else        
		idowner:=null;
	end        if;

	if        del=true        then
		update        "document"        set        active        =        false        where        id        =        pid        and        active=true;
		update        file_blob        set        active        =        false        where        id_document        =        pid        and        active        =        true;
		perform        make_log_document(pid,        'delete');
		
	elsif        pid        is        null        or        pid=0        or        forceCopy        then
		insert        into        "document"(name,        isrichtext,        texthtml,        date_creation,        date_modification,        num_accesses,        id_owner,        status,        id_category,        active)        values        (
		pname,        pisrich,        ptxt,        now(),        now(),        0,        idowner,        pstatus,        pid_category,        true);


--		if        pid        is        not        null        and        pid<>0        and        forceCopy        then
--			perform        make_copy_attachs(pid,        currval('document_id_seq')::int);
--		end        if;
		
		pid:=currval('document_id_seq');
		
		perform        make_log_document(pid,        'save');
	else
		update        "document"        set        
		name        =        pname,        
		isrichtext        =        pisrich,        
		texthtml        =        ptxt,        
		date_modification        =        now(),        
		id_owner        =        idowner,
		status        =        pstatus,
		id_category        =        pid_category,
		active        =        true
		where        id        =        pid;
		
		perform        make_log_document(pid,        'save');

	end        if;


	
end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.ws_save_managed_user(pid  integer,  pname  character  varying,  plogin  character  varying,  pid_group  integer,  ppass  character  varying,  ppass2  character  varying)
  RETURNS  integer
  LANGUAGE  plpgsql
AS  $function$
begin
	perform        check_can_use();
	perform        check_can_manage();
	
	if        pid        is        not        null        and        pid<>0        then
		perform        check_manages_user(-1,        pid);
	end        if;
	
	perform        check_manages_group(3,        pid_group);
	perform        check_login2(2,        plogin,pid);
	perform        check_name(1,        pname);

	if        pid        is        not        null        and        pid<>0        then
		perform        check_password2(4,        5,        ppass,        ppass2);
	else
		perform        check_password(4,        5,        ppass,        ppass2);
	end        if;

	if        pid        is        null        or        pid=0        then
		insert        into        "editor"        ("name",        "login",        id_group,        "password",        active)        values
		(pname,        plogin,        pid_group,        md5(ppass),        true);
		pid:=currval('editor_id_seq');
		
		insert        into        access_log("table",        "action",table_id)        values
		('document',        'save',        pid);
	else        
		if        ppass        is        not        null        and        ppass<>''        then	
			update        "editor"        set
			"name"        =        pname,
			"login"        =        plogin,
			"password"        =        md5(ppass),
			id_group        =        pid_group
			where        id        =        pid;
		else
			update        "editor"        set
			"name"        =        pname,
			"login"        =        plogin,
			id_group        =        pid_group
			where        id        =        pid;
		end        if;
		
		insert        into        access_log("table",        "action",table_id)        values
		('document',        'save',        pid);

	end        if;

	return        pid;
end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.ws_save_category(pid  integer,  pname  character  varying,  pemail  character  varying,  OUT  id_category  integer)
  RETURNS  integer
  LANGUAGE  plpgsql
AS  $function$
begin
	perform        check_can_use();
	perform        check_superuser();
	perform        check_name(1,        pname);
	

	if        pid        is        not        null        and        pid<>0        then
		update        category        set
		name        =        pname,
		email        =        pemail
		where        id        =        pid        and        active        =        true;

		if        not        found        then
			return;
		end        if;

		id_category:=pid;
	else

		insert        into        category(name,        email,        active)        values
		(pname,        pemail,        true);

		id_category:=currval('category_id_seq');
	
	end        if;

	insert        into        access_log("action",        "table",        table_id,        extra)        values
	('save',        'category',        id_category,
	query_to_xml('select        *        from        category        where        id        =        '||id_category,        false,        false,        ''));
end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.wsb_get_attach(piddoc  integer,  pfolder  character  varying,  pname  character  varying,  OUT  name  character  varying,  OUT  blob  bytea)
  RETURNS  record
  LANGUAGE  plpgsql
  STABLE
AS  $function$
begin
	perform        check_can_use();
	perform        check_name(-1,        pname);
	perform        check_name(-1,        pfolder);
	perform        check_document(piddoc,        1);

	select        into        "name",        blob
	a.name,        a.blob        from        file_blob        a
	where        a.id_document        =        piddoc
	and        a.active        =        true
	and        a.folder        =        pfolder
	and        a.name        =        pname;

	if        not        found        then
		raise        exception        '-1|%',        get_msg('invalid_argument');
	end        if;

end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.wsb_get_old_attach(pidac  integer,  pfolder  character  varying,  pfile  character  varying,  plevel  integer,  OUT  name  character  varying,  OUT  ctdo  bytea)
  RETURNS  record
  LANGUAGE  plpgsql
  STABLE
AS  $function$
declare        
	i        int;
	len        int;
	xatts        xml[];
	iatts        int[];
	e        xml;
	ret        bytea;
begin
	perform        check_can_use();
	perform        check_notnull(-1,pidac);
	perform        check_old_document(-1,        pidac,        plevel);

	iatts:=array[]::int[];
	
	select        into        e
	extra        from        access_log
	where        id        =        pidac;
	
	xatts:=xpath('/document/attachs/table/row/id/text()',        e);

	if        array_length(xatts,        1)        is        not        null        then
		i:=1;
		loop
			exit        when        i>array_length(xatts,        1);
			
			iatts:=iatts||xatts[i]::varchar::int;
			i:=i+1;
		end        loop;
	end        if;

	select        into        "name",        ctdo
	a.name,        a.blob        from        file_blob        a
	where        a.id        =        any(iatts)
	and        a.name        =        pfile
	and        a.folder        =        pfolder;

end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.ws_get_group_info(pgroup  integer,  OUT  name  character  varying,  OUT  adm_groups  boolean,  OUT  adm_users  boolean)
  RETURNS  record
  LANGUAGE  plpgsql
  STABLE
AS  $function$
begin
	perform        check_can_use();
	perform        check_superuser();

	select        into        name,        adm_groups,        adm_users
	a.name,        a.perm_administrator_groups,        a.perm_administrator_users
	from        "group"        a        where        a.id        =        pgroup        and        a.active        =        true;
end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.get_managed_groups()
  RETURNS  SETOF  integer
  LANGUAGE  plpgsql
  STABLE
AS  $function$
declare
	admg        bool;
	admu        bool;
	grp        int;
begin
	select        into        admg,        admu,        grp
	a.perm_administrator_groups,        a.perm_administrator_users,        a.id
	from        "group"        a,        "editor"        b
	where        b.id        =        (select        id        from        user_info        limit        1)
	and        b.id_group        =        a.id
	and        b.active        =        true;

		
	if        admg        then
		return        query        select        id        from        "group"        where        active        =        true;
	elsif        admu        then
		return        query        select        id_slave        from        group_master        where        id_master        =        grp;
	end        if;
end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.ws_get_managed_users(OUT  id  integer,  OUT  name  character  varying,  OUT  id_group  integer,  OUT  name_group  character  varying)
  RETURNS  SETOF  record
  LANGUAGE  plpgsql
  STABLE
AS  $function$
declare
	ids        int[];
begin
	perform        check_can_use();
	perform        check_can_manage();

	ids:=array(select        get_managed_groups());
	return        query        select        a.id,        a.name,        a.id_group,        b.name        
	from        "editor"        a
	inner        join        "group"        b        on        a.id_group        =        b.id        
	where        a.id_group        =        any(ids)
	and        b.active        =        true
	and        a.active        =        true
	order        by        a.name,        b.name;
end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.check_manages_user(pcmp  integer,  puser  integer)
  RETURNS  void
  LANGUAGE  plpgsql
  STABLE
AS  $function$
declare
	idgroup        int;
	idme        int;
	error        bool;
begin
	error:=false;

	select        into        idgroup
	id_group        from        "editor"        where        id        =        puser        and        active=true;
	idme:=get_user();

	if        not        found        then
		error:=true;
	elsif        not        is_superuser()        and        not        exists(
		select        1        from        "editor"        a,        "group"        b,        group_master        c        
		where        a.id        =        idme
		and        a.active        =        true
		and        b.id        =        a.id_group
		and        b.active        =        true
		and        b.perm_administrator_users        =        true
		and        c.id_master        =        b.id
		and        c.id_slave        =        idgroup)        then
			error:=true;
	end        if;

	if        error=true        then
		raise        exception        '%|%',        pcmp,        get_msg('permission_denied');
	end        if;
end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.ws_get_groups2(poffset  integer,  plimit  integer,  OUT  id  integer,  OUT  name  character  varying,  OUT  num_users  bigint,  OUT  superuser  boolean,  OUT  administrator  boolean)
  RETURNS  SETOF  record
  LANGUAGE  plpgsql
  STABLE
AS  $function$
begin
	perform        check_can_use();
	perform        check_superuser();

	if        plimit>200        then
		plimit:=200;
	end        if;

	return        query        select        a.id,        a.name,        (select        count(*)        from        "editor"        b        where        b.id_group        =        a.id        and        b.active=true),        a.perm_administrator_groups,        a.perm_administrator_users
	from        "group"        a
	where        a.active=true
	order        by        a.name
	offset        poffset        limit        plimit;
	
end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.ws_get_my_info(OUT  name  character  varying)
  RETURNS  character  varying
  LANGUAGE  plpgsql
  STABLE
AS  $function$
begin
	perform        check_can_use();
	perform        check_logged();

	select        into        name
	a.name        from        "editor"        a,        user_info        b
	where        a.id        =        b.id
	and        a.active        =        true;
end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.ws_delete_group(pid  integer,  OUT  group_id  integer)
  RETURNS  integer
  LANGUAGE  plpgsql
AS  $function$
begin
	perform        check_can_use();
	perform        check_superuser();

	if        not        exists(select        1        from        "group"        where        id        =        pid        and        active=true)        then
		return;
	end        if;

	insert        into        access_log("action",        "table",        table_id,        extra)        values        
	('delete',        'group',        pid,
xmlelement(name        group,
	xmlelement(name        group_master,
		query_to_xml('select        *        from        group_master        where        id_master        =        '||pid,        false,        false,'')
	),        xmlelement(name        group_category,
		query_to_xml('select        *        from        group_category        where        id_group        =        '||pid,        false,false,        '')
	))
	);

	delete        from        group_master        where        id_master        =        pid;
	delete        from        group_category        where        id_group        =        pid;
	update        "editor"        set        active        =        false        where        id_group        =        pid        and        active=true;
	update        "group"        set        active=false        where        id        =        pid;
end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.ws_get_group_slaves(pgroup  integer,  OUT  id_slave  integer,  OUT  name  character  varying,  OUT  adm_groups  boolean,  OUT  adm_users  boolean,  OUT  adm  boolean)
  RETURNS  SETOF  record
  LANGUAGE  plpgsql
  STABLE
AS  $function$
begin
	perform        check_can_use();
	perform        check_superuser();

	return        query        select        a.id,        a.name,        a.perm_administrator_groups,        a.perm_administrator_users,        b.id_slave        is        not        null
		from        "group"        a
		left        join        group_master        b        on        b.id_master        =        pgroup        and        b.id_slave        =        a.id
		where        a.active        =        true
		order        by        a.name;
end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.ws_delete_category(pid  integer)
  RETURNS  void
  LANGUAGE  plpgsql
AS  $function$
declare
	ex        xml;
begin
	perform        check_can_use();
	perform        check_superuser();

	ex:=xmlelement(name        category,
		xmlelement(name        category,
			query_to_xml('select        *        from        category        where        id        =        '||pid,        false,        false,        '')
		),        xmlelement(name        group_category,
			query_to_xml('select        *        from        group_category        where        id_category        =        '||pid,        false,        false,        '')
		));
		
	update        category        set        active=false        where        id        =        pid;

	if        found        then
		delete        from        group_category        where        id_category        =        pid;
		update        "document"        set        active        =        false        where        id_category        =        pid        and        active=true;
		
		insert        into        access_log("action",        "table",        table_id,        extra)        values        
		('delete',        'category',        pid,        ex);
	end        if;
end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.ws_get_group_categories(pgroup  integer,  OUT  id  integer,  OUT  name  character  varying,  OUT  level  integer,  OUT  can_comment  boolean)
  RETURNS  SETOF  record
  LANGUAGE  plpgsql
  STABLE
AS  $function$
begin
	perform        check_can_use();
	perform        check_superuser();

	return        query
	select        a.id,        a.name,        coalesce(b.level_priviledge,        0),        coalesce(b.can_comment,        false)
	from        category        a
	left        join        group_category        b        on        b.id_group        =        pgroup        and        b.id_category        =        a.id
	where        a.active        =        true
	order        by        a.name;
end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.check_notnull_varchar(pcmp  integer,  ptxt  character  varying)
  RETURNS  void
  LANGUAGE  plpgsql
  IMMUTABLE
AS  $function$
begin
	if        ptxt        is        null        then
		raise        exception        '%|%',        pcmp,        get_msg('invalid_argument');
	end        if;
end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.ws_get_categories2(OUT  id  integer,  OUT  name  character  varying,  OUT  groups  bigint)
  RETURNS  SETOF  record
  LANGUAGE  plpgsql
  STABLE
AS  $function$
begin
	perform        check_can_use();
	perform        check_superuser();

	return        query        select        a.id,        a.name,        (select        count(*)        from        group_category        b        where        b.id_category        =        a.id)
	from        category        a
	where        a.active        =        true
	order        by        a.name;
end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.ws_add_comment(piddoc  integer,  pmsg  character  varying,  OUT  id  integer,  OUT  iddoc  integer,  OUT  docname  character  varying,  OUT  catname  character  varying,  OUT  email  character  varying)
  RETURNS  record
  LANGUAGE  plpgsql
AS  $function$
begin
	perform        check_can_use();
	perform        check_can_comment(piddoc);
	perform        check_text(1,        pmsg);

	insert        into        user_comment(msg,        id_user,        date_comm,        id_document)        values        (
	pmsg,        nullif(get_user(),        0),        now(),        piddoc);

	id:=currval('user_comment_id_seq');


	if        is_superuser()        then
		select        into        iddoc,        docname,        catname,        email
		a.id,        a.name,        b.name,        b.email
		from        "document"        a,        category        b
		where        b.id        =        a.id_category
		and        a.id        =        piddoc
		and        a.active        =        true
		and        b.active        =        true;

	else
		select        into        iddoc,        docname,        catname,        email
		b.id,        b.name,        c.name,        c.email
		from        group_category        a,        "document"        b,        category        c
		where        c.id        =        b.id_category
		and        b.id        =        piddoc
		and        a.id_category        =        b.id_category
		and        a.id_group        =        get_group()
		and        b.active        =        true
		and        c.active        =        true
		and        a.can_comment        =        true;
	end        if;
end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.check_attach(cmp  integer,  pblob  bytea)
  RETURNS  void
  LANGUAGE  plpgsql
  STABLE
AS  $function$
begin
	if        pblob        isnull        then
		raise        exception        '%|%',        cmp,        get_msg('invalid_argument');
	end        if;

	if        length(pblob)>(select        max_att_size*1024*1024        from        "configuration"        where        id=1)        then
		raise        exception        '%|%',        cmp,        get_msg('att_too_big');
	end        if;
end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.check_captcha(cmp  integer,  pcaptcha  character  varying,  pcaptcha_try  character  varying)
  RETURNS  void
  LANGUAGE  plpgsql
  IMMUTABLE
AS  $function$
declare
	error        bool;
begin
	error:=false;

	if        pcaptcha        is        not        null        then
		if        pcaptcha_try        is        null        then
			error:=true;
		else        	
			error:=pcaptcha<>pcaptcha_try;
		end        if;
	end        if;

	if        error=true        then
		raise        exception        '%|%',        cmp,        get_msg('invalid_password');
	end        if;
end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.check_document(pid  integer,  plevel  integer)
  RETURNS  void
  LANGUAGE  plpgsql
  STABLE
AS  $function$
begin
	if        is_superuser()        then
		if        pid        is        not        null        and        pid<>0        and        not        
			exists(select        1        from        "document"        a
			where        a.id        =        pid
			and        (a.active        =        true        or        a.status        =        'E')
			and        (a.status        not        in('R',        'E')        or        a.id_owner        =        get_user())
			)        then
			
			raise        exception        '-1|%',        get_msg('permission_denied');

			
		end        if;
	/*		
	elsif        (pid        is        not        null)        and        (pid<>0)        and        (not        exists(
		select        1        from        "document"        a
		left        join        group_category        b        on        a.id_category        =        b.id_category        and        b.id_group        =        get_group()
		where        (a.active        =        true        or        a.status        =        'E')
		and        a.id        =        pid
		and        (a.status<>'P'        or        plevel=1        or        b.level_priviledge        >=        3)
		and        (a.status        not        in        ('R',        'E')        or        a.id_owner        =        (select        id        from        user_info))
		and        (a.status='R'        or        b.level_priviledge        >=        plevel)))
		then

		raise        exception        '-1|%',        get_msg('permission_denied');
	*/end        if;
end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.check_document2(cmp  integer,  pid  integer,  pid_category  integer,  pstatus  character,  plevel  integer,  pdel  boolean)
  RETURNS  void
  LANGUAGE  plpgsql
  STABLE
AS  $function$
declare
	oldstatus        char;
begin

	if        pid        is        not        null        and        pid<>0        then
		select        into        oldstatus        status        from        "document"
		where        id        =        pid;
	end        if;

	if        pdel=false        and        (not        pstatus        in        ('P',        'R',        'N',        '        ')        or        ((pid        is        null        or        pid=0        or        oldstatus='E')        and        pstatus='        '))        then
		raise        exception        '-1|%',        get_msg('invalid_argument');
	end        if;

	if        (pid        is        null        or        pid=0)        and        (pdel=true)        then
		raise        exception        '-1|%',        get_msg('invalid_argument');
	end        if;

	if        pdel=false        and        (pid_category        is        null        or        pid_category=0)                then
		raise        exception        '%|%',        cmp,        get_msg('select_one_category');
	end        if;
	

	if        pdel=false        and        not        is_superuser()        and        not        exists(
		select        1        from        group_category        a
		where        a.id_category        =        pid_category
		and        a.id_group        =        get_group()
		and        a.level_priviledge        >=        plevel
		and        (pstatus<>'R'        or        (select        id        from        user_info)<>0)
		and        (pstatus<>'P'        or        a.level_priviledge        >=        3)
		)        then
			raise        exception        '%|%',        cmp,        get_msg('permission_denied');
	end        if;

		
end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.get_att_extension(pfile  character  varying)
  RETURNS  character  varying
  LANGUAGE  plpgsql
  IMMUTABLE
AS  $function$
declare
	ext        varchar;
	i        int;
begin
	i:=2;
	
	loop
		ext:=split_part(pfile,        '.',        i);
		exit        when        ext='';
		i:=i+1;
	end        loop;

	ext:=lower(split_part(pfile,        '.',        i-1));
	
	if        ext='pdf'        then
		return        'pdf.png';
	elsif        ext='mm'        then
		return        'freemind.png';
	elsif        ext='docx'        then
		return        'word.png';
	elsif        ext='xlsx'        then
		return        'excel.png';
	elsif        ext='pptx'        then
		return        'powerpoint.png';
	elsif        ext='dia'        then
		return        'dia.png';
	elsif        ext='odt'	        then
		return        'writer.png';
	elsif        ext        =        'ods'then
                                                                                                                                return        'calc.png';
                                                                elsif        ext        =        'odg'        then
                                                                                                                                return        'draw.png';
                                                                elsif        ext        =        'odp'        then
                                                                                                                                return        'impress.png';
                                                                else
		return        'default.png';
	end        if;


end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.ws_get_accesses(pid_group  integer,  pdate_from  date,  pdate_to  date,  poffset  integer,  plimit  integer,  OUT  id  integer,  OUT  date  timestamp  without  time  zone,  OUT  "table"  character  varying,  OUT  table_id  integer,  OUT  action  character  varying,  OUT  addr  character  varying,  OUT  id_user  integer,  OUT  name  character  varying,  OUT  msg_action  text,  OUT  can_view  boolean)
  RETURNS  SETOF  record
  LANGUAGE  plpgsql
  STABLE
AS  $function$
declare
	sql        varchar;
	group_anon        varchar;
	can_view        varchar;
begin
	perform        check_can_use();
	perform        check_notnull_timestamp(1,        pdate_from);
	perform        check_notnull_timestamp(2,        pdate_to);

	if        pid_group        is        not        null        and        pid_group<>0        then
		perform        check_manages_group(0,        pid_group);
	end        if;

	if        exists(select        1
		from        "configuration"        a,        group_master        b
		where        a.anonymous_can_use=true
		and        a.anonymous_group        =        b.id_slave
		and        b.id_master        =        get_group())
	then
		group_anon:='        or        b.id_group        is        null)';
	else
		group_anon:=')';
	end        if;

	if        is_superuser()        then
		can_view:='exists(select        1        from        "document"        c
		where        a."table"        in        (''document'',''file_blob'')        
		and        c.active        =        true        
		and        c.id_owner        is        null        
		and        c.id        =        a.table_id)        ';
		
	else
	
		can_view:='exists(select        1        from        "document"        c,        group_category        d        
		where        a."table"        in        (''document'',''file_blob'')        
		and        c.active        =        true        
		and        c.id_owner        is        null        
		and        c.id        =        a.table_id
		and        c.id_category        =        d.id_category
		and        d.id_group        =        '||get_group()||')';

	end        if;

	
	sql:='select        a.id,a."date"::timestamp,a."table",a.table_id,a."action",        a.ip,        a."user",        b.name,get_msg(a."action"),
		'||can_view||'
	from        access_log        a
	left        join        "editor"        b        on        b.active        =        true        and        b.id        =        a."user"
	where        a."date"        between        '''||pdate_from        ||'''        and        '''||pdate_to||'''        ';

	if        pid_group        is        not        null        and        pid_group<>0        then
		sql:=sql||'        and        (b.id_group        =        '||pid_group||'        '||group_anon;
	elsif        not        is_superuser()        then
		sql:=sql||'        and        (b.id_group        =        any(select        get_managed_groups())        '||group_anon;
	end        if;

	if        plimit>200        then
		plimit:=200;
	end        if;

	sql:=sql||'        order        by        a."date"        desc        ';
	sql:=sql||'        offset        '||poffset||'        limit        '||plimit;

	return        query        execute        sql;
end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.get_old_javabean_document(extra  xml,  OUT  id  integer,  OUT  name  character  varying,  OUT  texthtml  character  varying,  OUT  status  character,  OUT  isrichtext  boolean,  OUT  id_category  integer,  OUT  level_priviledge  integer,  OUT  atts  character  varying)
  RETURNS  record
  LANGUAGE  plpgsql
  IMMUTABLE
AS  $function$
declare
	active        bool;
	xatt        xml;
	xatts        xml[];
	n        varchar;
	f        varchar;
	i        int;
	len        int;
begin

active:=coalesce((xpath('/java/object/void[@property=''active'']/boolean[1]/text()',        extra))[1]::varchar='true',        false);

if        active<>true        then
	raise        exception        '-1|%',        get_msg('permission_denied');
end        if;

id:=(xpath('/java/object/void[@property=''id'']/int[1]/text()',        extra))[1]::varchar::int;
name:=((xpath('/java/object/void[@property=''name'']/string[1]/text()',        extra))[1]::varchar);
texthtml:=((xpath('/java/object/void[@property=''texthtml'']/string[1]/text()',        extra))[1]::varchar);
status:=((xpath('/java/object/void[@property=''status'']/string[1]/text()',        extra))[1]::varchar);
isrichtext:=coalesce((xpath('/java/object/void[@property=''isrichtext'']/boolean[1]/text()',        extra))[1]::varchar='true',        false);
id_category:=(xpath('/java/object/void[@property=''idCategory'']/int[1]/text()',        extra))[1]::varchar::int;

if        is_superuser()        then
	level_priviledge:=3;
else        
	i:=id;
	level_priviledge:=coalesce((
	select        a.level_priviledge        
	from        group_category        a,        "document"        b
	where        b.id_category        =        a.id_category        
	and        a.id_group        =        get_group()
	and        b.id        =        i),        0);
end        if;


atts:='';
i:=1;
xatts:=xpath('/java/array/void',        extra);
len:=array_length(xatts,        1);
loop
	xatt:=xatts[i];

	if        i>len        or        len        is        null        then
		exit;
	end        if;
	i:=i+1;
	
	n:=(xpath('/void/object/void[@property=''name'']/string[1]/text()',        xatt))[1]::varchar;
	f:=(xpath('/void/object/void[@property=''folder'']/string[1]/text()',        xatt))[1]::varchar;

	
	if        atts=''        then
		atts:=get_att_extension(n)||';'||f||';'||n;
	else
		atts:=atts||'|'||get_att_extension(n)||';'||f||';'||n;
	end        if;
		
end        loop;

/*
"<java        version="1.8.0_25"        class="java.beans.XMLDecoder">
        <object        class="omegabase.dao.Document">
                <void        property="active">
                        <boolean>true</boolean>
                </void>
                <void        property="dateCreation">
                        <object        class="java.sql.Timestamp">
                                <long>1423260160466</long>
                        </object>
                </void>
                <void        property="dateModification">
                        <object        class="java.sql.Timestamp">
                                <long>1423260194588</long>
                        </object>
                </void>
                <void        property="id">
                        <int>1</int>
                </void>
                <void        property="idCategory">
                        <int>1</int>
                </void>
                <void        property="keywords">
                        <string>&apos;coisa&apos;:5        &apos;documento&apos;:2        &apos;eca&apos;:3        &apos;lixo&apos;:4        &apos;novo&apos;:1        &apos;podreÃ©Ã©Ã©Ã©&apos;:6</string>
                </void>
                <void        property="name">
                        <string>Novo        documento</string>
                </void>
                <void        property="numAccesses">
                        <int>3</int>
                </void>
                <void        property="status">
                        <string>P</string>
                </void>
                <void        property="texthtml">
                        <string>Eca        lixo

Coisa        podreÃ©Ã©Ã©Ã©</string>
                </void>
        </object>
        <array        class="omegabase.dao.FileBlob"        length="1">
                <void        index="0">
                        <object        class="omegabase.dao.FileBlob">
                                <void        property="active">
                                        <boolean>true</boolean>
                                </void>
                                <void        property="date">
                                        <object        class="java.sql.Timestamp">
                                                <long>1423260419338</long>
                                        </object>
                                </void>
                                <void        property="folder">
                                        <string>file</string>
                                </void>
                                <void        property="id">
                                        <int>1</int>
                                </void>
                                <void        property="idDocument">
                                        <int>1</int>
                                </void>
                                <void        property="modificationDate">
                                        <object        class="java.sql.Timestamp">
                                                <long>1423260419338</long>
                                        </object>
                                </void>
                                <void        property="name">
                                        <string>blackt_i386.exe</string>
                                </void>
                        </object>
                </void>
        </array>
</java>
*/

end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.make_copy_attachs(piddocsrc  integer,  piddocdest  integer)
  RETURNS  void
  LANGUAGE  plpgsql
AS  $function$
begin
	insert        into        file_blob        (name,        date,        id_document,        blob,        folder,        keywords,modification_date,        active)
	select        a.name,        now(),        piddocdest,        a.blob,        a.folder,        a.keywords,        now(),        true
	from        file_blob        a
	where        a.id_document=        piddocsrc
	and        a.active        =        true;

end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.make_empty_document(OUT  id  integer,  OUT  isrichtext  boolean,  OUT  status  character,  OUT  level_priviledge  integer,  OUT  name  character  varying)
  RETURNS  record
  LANGUAGE  plpgsql
AS  $function$
begin
	perform        check_can_use();

	insert        into        "document"        (active,        date_creation,        date_modification,        num_accesses,        isrichtext,        status,        name,        texthtml,        id_owner)        
	values        (false,now(),now(),        0,        false,        'E',        get_msg('new_document'),        '',        nullif(get_user(),        0));
	
	id:=currval('document_id_seq');
	isrichtext:=false;
	status:='E';
	level_priviledge:=3;
	name:=get_msg('new_document');
end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.syncro_check_file(pid_category  integer,  pstatus  character,  psource  character  varying,  pdatem  timestamp  without  time  zone,  OUT  id_doc  integer,  OUT  id_file  integer,  OUT  need_upload  boolean)
  RETURNS  record
  LANGUAGE  plpgsql
  STABLE
AS  $function$
declare
	dt        timestamp;
begin

	if        pstatus='R'        then
		select        into        id_doc,        id_file,        dt
		a.id_document,        a.id,        a.modification_date        from        file_blob        a,        document        b
		where        a.id_document        =        b.id
		and        a.active        =        true
		and        b.active        =        true
		and        a.source        =        psource
		and        b.status        =        'R';
	else
		select        into        id_doc,        id_file,        dt
		a.id_document,        a.id,        a.modification_date        from        file_blob        a,        document        b
		where        a.id_document        =        b.id
		and        a.active        =        true
		and        b.active        =        true
		and        a.source        =        psource
		and        b.id_category        =        pid_category;
	end        if;

	if        found        then
		need_upload:=dt<pdatem;
	else
		need_upload:=true;
	end        if;
	

end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.ws_auto_new_user(plogin  character  varying,  puser  character  varying,  ppass  character  varying,  ppass2  character  varying,  OUT  id  integer,  OUT  name  character  varying,  OUT  id_group  integer)
  RETURNS  record
  LANGUAGE  plpgsql
AS  $function$
begin
	perform        check_can_inscribe();
	perform        check_login(0,        plogin);
	perform        check_name(1,        puser);
	perform        check_password(2,        3,        ppass,        ppass2);

	select        into        id_group
	anonymous_inscribe_group        from        "configuration"        limit        1;

	        
	insert        into        "editor"(name,        id_group,        login,        password,        active)        values        (
	puser,        
	$7,
	lower(plogin),
	md5(ppass),
	true);

	id:=currval('editor_id_seq');
	name:=puser;

	update        user_info                set
		id        =        $5;
		

	insert        into        access_log("action",        "table",        table_id)        values        (
	'save',
	'editor',
	id);
end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.ws_delete_comment(pidcomm  integer)
  RETURNS  void
  LANGUAGE  plpgsql
AS  $function$
begin
	perform        check_can_use();
	perform        check_can_comment2(pidcomm);

	insert        into        access_log("action",        "table",        table_id,        extra)        values(
	'delete',        'user_coment',        pidcomm,        
	xmlelement(name        user_comment,
		query_to_xml('select        *        from        user_comment        where        id        =        '||pidcomm,        false,        false,        '')
	));

	delete        from        user_comment        where        id        =        pidcomm;
end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.ws_get_comments(piddoc  integer,  OUT  id  integer,  OUT  msg  character  varying,  OUT  id_user  integer,  OUT  name_user  character  varying,  OUT  date  timestamp  without  time  zone,  OUT  level_priviledge  integer)
  RETURNS  SETOF  record
  LANGUAGE  plpgsql
  STABLE
AS  $function$
declare
	is_adm        bool;
	lvl        int;
begin
	perform        check_can_use();
	perform        check_can_comment(piddoc);

	is_adm:=is_superuser();

	if        is_adm        then
		return        query        select        a.id,        a.msg::varchar,        a.id_user,        b.name,        a.date_comm,        3
		from        user_comment        a
		left        join        "editor"        b        on        a.id_user        =        b.id        and        b.active        =        true
		where        a.id_document        =        piddoc
		order        by        a.date_comm        desc        nulls        last;
	else        
		lvl:=(select        a.level_priviledge        
			from        group_category        a,        "document"        b
			where        b.id_category        =        a.id_category
			and        a.id_group        =        get_group()
			and        b.id        =        piddoc);
		
		return        query        select        a.id,        a.msg::varchar,        a.id_user,        b.name,        a.date_comm,        lvl
		from        user_comment        a
		left        join        "editor"        b        on        a.id_user        =        b.id        and        b.active        =        true
		where        a.id_document        =        piddoc
		order        by        a.date_comm        desc        nulls        last;

	end        if;
end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.ws_search(ptext  character  varying,  pid_category  integer,  pstatus  character,  poff  integer,  plimit  integer,  OUT  id  integer,  OUT  name  character  varying,  OUT  attachs  character  varying,  OUT  level_priviledge  integer,  OUT  status  character,  OUT  id_category  integer,  OUT  name_category  character  varying,  OUT  foundtxt  boolean,  OUT  can_comment  boolean)
  RETURNS  SETOF  record
  LANGUAGE  plpgsql
AS  $function$
declare
	sql        varchar;
	sqlkeys        varchar;
	sqlftxt        varchar;
	nkeys        varchar;
	idgroup        int;
	blobs        int[];
begin
	perform        check_can_use();

	if        ptext        is        null        or        trim(ptext)=''        then
		sqlkeys:='false';
		sqlftxt:='false';
		nkeys:=null;
	else
		nkeys:=replace(plainto_tsquery('simple',        ptext)::varchar,'        &        ',        '        |        ');
		sqlkeys:='case        when        b.keywords        is        not        null        and        b.keywords        @@        '||quote_nullable(nkeys)||'::tsquery        then        true        else        false        end        ';
		sqlftxt:='to_tsvector(''simple'',        a.name||''        ''||a.texthtml)        @@        '||quote_nullable(nkeys)||'::tsquery        ';
	end        if;
	
	sql:='select        a.id,        a.name,        
		array_to_string(array(select        b.id||'';''||get_att_extension(b.name)||'';''||'||sqlkeys||'||'';''||b.name        
			from        file_blob        b        
			where        b.id_document        =        a.id        
			and        b.active        =        true        
			and        b.folder        =        ''file''
			order        by        b.date        desc        nulls        last
		),        ''|'')::varchar,';
		

	if        is_superuser()        then
		sql:=sql||'3,        a.status,        a.id_category,        d.name,        '||sqlftxt||',true
		from        "document"        a        ';
	else
		idgroup:=get_group();
		
		sql:=sql||'case        when        a.status=''P''        and        c.level_priviledge=2        then        1        else        c.level_priviledge        end,        a.status,        a.id_category,        d.name,        '||sqlftxt||',c.can_comment
		from        "document"        a
		inner        join        group_category        c        on        a.id_category        =        c.id_category        and        c.id_group        =        '||idgroup||'        ';
		
	end        if;

	sql:=sql||'        inner        join        category        d        on        a.id_category        =        d.id        ';

	sql:=sql||'        where        a.active        =        true        and        d.active        =        true
		and        (a.status<>''R''        or        a.id_owner        =        '||(select        a.id        from        user_info        a        limit        1)||')        ';
	

	if        ptext        is        not        null        and        trim(ptext)<>''        then
	
		blobs:=array(select        distinct        id_document        from        file_blob        f        
		where        f.active        =        true        
		and        f.keywords        is        not        null        
		and        f.keywords        @@        plainto_tsquery('simple',        quote_nullable(ptext)));

		
		sql:=sql||
		'        and        (to_tsvector(''simple'',        a.name||''        ''||a.texthtml)        @@        plainto_tsquery(''simple'',        '||quote_nullable(ptext)||')        
			'||case        when        array_length(blobs,        1)        is        null        then        ''        else        '        or        a.id        in        ('||array_to_string(blobs,        ',')||')        '        end||')';
	

		
	end        if;

	if        pid_category        is        not        null        and        pid_category<>0        then
		sql:=sql||'        and        a.id_category        =        '||pid_category;
	end        if;

	if        pstatus        is        not        null        and        pstatus<>''        and        pstatus<>'        '        then
		sql:=sql||'        and        a.status        =        '||quote_literal(pstatus);
	end        if;

	if        pstatus        is        not        null        and        pstatus='R'        then
		sql:=sql||'        and        a.id_owner        =        '||(select        a.id        from        user_info        a        limit        1);
	end        if;

	if        poff        is        null        or        poff<0        then
		poff:=0;
	end        if;

	if        plimit        is        null        or        plimit<0        then
		plimit:=0;
	end        if;

	if        plimit>500        then
		plimit:=500;
	end        if;

	sql:=sql||'        order        by        a.num_accesses        desc        nulls        last        ';

	if        pstatus<>'R'        then
		sql:=sql||'        limit        '||plimit||'        offset        '||poff;
	end        if;

	return        query        execute        sql;

	insert        into        access_log("action",        "table",        extra)
	values('search',        'document',
	xmlelement(name        search,
		xmlelement(name        category,        pid_category),
		xmlelement(name        status,pstatus),
		xmlelement(name        offset,        poff),
		xmlelement(name        limit,        plimit),
		xmlelement(name        text,        ptext)
	));
end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.ws_get_old_document(pidac  integer,  plevel  integer,  OUT  id  integer,  OUT  name  character  varying,  OUT  texthtml  character  varying,  OUT  status  character,  OUT  isrichtext  boolean,  OUT  id_category  integer,  OUT  level_priviledge  integer,  OUT  atts  character  varying,  OUT  category_name  character  varying)
  RETURNS  record
  LANGUAGE  plpgsql
AS  $function$
declare
	extr        xml;
	xdoc        xml;
	xatts        xml[];
	vs        int[];
	i        int;
	rec        record;
begin
	perform        check_can_use();
	perform        check_old_document(-1,        pidac,        plevel);

	
	select        into        extr
	a.extra        from        access_log        a
	where        a.id        =        pidac;

	

	if        array_length(xpath('/document/doc/table/row',        extr),        1)        is        null        then
		select        into        id,        name,        texthtml,        status,        isrichtext,        id_category,        level_priviledge,        atts
		*        from        get_old_javabean_document(extr,        plevel);
		return;
	end        if;

	xdoc:=(xpath('/document/doc/table/row',        extr))[1];
	id:=(xpath('/document/doc/table/row/id/text()',        extr))[1]::varchar::int;
	
	name:=make_unxml((xpath('name/text()',        xdoc))[1]::varchar);
	texthtml:=make_unxml((xpath('texthtml/text()',        xdoc))[1]::text);
	status:=(xpath('status/text()',        xdoc))[1]::varchar;
	isrichtext:=(xpath('isrichtext/text()',        xdoc))[1]::varchar::bool;
	id_category:=(xpath('id_category/text()',        xdoc))[1]::varchar::int;
	category_name:=(select        a."name"        from        category        a        where        a.id        =        id_category        and        a.active=true);

	if        is_superuser()        then
	level_priviledge:=3;
	else
	level_priviledge:=(
		select        a.level_priviledge        
		from        group_category        a,        "document"        b        
		where        b.id_category        =        a.id_category
		and        a.id_group        =        get_group()
		and        b.id        =        $1);
	end        if;

	atts:='';
	vs:=array[]::int[];
	xatts:=xpath('/document/attachs/table/row/id/text()',        extr);
	i:=1;

	if        array_length(xatts,1)        is        not        null        then
	loop
		exit        when        i>array_length(xatts,        1);
		vs:=vs||xatts[i]::varchar::int;
		i:=i+1;
	end        loop;
	end        if;

	for        rec        in
	select        a.id,        a.name,        a.folder        from        file_blob        a
	where        a.id        =        any(vs)
	order        by        a.date        desc
	loop
		if        atts=''        then
			atts:=get_att_extension(rec.name)||';'||rec.folder||';'||rec.name;
		else
			atts:=atts||'|'||get_att_extension(rec.name)||';'||rec.folder||';'||rec.name;
		end        if;
		
	end        loop;

	insert        into        access_log("table",        table_id,        "action")        
	values('document',        id,        case        plevel=1        when        true        then        'view_old'        else        'tryedit_old'        end);

end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.ws_save_my_info(pname  character  varying,  pold_pass  character  varying,  pnew_pass  character  varying,  pnew_pass2  character  varying)
  RETURNS  void
  LANGUAGE  plpgsql
AS  $function$
begin
	perform        check_can_use();
	perform        check_logged();
	perform        check_name(0,        pname);

	if        pnew_pass        is        not        null        and        pnew_pass<>''        then
		perform        check_password(2,        3,        pnew_pass,        pnew_pass2);

		update        "editor"        set        
		name        =        pname,
		"password"        =        md5(pnew_pass)
		where        id        =        (select        b.id        from        user_info        b        limit        1)
		and        active        =        true
		and        "password"        =        md5(pold_pass);
	else
		update        "editor"        set        
		name        =        pname
		where        id        =        (select        b.id        from        user_info        b        limit        1)
		and        active        =        true
		and        "password"        =        md5(pold_pass);
		
	end        if;

	if        not        found        then
		raise        exception        '1|%',        get_msg('wrong_password');
	end        if;

	insert        into        access_log("action",        "table",        table_id)        values
	('change',        'editor',        (select        id        from        user_info        limit        1));
	
end;
$function$
; 
 CREATE  OR  REPLACE  FUNCTION  public.ws_save_group(pid  integer,  pname  character  varying,  padm_groups  boolean,  padm_users  boolean,  pslaves  character  varying,  pcategories  character  varying,  OUT  group_id  integer)
  RETURNS  integer
  LANGUAGE  plpgsql
AS  $function$
declare
	slaves        varchar[];
	categories        varchar[];
	str        varchar;
begin
	perform        check_can_use();
	perform        check_superuser();
	perform        check_name(1,        pname);
	perform        check_notnull_varchar(4,        pslaves);
	perform        check_notnull_varchar(5,        pcategories);

	padm_groups:=check_bool(padm_groups);
	padm_users:=check_bool(padm_users);


	slaves:=string_to_array(pslaves,        '|');
	categories:=string_to_array(pcategories,        '|');

	if        pid        is        not        null        and        pid<>0        then
		update        "group"        set
		name        =        pname,
		perm_administrator_groups        =        padm_groups,
		perm_administrator_users        =        padm_users
		where        id        =        pid        and        active        =        true;

		if        not        found        then
			return;
		end        if;
		
		group_id:=pid;
		delete        from        group_master        where        id_master        =        pid;
		delete        from        group_category        where        id_group        =        pid;
	else
		insert        into        "group"        
		(name,        perm_administrator_groups,        perm_administrator_users,        active)        values        
		(pname,        padm_groups,        padm_users,        true);

		group_id:=currval('group_id_seq');

		
	end        if;


	if        padm_users=true        and        padm_groups=false        then
		for        str        in        select        unnest(slaves)
		loop
			insert        into        group_master(id_master,        id_slave)        values
			(group_id,        str::int);
	
		end        loop;
	end        if;

	if        padm_groups=false        then
		for        str        in        select        unnest(categories)
		loop
			if        split_part(str,        ';',        2)::int        in        (1,2,3)        then
				insert        into        group_category(id_group,id_category,level_priviledge,can_comment)        values
				(group_id,        split_part(str,        ';',        1)::int,        split_part(str,        ';',        2)::int,        split_part(str,        ';',        3)='t');
			end        if;
		end        loop;
	end        if;

	insert        into        access_log("action",        table_id,        "table",        extra)        values
	('save',        group_id,        'group',        
	xmlelement(name        group,
	xmlelement(name        group,
		query_to_xml('select        *        from        "group"        where        id        =        '||group_id,        false,        false,        '')
	),        xmlelement(name        group_category,
		query_to_xml('select        *        from        group_category        where        id_group        =        '||group_id,        false,        false,        '')
	),        xmlelement(name        group_master,
		query_to_xml('select        *        from        group_master        where        id_master        =        '||group_id,        false,        false,        '')
	)));
		
		
end;
$function$
; 
alter table access_log alter column date set default now();

alter table access_log alter column ip set default get_addr();

alter table access_log alter column "user" set default get_user();

