-- Drop the table if it already exists (optional)
DROP TABLE employee PURGE;

-- Create the employee table
CREATE TABLE employee (
    empno      NUMBER PRIMARY KEY,
    ename      VARCHAR2(50),
    ecommission NUMBER,
    salary     NUMBER
);

-- Insert sample data
INSERT INTO employee VALUES (101, 'Ali', 20, 800);
INSERT INTO employee VALUES (102, 'Sara', NULL, 1200);
INSERT INTO employee VALUES (103, 'John', 50, 1600);
INSERT INTO employee VALUES (104, 'Mary', NULL, 500);

COMMIT;

-- Enable DBMS_OUTPUT
SET SERVEROUTPUT ON;

-- PL/SQL block
DECLARE
    vempno      NUMBER := 102;       -- employee number to look up
    vname       VARCHAR2(50);
    vcommission NUMBER;
    vsalary     NUMBER;
BEGIN
    -- Fetch commission, salary, and name for the employee
    SELECT ecommission, salary, ename
    INTO vcommission, vsalary, vname
    FROM employee
    WHERE empno = vempno;

    -- If commission is NULL, calculate 10% of salary
    IF vcommission IS NULL THEN
        vcommission := vsalary * 0.10;
    END IF;
    
    -- Add commission to salary
    vsalary := vsalary + vcommission;

    -- Print results
    DBMS_OUTPUT.PUT_LINE('Empno     : ' || vempno);
    DBMS_OUTPUT.PUT_LINE('Name      : ' || vname);
    DBMS_OUTPUT.PUT_LINE('Salary    : ' || vsalary);
    DBMS_OUTPUT.PUT_LINE('Commission: ' || vcommission);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No employee found with Empno ' || vempno);
END;
/
