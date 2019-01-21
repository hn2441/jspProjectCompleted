create table service(
     serviceID  serial primary key,
     title varchar(50),
    email varchar(50),
    pw varchar(15),
     tm   TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
     content varchar(2048)
   );

insert into service(title,email,pw,content)values('로그인 비밀번호를 잃어버렸습니다??','qwe132@daum.net','1234','로그인 여러번 틀려서 연속적으로 틀려서 계속 실패라고 뜹니다.');
insert into service(title,email,pw,content)values('탈퇴후에도 재가입 할수 있나요??','ho@naver.com','58@#96','제가 탈퇴를 했는데 다시 가입을 하고싶습니다.');
insert into service(title,email,pw,content)values('불량 판매자를 신고합니다..','qwe1326@daum.net','yuir$90','입금을 했는데 판매자는 연락을 안합니다.');
insert into service(title,email,pw,content)values('어떤식으로 판매를 할수 있나요??','nam@google.com','rty@#8569','판매가 어떤식으로 있는지 궁금합니다.');
insert into service(title,email,pw,content)values('어떤종류가 있나요??','female55@daum.net','vbghu&%856','어떤종류가 있는지 그리고 어떤식으로 구매할수 있는지 궁금합니다.');
