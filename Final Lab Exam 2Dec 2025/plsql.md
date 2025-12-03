# TRIGGERS
```sql
CREATE TABLE products (
  product_id       NUMBER PRIMARY KEY,
  product_name     VARCHAR2(100) NOT NULL,
  price            NUMBER(12,2)  NOT NULL,
  stock_quantity   NUMBER        NOT NULL,
  subtotal         NUMBER(14,2),          -- computed (price * stock_quantity)
  last_updated     DATE,
  created_by       VARCHAR2(128),
  updated_by       VARCHAR2(128)
);

create or replace trigger preventnegativevalues
before insert or update on products
for each row
declare
 vsubtotal number;
begin
-- prevent engry of negative or zero values
 if :NEW.price is null or :NEW.stock_quantity is null or
    :NEW.price <= 0 or :NEW.stock_quantity <= 0 then
    raise_application_error(-20001, 'Product price or product quantity cannot be negative or zero');
  end if;

-- monitor low stock levels
  if stock_quantity < 5 then
    raise_application_error(-20001, 'the product is going out of stock');
  end if;
    
-- restrict stock reduction during an update
  if updating then
    if :OLD.stock_quantity is not null and :OLD.stock_quantity > 1 then
      if :NEW.stock_quantity < (:OLD.stock_quantity * 0.5) then
        raise_application_error(-20003, 'stock reduction exceeds allowed limit 50%');
      end if;
    end if;
  end if;
  
  -- automaticallyc calculate subtotal
  vsubtotal := :NEW.stock_quantity * :NEW.price;
  if inserting then
    if :NEW.subtotal is not null then
      raise_application_error('this field cannot be updated manually');
    end if;
  elsif updating then
    if :OLD.subtotal != :NEW.subtotal then
      raise_application_error('this field cannot be updated manually');
    end if;
    
    :NEW.subtotal = vsubtotal;
  end if;
  
  if inserting then
    :NEW.created_by := USER;
    :NEW.updated_by := NULL;
  elsif updating then
    :NEW.created_by := :OLD.created_by;
    :NEW.updated_by := User;
  end if;
  
  :NEW.last_updated := sysdate;
end;
/

select * from emp;
```


