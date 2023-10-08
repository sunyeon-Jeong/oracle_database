-- 테이블생성
--------------------------------------------------------------------------------
SET FEEDBACK 1
SET NUMWIDTH 10
SET LINESIZE 80
SET TRIMSPOOL ON
SET TAB OFF
SET PAGESIZE 100
SET ECHO OFF

create table regions (
    region_id number constraint region_id_nn not null,
    region_name varchar2(25)
);

create unique index reg_id_pk on regions (region_id);

alter table regions add (
    constraint reg_id_pk primary key (region_id)
);
--------------------------------------------------------------------------------
create table countries (
    country_id char(2) constraint country_id_nn not null,
    country_name varchar2(40),
    region_id number,
    constraint country_c_id_pk primary key (country_id)
) organization index;

alter table countries add (
    constraint country_reg_fk foreign key (region_id) references regions (region_id)
);
--------------------------------------------------------------------------------
create table locations (
    location_id number(4),
    street_address varchar2(40),
    postal_code varchar2(12),
    city varchar2(30) constraint loc_city_nn not null,
    state_province varchar2(25),
    country_id char(2)
);

create unique index loc_id_pk on locations (location_id);

alter table locations add (
    constraint loc_id_pk primary key (location_id),
    constraint loc_c_id_fk foreign key (country_id) references countries (country_id)
);
--------------------------------------------------------------------------------
CREATE SEQUENCE locations_seq
    START WITH 3300
    INCREMENT BY 100
    MAXVALUE 9900
    NOCACHE
    NOCYCLE;
--------------------------------------------------------------------------------
create table departments (
    department_id number(4),
    department_name varchar2(30) constraint dept_name_nn not null,
    manager_id number(6),
    location_id number(4)
);

create unique index dept_id_pk on departments (department_id);

alter table departments add (
    constraint dept_id_pk primary key (department_id),
    constraint dept_loc_fk foreign key (location_id) references locations (location_id)
);
--------------------------------------------------------------------------------
CREATE SEQUENCE departments_seq
    START WITH 280
    INCREMENT BY 10
    MAXVALUE 9990
    NOCACHE
    NOCYCLE;
--------------------------------------------------------------------------------
create table jobs (
    job_id varchar2(10),
    job_title varchar2(35) constraint job_title_nn not null,
    min_salary number(6),
    max_salary number(6)
);

create unique index job_id_pk on jobs (job_id);

alter table jobs add (
    constraint job_id_pk primary key (job_id)
);
--------------------------------------------------------------------------------
create table employees (
    employee_id number(6),
    first_name varchar2(20),
    last_name varchar2(25) constraint emp_last_name_nn not null,
    email varchar2(25) constraint emp_emil_nn not null,
    phone_number varchar2(20),
    hire_date date constraint emp_hire_date_nn not null,
    job_id varchar2(10) constraint emp_job_nn not null,
    salary number(8, 2),
    commission_pct number(2, 2),
    manager_id number(6),
    department_id number(4),
    constraint emp_salary_min check (salary > 0),
    constraint emp_email_uk unique (email)
);

create unique index emp_emp_id_pk on employees (employee_id);

alter table employees add (
    constraint emp_emp_id_pk primary key (employee_id),
    constraint emp_dept_fk foreign key (department_id) references departments,
    constraint emp_job_fk foreign key (job_id) references jobs (job_id),
    constraint emp_manager_fk foreign key (manager_id) references employees
);

alter table departments add (
    constraint dept_mgr_fk foreign key (manager_id) references employees (employee_id)
);
--------------------------------------------------------------------------------
CREATE SEQUENCE employees_seq
    START WITH 207
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;
--------------------------------------------------------------------------------
create table job_history (
    employee_id number(6) constraint jhist_employee_nn not null,
    start_date date constraint jhist_start_date_nn not null,
    end_date date constraint jhist_end_date_nn not null,
    job_id varchar2(10) constraint jhist_job_nn not null,
    department_id number(4),
    constraint jhist_date_interval check (end_date > start_date)
);

create unique index jhist_emp_id_st_date_pk on job_history (employee_id, start_date);

alter table job_history add (
    constraint jhist_emp_id_st_date_pk primary key (employee_id, start_date),
    constraint jhist_job_fk foreign key (job_id) references jobs,
    constraint jhist_emp_fk foreign key (employee_id) references employees,
    constraint jhist_dept_fk foreign key (department_id) references departments
);

commit;