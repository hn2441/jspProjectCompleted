create table seller(
mㅑd varchar(20) references member(id),
bank varchar(20),
acc varchar(20)
);

insert into seller values('admin@naver.com','국민','0101001101010');