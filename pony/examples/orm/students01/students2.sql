drop table if exists Faculties;
drop table if exists Departments;
drop table if exists Groups;
drop table if exists Zach;
drop table if exists Students;
drop table if exists Subjects;
drop table if exists Exams;
drop table if exists Group_Subject;

create table Faculties(
  fnum integer primary key,
  fname varchar(50) not null
);

insert into Faculties values (1, 'Приборостроения');
insert into Faculties values (4, 'Вычислительных систем');

create table Departments(
  number integer primary key,
  name varchar(50) not null,
  fnum integer not null references Faculties(fnum)
);

insert into Departments values (11, 'Кафедра 1', 1);
insert into Departments values (33, 'Кафедра 2', 4);
insert into Departments values (44, 'Кафедра 3', 4);

create table Groups(
  grnum varchar(6),
  dep integer references Departments(number),
  speciality integer not null,
  primary key(grnum, dep)
);

insert into Groups values ('4145', 44, '230001');
insert into Groups values ('4146', 44, '230001');
insert into Groups values ('3132', 33, '230002');

create table Students(
  id integer primary key,
  fio varchar(50) not null,
  passport integer unique not null,
  group_grnum varchar(6) not null,
  group_dep integer not null,
  stipendy integer not null default 0,
  foreign key (group_grnum, group_dep) references Groups(grnum, kaf)
);

insert into Students values(101, 'Иванов А.Б.', 111, '4145', 44, 0);
insert into Students values(102, 'Петров В.Г', 222, '4145', 44, 800);
insert into Students values(103, 'Сидоров Д.Е', 333, '4145', 44, 0);
insert into Students values(104, 'Васильев П.Ф.', 444, '3132', 33, 500);
insert into Students values(105, 'Степанов Д.Ю.', 555, '3132', 33, 1000);

create table Zach(
  number varchar(10) primary key,
  student integer unique references Students(id)
);
insert into Zach values('z-001', 101);
insert into Zach values('z-002', 102);
insert into Zach values('z-003', 103);

create table Subjects(
  name varchar(50) primary key
);

insert into Subjects values('Физика');
insert into Subjects values('Химия');
insert into Subjects values('Математика');

create table Group_Subject(
  group_grnum varchar(6) not null,
  group_dep integer not null,
  subject varchar(50) not null references Subjects(name),
  primary key (group_grnum, group_dep, subject),
  foreign key (group_grnum, group_dep) references Groups(grnum, dep)
);

insert into Group_Subject values('4145', 44, 'Физика');
insert into Group_Subject values('4145', 44, 'Химия');
insert into Group_Subject values('4145', 44, 'Математика');
insert into Group_Subject values('3132', 33, 'Физика');
insert into Group_Subject values('3132', 33, 'Математика');

create table Exams(
  id integer primary key,
  student integer not null references Students(number),
  subject varchar(50) not null references Subjects(name),
  value integer not null,
  unique (student, subject)
);

insert into Exams values (1, 101, 'Физика', 4);
insert into Exams values (2, 101, 'Математика', 3);
insert into Exams values (3, 102, 'Химия', 5);
insert into Exams values (4, 103, 'Физика', 2);
insert into Exams values (5, 103, 'Химия', 4);