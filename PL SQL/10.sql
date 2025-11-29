set serverouput on;

declare
    vlower number := &lowernumber;
    vupper number := &uppernumber;
    betweensum number := 0;
begin   
    for i in vlower .. vupper loop
        betweensum := betweensum + i;
    end loop;

    dbms_output.put_line('the sum of number from ' || vlower || ' to ' || vupper || ' is ' || betweensum);

end;
/
