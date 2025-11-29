set serveroutput on;

DECLARE
    vnum number := &num;
    voriginal number;
    vreversed number := 0;
    vdigit number;

BEGIN
    voriginal := vnum;

    while vnum > 0 LOOP
        vdigit := mod(vnum, 10); -- get last digit
        vreversed := vreversed * 10 + vdigit; -- build reverse number
        vnum := trunc(vnum / 10);  -- remove last digit
    end loop;

    if voriginal = vreversed then
        dbms_output.put_line(voriginal || ' is a palindormo');
    else
        dbms_output.put_line(voriginal || ' is NOT a palindormo');
    end if;
end;
/
