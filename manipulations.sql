--DEALERSHIPS
--info for later on
--name, phoneNum, carStock [all from table]
--dealership_id_from_dealership_page == the id shown on the form (site)
--dealershipnameInput == the user input for form on site
--dealershipphonenumInput == the user input for the dealership phone number on site
--carStockInput == car stock input from form on site

--select a specific dealership by finding the ID
SELECT name, phoneNum, carstock FROM dealerships WHERE id = :dealership_id_from_dealership_page

--add a new dealership into the dealership table
INSERT INTO dealerships (name, phoneNum, carStock) VALUES (:dealershipnameInput, :dealershipphonenumInput, :carStockInput)

--update an existing dealerships information based on ID
UPDATE dealerships SET name = :dealershipnameInput, phoneNum = :dealershipphoneInput, carStock = :carStockInput WHERE id =:dealership_id_from_dealership_page

--delete a dealership from the table
DELETE FROM dealerships WHERE id = :dealership_id_from_dealership_page

--EMPLOYEES
--info for later on
--fName, lName, type, dealership_ID [all from table]
--employeesfNameInput == user input for employee first name on site
--employeeslNameInput == user input for employee last name on site
--employeesTypeInput == user input for employee type on site
--dealership_ID_Input == user input for dealership type on site
--employee_id_from_employees_page ==id shown on form on site

--select a specific employee by finding the ID
SELECT fName, lName, type, dealership_ID FROM employees WHERE id = :employee_id_from_employees_page

--add a new employee into the employees table
INSERT INTO employees (fName, lName, type, dealership_ID) VALUES (:employeesfNameInput, :employeeslNameInput, :employeesTypeInput, :dealership_ID_Input)

--update an existing employee information based on ID
UPDATE employees SET fName = :employeesfNameInput, lName = :employeeslNameInput, type = :employeesTypeInput, dealership_ID = :dealership_ID_Input

--delete an employee from the table
DELETE FROM employees WHERE id = :employee_id_from_employees_page

--CARS
--info for later on
--make, model, year, price [from table]
--car_make_selected_from_car_page == the make entered into the search field
--car_id_selected_from_car_page == the id of the car selected from the site
--carmakeInput == user input for form on site for car make
--caryearInput == user input for form on site for car car year
--carpriceInput == user input for form on site for car price

--search field based on car manuf
SELECT make, model, year, price FROM cars WHERE make = :car_make_selected_from_car_page

--select a specific car input by finding the ID
SELECT make, model, year, price FROM cars WHERE id = :car_id_selected_from_car_page

--add a new car into the cars table
INSERT INTO cars (make, model, year, price) VALUES (:carmakeInput, :caryearInput, :carpriceInput)

--update the existing car information based on ID
UPDATE cars SET make = :carmakeInput, model = :caryearInput, price = :carpriceInput

--delete car from table
DELETE FROM cars WHERE id = :car_id_selected_from_car_page

--DEALERSHIP CARS (intersect table)
--info for later on
SELECT dealerships.id FROM dealerships INNER JOIN cars ON dealership.id = cars.id

--TRANSACTIONS
--info for later on
--dealership_ID, date, car_ID, customer_ID from the table
--transaction_id_selected_from_page == id selected from form on site
--dealership_ID_Input == user input from form on site
--date_input == user input for date on form on site
--car_ID_input == user input for car ID on form on site
--customer_ID_input == user input for customer ID on form on site

--select a specific transaction by finding the ID
SELECT dealership_ID, date, car_ID, customer_ID FROM transactions WHERE id = :transaction_id_selected_from_page

--add a new transaction into the transaction table
INSERT INTO transactions (dealership_ID, date, car_ID, customer_ID) VALUES (:dealership_ID_Input, :date_input, :car_ID_input, :customer_ID_input)

--update the existing transaction information based on ID
UPDATE transactions SET dealership_ID = :dealership_ID_Input, date = :date_input, car_ID =:car_ID_input, customer_ID = :customer_ID_input

--delete transcation from table
DELETE FROM transactions WHERE id = :transaction_id_selected_from_page

--CUSTOMER_TRANSACTIONS
SELECT transaction.id FROM transactions INNER JOIN customers ON transaction.id = customer.id

--EMPLOYEE TRANSACTIONS
SELECT transaction.id FROM transactions INNER JOIN employees ON transaction.id = employee.id
