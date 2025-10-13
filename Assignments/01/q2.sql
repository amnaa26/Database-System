-- databse Design using DDL
create table members(
  memberID int primary key,
  name varchar(20),
  email varchar(30) unique,
  joindate date deafult current_date
);

create table books(
  bookID int primary key,
  title varchar(20),
  author varchar(20),
  copiesAvailable int check (copiesAvailable >= 0)
);

create table issuedBooks(
  issueID int primary key,
  memberID int references members(memberID),
  bookID references books(bookID),
  issueDate date default current_date,
  returnDate date
);

-- database catalog design
create table relations (
  relation_name varchar(100) primary key,
  no_of_columns int not null
);

create table relation_columns (
  column_name varchar(100),
  data_type varchar(50),
  belongs_to_relation varchar(100) references relations(relation_name),
  constraints varchar(100),
  primary key (column_name, belongs_to_relation)
);

insert into relations values ('members', 4);
insert into relations values ('books', 4);
insert into relations values ('issuedBooks', 5);

insert into relation_columns values ('memberId', 'int', 'members', 'primary key');
insert into relation_columns values ('name', 'varchar(20)', 'members', 'unique');
insert into relation_columns values ('email', 'varchar(30)', 'members', '');
insert into relation_columns values ('joinDate', 'date', 'members', 'default current_date');

insert into relation_columns values ('bookId', 'int', 'books', 'primary key');
insert into relation_columns values ('title', 'varchar(20)', 'books', '');
insert into relation_columns values ('author', 'varchar(20)', 'books', '');
insert into relation_columns values ('copiesAvailable', 'int', 'books', 'check (copiesAvailable >= 0)');

insert into relation_columns values ('issueId', 'int', 'issuedBooks', 'primary key');
insert into relation_columns values ('memberId', 'int', 'issuedBooks', 'foreign key references members(memberId)');
insert into relation_columns values ('bookId', 'int', 'issuedBooks', 'foreign key references books(bookId)');
insert into relation_columns values ('issueDate', 'date', 'issuedBooks', 'default current_date');
insert into relation_columns values ('returnDate', 'date', 'issuedBooks', '');

-- dml queries for daily operations
insert into members (memberId, name, email) values (1, 'Alex', 'alex12@mail.com');
insert into members (memberId, name, email) values (2, 'David', 'david_23@mail.com');
insert into members (memberId, name, email) values (3, 'Charlie', 'charlie26@mail.com');

insert into books values (111, 'Book 1', 'Author 1', 3);
insert into books values (112, 'Book 2', 'Author 2', 2);
insert into books values (113, 'Book 3', 'Author 3', 1);

insert into issuedBooks (issueId, memberId, bookId) values (1, 1, 111);
update books set copiesAvailable = copiesAvailable - 1 where bookId = 111;

select m.name, b.title, i.issueDate from members m left join issuedBooks i on m.memberId = i.memberId left join books b on i.bookId = b.bookId;

-- constraint violation demonstration
insert into members (memberId, name, email) values (1, 'James', 'jamie12@mail.com');
insert into issuedBooks (issueId, memberId, bookId) values (2, 4, 112);
update books set copiesAvailable = -1 where bookId = 113;

-- critical thinking
-- 1. Add a fine management system for overdue books.
-- 2. Implement book reservation so members can reserve books currently unavailable.

-- nested queries

-- (a):
select * from members m where not exists (select 1 from issuedBooks ib where m.memberId = ib.memberId);

--(b):
select * from books b where b.copiesAvailable = (select max(copiesAvailable) from books);

-- (c):
select activeMember.name from (
  select m.name, count(ib.issueId) as booksIssued from members m
  join issuedBooks ib on m.memberId = ib.memberId
  group by m.name
  order by booksIssued desc
) activeMemeber where ROWNUM = 1;

-- (d):
select b.title from books b where not exists (
  select 1 from issuedBooks ib where b.bookId = ib.bookId
);

-- (e):
select distinct m.memberID, m.name, ib.issueDate from members m
join issuedBooks ib on m.memberID = ib.memberID where ib.returnDate is null and ib.issueDate < (CURRENT_DATE - INTERVAL '30 days');
