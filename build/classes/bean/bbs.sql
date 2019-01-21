create table bbs(
num serial,
title varchar(50),
write varchar(5000),
id varchar(20),
id2 varchar(20),
date varchar(20),
view integer
);

create table bbsanswer(
num integer,
title varchar(10000),
write varchar(10000),
id2 varchar(20),
date varchar(20)
);

게시판 원글 insert
insert into bbs (title, write, id, id2, date, view) values('1','1<br>2<br>3<br>','null','','2019-01-17','2');
insert into bbs (title, write, id, id2, date, view) values('2','왜 안돼지','null','','2019-01-17','1');
insert into bbs (title, write, id, id2, date, view) values('3','33123','null','','2019-01-17','8');
insert into bbs (title, write, id, id2, date, view) values('이거','어떻게 하는거죠','null','','2019-01-17','8');
insert into bbs (title, write, id, id2, date, view) values('아','왜 안돼지','null','','2019-01-17','1');
insert into bbs (title, write, id, id2, date, view) values('왜이래','왜이래 도데ㅐ체','null','','2019-01-17','0');
insert into bbs (title, write, id, id2, date, view) values('2134213','12341234','null','','2019-01-17','0');
insert into bbs (title, write, id, id2, date, view) values('뭘까','왜 이런거지?','null','','2019-01-17','0');
insert into bbs (title, write, id, id2, date, view) values('제발!','두근','null','','2019-01-17','0');
insert into bbs (title, write, id, id2, date, view) values('4123','12342134ㅁ','null','','2019-01-17','0');
insert into bbs (title, write, id, id2, date, view) values('1235','125213','null','','2019-01-17','2');
insert into bbs (title, write, id, id2, date, view) values('아무거나','ㅁㄴㅇㅎㄴㅁㅇ','null','','2019-01-17','3');