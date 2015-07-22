set local omega.id='2|0|127.0.0.1|pt_BR';

select * from ws_save_document('eca',false, 'eeec2a', 2, 1, 'N', false);
select * from ws_save_document('eca',false, 'eeec2a', 2, 2, 'N', false);
select * from ws_save_document('eca',false, 'eeec2a', 2, 3, 'N', false);

select * from ws_save_document('eca',false, 'eeec2a', 2, 1, 'P', false);
select * from ws_save_document('eca',false, 'eeec2a', 2, 2, 'P', false);
select * from ws_save_document('eca',false, 'eeec2a', 2, 3, 'P', false);