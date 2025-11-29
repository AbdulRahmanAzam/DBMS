set serverouput on;

declare
    num1 number := &num1;
    num2 number := &num2;
    vsum number;

begin   
    vsum := num1 + num2;

    dbms_output.put_line('the sum of ' || num1 || ' and ' || num2 || ' is ' || vsum);

end;
/
