drop table if exists department;
create table department (
	dept_no char(10) primary key,
	dept_name varchar(100) not null
);

drop table if exists employees;
create table employees (
	emp_no int primary key,
	emp_title_id char(10),
	birth_date date not null,
	first_name varchar(50) not null,
	last_name varchar(50) not null,
	sex char(1) not null,
	hire_date date not null
);

drop table if exists dept_emp;
create table dept_emp (
	emp_no int not null,
	dept_no char(50) not null,
	foreign key (emp_no) references employees (emp_no),
	foreign key (dept_no) references department (dept_no),
	primary key (emp_no, dept_no)	
);

drop table if exists salaries;
create table salaries (
	emp_no int not null,
	salary int not null,
	foreign key (emp_no) references employees (emp_no),
	primary key (emp_no)
);

drop table if exists titles;
create table titles (
	title_id char(10),
	title varchar(50)
);

drop table if exists dept_manager;
create table dept_manager (
	dept_no char(50) not null,
	emp_no int not null,
	foreign key (dept_no) references department (dept_no),
    foreign key (emp_no) references employees (emp_no),
    primary key (dept_no, emp_no)
);


----list employee number, last name, first name, sex and salary
select e.emp_no, e.last_name, e.first_name, e.sex, s.salary
from employees e
inner join salaries s on e.emp_no = s.emp_no;

----list first name, last name, hire date in 1986
select first_name, last_name, hire_date
from employees
where hire_date between '01-01-1986' and '12-31-1986';

----list manager with department number. department name, employee number, last and first name
select dm.dept_no, d.dept_name, dm.emp_no, e.first_name, e.last_name
from dept_manager dm 
inner join department d on dm.dept_no = d.dept_no 
inner join employees e on e.emp_no = e.emp_no ;

----list department number for each employee with employee number, last name, first name and department name
select de.dept_no, e.emp_no, e.last_name, e.first_name, d.dept_name
from dept_emp de 
inner join employees e on de.emp_no = e.emp_no 
inner join department d on de.dept_no = d.dept_no ;

----list first name, last name and sex for each employee whose first name is Hercules and whose last name begins with the letter B
select first_name, last_name, sex
from employees e 
where first_name = 'Hercules' and last_name like 'B%';

----List each employee in the Sales department, including their employee number, last name, and first name
select e.emp_no, e.last_name, e.first_name
from employees e 
inner join dept_emp de on e.emp_no = de.emp_no 
inner join department d on de.dept_no = d.dept_no 
where d.dept_name = 'Sales';

----List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name
select e.emp_no, e.last_name, e.first_name, d.dept_name
from employees e 
inner join dept_emp de on e.emp_no = de.emp_no 
inner join department d on de.dept_no = d.dept_no 
where d.dept_name in ('Sales', 'Development');

----List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name)
select last_name, count(*) as frequency
from employees e 
group by last_name 
order by frequency desc;
























