create table patient (
  patient_id int primary key,
  name varchar(50) not null,
  gender varchar(10) check (gender in ('M', 'F')) not null,
  dob date,
  email varchar(50) unique,
  phone varchar(15),
  address varchar(100),
  username varchar(20) not null unique,
  password varchar(20) not null
);

create table doctor (
  doctor_id int primary key,
  name varchar(50) not null,
  specialization varchar(50) not null,
  username varchar(20) not null unique,
  password varchar(20) not null
);

create table appointment (
  appointment_id int primary key,
  appointment_date date not null,
  appointment_time timestamp not null,
  status varchar(20) default 'booked' check (status in ('booked', 'completed', 'cancelled')) not null,
  clinic_number int not null,
  patient_id int references patient(patient_id),
  doctor_id int references doctor(doctor_id)
);

create table prescription (
  prescription_id int primary key,
  prescription_date date not null,
  doctor_advice varchar(255),
  patient_id int references patient(patient_id),
  doctor_id int references doctor(doctor_id),
  followup_required int default 0 check (followup_required in (0, 1)) not null
);

create table invoice (
  invoice_id int primary key,
  invoice_date date not null,
  amount float(2) not null,
  payment_status varchar(20) default 'unpaid' check (payment_status in ('paid', 'unpaid', 'refunded')) not null,
  payment_method varchar(20) check (payment_method in ('cash', 'card')) not null,
  patient_id int references patient(patient_id)
);

create table tests (
  test_id int primary key,
  test_type varchar(50) not null
);

-- creating patient data
insert into patient values (1, 'Hassan', 'M', '12-05-1991', 'hassan.khan@gmail.com', '03124567890', '12 Garden Street, Lahore', 'hassan_k', 'pass@123');
insert into patient values (2, 'Ayesha', 'F', '23-08-1993', 'ayesha.malik@yahoo.com', '03215678901', '44 Model Town, Karachi', 'ayesha_m', 'secure@456');
insert into patient values (3, 'Bilal', 'M', '15-11-1987', 'bilal.ahmed@hotmail.com', '03331234567', '89 Jinnah Road, Islamabad', 'bilal_a', 'bilal#789');
insert into patient values (4, 'Zara', 'F', '07-03-1996', 'zara.shaikh@gmail.com', '03457890123', '21 Canal View, Faisalabad', 'zara_s', 'zara!321');
insert into patient values (5, 'Usman', 'M', '29-09-1990', 'usman.rashid@outlook.com', '03561239876', '67 Clifton Block 5, Karachi', 'usman_r', 'usman@999');

-- DML QUERIES

-- (a):
update patient set email = 'ayedha23@mail.com', phone = '1111111111' where patient_id = 2;

-- (b):
insert into invoice values (1, '01-01-2025', 350.00, 'unpaid', 'card', 1);
update invoice set payment_status = 'paid' where invoice_id = 1;

-- (c):
insert into doctor values (1, 'Dr. Ahmed Khan', 'Orthopedics', 'drahmed', 'orthop@123');
insert into doctor values (2, 'Dr. Fatima Malik', 'Dermatology', 'drfatima', 'skin@456');
insert into appointment values (1, '10-10-2025', TO_TIMESTAMP('10-10-2025 10:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'scheduled', 101, 1, 1);
insert into appointment values (2, '10-11-2025', TO_TIMESTAMP('10-11-2025 11:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'scheduled', 102, 2, 2);
insert into appointment values (3, '10-12-2025', TO_TIMESTAMP('10-12-2025 12:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'cancelled', 103, 3, 1);
delete from appointment where status = 'cancelled';

-- (d):
insert into invoice values (4, '25-10-2025', 250.00, 'refunded', 'cash', 4);
delete from invoice where payment_status = 'refunded';

-- (e):
select * from appointment where status = 'booked'; 

-- (f):
select * from invoice where payment_status = 'unpaid';

-- (g):
insert into tests values (1, 'Blood Test');
insert into tests values (2, 'X Ray');
insert into tests values (3, 'MRI');
insert into tests values (4, 'CT Scan');
select * from tests where test_type like 'Blood Test';

-- (h):
select * from prescription where prescription_date = '09-02-2025'; --format is mm-dd-yyyy


-- ADVANCED SQL

-- (a):
select p.name as patient_name, d.name as doc_name from appointment a
join patient p on a.patient_id = p.patient_id
join doctor d on a.doctor_id = d.doctor_id;

-- (b):
select p.name as patient_name, t.test_type as test_type, d.name as Doc_name from prescription pr
join patient p on pr.patient_id = p.patient_id
join doctor d on pr.doctor_id = d.doctor_id
join tests t on pr.test_id = t.test_id;

-- (c):
select pr.* from prescription pr
join patient p on pr.patient_id = p.patient_id
where p.name like 'Ali Khan';

-- (d):
select d.name, pr.* from doctor d
join prescription pr on d.doctor_id = pr.doctor_id
where pr.followup_required = 1;
