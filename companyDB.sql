create database companyDB;
use companyDB;

create table departments(
departmentId int auto_increment primary key,
departmentName varchar(50) not null unique,
location varchar(100) not null);

create table employees(
employeeId int auto_increment primary key,
firstName varchar(50) not null,
lastName varchar(50) not null,
departmentId int not null,
dateOfBirth date not null,
email varchar(100) not null unique,
gender enum('Male','female','other') not null,
hireDate date not null check (hireDate >= '2000-01-01'),
foreign key (departmentId) references departments(departmentId));

CREATE TABLE projects (
    projectId INT AUTO_INCREMENT PRIMARY KEY,
    projectName VARCHAR(100) NOT NULL UNIQUE,
    startDate DATE NOT NULL,
    endDate DATE, CHECK (endDate > startDate),
    budget DECIMAL(15, 2) NOT NULL CHECK (budget > 0)
);

CREATE TABLE assignments (
    assignmentId INT AUTO_INCREMENT PRIMARY KEY,
    employeeID INT NOT NULL,
    projectID INT NOT NULL,
    hoursWorked DECIMAL(5, 2) NOT NULL CHECK (HoursWorked >= 0),
    FOREIGN KEY (employeeId) REFERENCES employees(EmployeeID),
    FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID)
);


CREATE TABLE Salaries (
    SalaryID INT AUTO_INCREMENT PRIMARY KEY,
    EmployeeID INT NOT NULL,
    BaseSalary DECIMAL(10, 2) NOT NULL CHECK (BaseSalary > 0),
    Bonus DECIMAL(10, 2) CHECK (Bonus >= 0),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);


INSERT INTO Departments (DepartmentName, Location) VALUES
('HR', 'New York'),
('IT', 'San Francisco'),
('Finance', 'Chicago'),
('Marketing', 'Los Angeles');

INSERT INTO Employees (FirstName, LastName, DepartmentID, DateOfBirth, Email, Gender, HireDate) VALUES
('John', 'Doe', 1, '1985-04-12', 'john.doe@example.com', 'Male', '2010-05-10'),
('Jane', 'Smith', 2, '1990-08-23', 'jane.smith@example.com', 'Female', '2015-07-19'),
('Alice', 'Brown', 3, '1982-11-17', 'alice.brown@example.com', 'Female', '2008-02-25'),
('Bob', 'Johnson', 4, '1979-03-30', 'bob.johnson@example.com', 'Male', '2005-01-15');

INSERT INTO Projects (ProjectName, StartDate, EndDate, Budget) VALUES
('Website Redesign', '2023-01-01', '2023-12-31', 100000),
('Mobile App Development', '2023-03-01', '2024-02-28', 150000),
('Data Migration', '2022-06-01', '2023-06-30', 50000);

INSERT INTO Assignments (EmployeeID, ProjectID, HoursWorked) VALUES
(1, 1, 120),
(2, 2, 250),
(3, 3, 180),
(4, 1, 90);

INSERT INTO Salaries (EmployeeID, BaseSalary, Bonus) VALUES
(1, 60000, 5000),
(2, 80000, 7000),
(3, 75000, 6000),
(4, 90000, 10000);


/* all emp from IT dept*/
select e.*
from employees e
join departments d on e.departmentId=d.departmentId
where d.departmentName='IT';


/*find emp hired after 2010*/
select *
from employees
where hireDate > '2010-12-31';

/*list projects with a budget exceeding $80,000*/
select *
from projects
where budget > 80000;


/*sort employees by their hire date in descending order*/
select *
from employees
order by hireDate desc;


/*projects sorted by their budget in ascending order*/
select *
from projects
order by budget asc;


/*count the no. of employees in each department*/
select d.departmentName, count(e.employeeId) as employeeCount
from departments d
left join employees e on d.departmentId=e.departmentId
group by d.departmentName;


/*display top 3 employees with the highest base salary*/
select *
from salaries
order by basesalary desc
limit 3;


/*retrieve emploees name with their department names*/
select e.firstName, e.lastName, d.departmentName
from employees e
join departments d on e.departmentId=d.departmentId;


/*list all assignments including employee and prjects details*/
select a.assignmentId, e.firstName, e.lastName, p.projectName, a.hoursworked
from assignments a
join employees e on e.employeeId=a.employeeId
join projects p on a.projectid=p.projectId;

/*find employees working on the project with the highest budget*/
select e.firstName, e.lastName, p.projectName
from employees e
join assignments a on e.employeeId=a.employeeId
join projects p on a.projectId=p.projectId
where p.budget=(select max(budget) from projects);


/*calculate the age of each employee*/
select firstName, lastName, floor(datediff(curdate(),dateofbirth)/365) as age
from employees;


/*calculate the total salary(base+bonus) for each employee*/
select e.firstName, e.lastName, (s.basesalary + ifnull(s.bonus,0)) as totalsalary
from employees e
join salaries s on e.employeeId=s.employeeId;


/*find all emp hired in 2015*/
select *
from employees
where year(hiredate)=2015;


/*names of projects ending before december 2023*/
select projectName
from projects
where enddate < '2023-12-31';


/* employees base salaries greater than $70,000*/
select e.firstName, e.lastName
from employees e
join salaries s on e.employeeId=s.employeeId
where s.basesalary>70000;


/*count the no. of projects handled by each emloyee*/
select e.firstName, e.lastName, count(a.projectId)
from employees e
join assignments a on e.employeeId=a.employeeId
group by e.employeeId;


/*list departments located in san francisco*/
select *
from departments
where location='san francisco';


/*display project names aling with total hours worked on each*/
select p.projectName, sum(a.hoursworked) as totalhours
from projects p
join assignments a on p.projectId=a.projectId
group by p.projectId;


/*highest bonus received by an employee*/
select max(bonus) 
from salaries;



/*identify projects that lasted for more than 12 months*/
select projectName
from projects
where timestampdiff(month,startdate,enddate) > 12;


/*all projects starting in 2023*/
select *
from projects
where year(startdate)=2023;


/*calculate total hours worked by each employee across all projects*/
select e.firstName, e.lastName, sum(a.hoursworked) as totalhours
from employees e
join assignments a on e.employeeId=a.employeeId
group by e.employeeId;


/*department with the most employees*/
select d.departmentName, count(e.employeeId) as no_of_employee
from departments d
left join employees e on d.departmentId=e.departmentId
group by d.departmentId
order by no_of_employee desc 
limit 1;


/*list employees who were born before 1985*/
select *
from employees
where dateofbirth < '1985-01-01';