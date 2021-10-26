-- Table for job table in aktin
create table aktin.jobtable_test(
  fall_nummer varchar, -- irgendwann primary key und foreign key die aus aktin_copra zeigt
  retrievaldate timestamp, -- zeitangabe in trigger zum import
  trigger_type varchar, --event (insert or update)
  event_user varchar -- user
);
