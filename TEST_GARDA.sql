DROP TABLE IF EXISTS sales;
DROP TABLE IF EXISTS person;

CREATE TABLE person (
person_id INT NOT NULL AUTO_INCREMENT,
name varchar(50),
PRIMARY KEY (person_id)
);

INSERT INTO person (name)
VALUES ('Olle'), ('Per'), ('Gustav');

SELECT * FROM person;

CREATE TABLE sales (
sales_id INT NOT NULL AUTO_INCREMENT,
person_id INT,
qty INT,
sale_date DATE,
PRIMARY KEY (sales_id),
FOREIGN KEY (person_id) REFERENCES person(person_id)
);

INSERT INTO sales (person_id, qty, sale_date)
VALUES 
    (1, 8, '2025-01-01'),  -- Olle
    (2, 1, '2025-01-02'),  -- Per
    (3, 3, '2025-01-03');  -- Gustav
    
INSERT INTO sales (person_id, qty, sale_date)
VALUES 
    (1, 5, '2025-01-04'),  -- Olle
    (1, 2, '2025-01-05'),  -- Olle
    (3, 7, '2025-01-06'),  -- Gustav
    (3, 4, '2025-01-07'),  -- Gustav
    (2, 6, '2025-01-08'),  -- Per
    (2, 3, '2025-01-09');  -- Per


SELECT * FROM sales ORDER BY qty DESC;

SELECT person.person_id, person.name, SUM(sales.qty) AS total_sales
FROM person
INNER JOIN sales 
ON person.person_id = sales.person_id
GROUP BY person.person_id, person.name
ORDER BY total_sales DESC;

--------------------------------------------------

SELECT 
    person.person_id,
    person.name,
    YEARWEEK(sales.sale_date, 1) AS year_week,
    SUM(sales.qty) AS total_sales,
    CASE 
        WHEN SUM(sales.qty) > 10 THEN 'Yes'
        ELSE 'No'
    END AS exceeded_10
FROM 
    person
INNER JOIN 
    sales 
ON 
    person.person_id = sales.person_id
GROUP BY 
    person.person_id, person.name, YEARWEEK(sales.sale_date, 1)
ORDER BY 
    year_week ASC, total_sales DESC;
