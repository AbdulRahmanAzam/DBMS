```sql
-- 1. Create the object type specification
CREATE OR REPLACE TYPE COURSE_ENROLLMENT AS OBJECT (
  student_name   VARCHAR2(200),
  course_name    VARCHAR2(200),
  base_fee       NUMBER,
  certificate_fee NUMBER,
  support_fee    NUMBER,
  MEMBER FUNCTION final_fee RETURN NUMBER
);
/

-- 2. Create the object type body implementing final_fee
CREATE OR REPLACE TYPE BODY COURSE_ENROLLMENT AS
  MEMBER FUNCTION final_fee RETURN NUMBER IS
    cert_fee_after NUMBER;
    support_fee_after NUMBER;
    total_fee NUMBER;
  BEGIN
    -- Apply certificate discount only on certificate_fee if > 20000 (5%)
    IF NVL(Self.certificate_fee,0) > 20000 THEN
      cert_fee_after := Self.certificate_fee * 0.95; -- 5% discount
    ELSE
      cert_fee_after := NVL(Self.certificate_fee,0);
    END IF;

    -- Apply support discount only on support_fee if > 5000 (8%)
    IF NVL(Self.support_fee,0) > 5000 THEN
      support_fee_after := Self.support_fee * 0.92; -- 8% discount
    ELSE
      support_fee_after := NVL(Self.support_fee,0);
    END IF;

    -- Total = base_fee + discounted certificate fee + discounted support fee
    total_fee := NVL(Self.base_fee,0) + cert_fee_after + support_fee_after;

    RETURN total_fee;
  END final_fee;
END;
/

-- 3. Create an OBJECT TABLE to store multiple enrollments
CREATE TABLE enrollments OF COURSE_ENROLLMENT
  (PRIMARY KEY (student_name, course_name)); -- composite key for uniqueness (adjust as needed)
-- Note: Using student_name+course_name as PK for demo; in production use surrogate keys.
/

-- 4. Insert sample data into the object table
INSERT INTO enrollments VALUES (
  COURSE_ENROLLMENT('John Doe', 'Full Stack Development', 75000, 0, 3000)
);

INSERT INTO enrollments VALUES (
  COURSE_ENROLLMENT('Aisha Malik', 'Data Science Professional', 90000, 25000, 6000)
);


COMMIT;

-- 5. PL/SQL block: fetch all enrollments, print details, compute aggregates
DECLARE
  CURSOR c_enroll IS
    SELECT VALUE(e) AS obj FROM enrollments e; -- VALUE(e) returns the object instance

  v_obj COURSE_ENROLLMENT;
  v_final_fee NUMBER;
  v_total_sum NUMBER := 0;
  v_count NUMBER := 0;
  v_max_fee NUMBER := NULL;
  v_avg_fee NUMBER := 0;
  v_cert_discount_count NUMBER := 0;
BEGIN
  DBMS_OUTPUT.PUT_LINE('--- Enrollment Details and Final Fees ---');

  FOR rec IN c_enroll LOOP
    v_obj := rec.obj;
    -- call the member function to compute final fee (discounts applied inside)
    v_final_fee := v_obj.final_fee;

    -- Print student name, course name, final fee
    DBMS_OUTPUT.PUT_LINE('Student: ' || v_obj.student_name || ' | Course: ' || v_obj.course_name || ' | Final Fee: ' || TO_CHAR(v_final_fee, 'FM999,999,999.00'));

    -- Aggregations
    v_total_sum := v_total_sum + v_final_fee;
    v_count := v_count + 1;

    IF v_max_fee IS NULL OR v_final_fee > v_max_fee THEN
      v_max_fee := v_final_fee;
    END IF;

    -- Count certificate discount applied (based on original certificate_fee > 20000)
    IF NVL(v_obj.certificate_fee,0) > 20000 THEN
      v_cert_discount_count := v_cert_discount_count + 1;
    END IF;
  END LOOP;

  IF v_count > 0 THEN
    v_avg_fee := v_total_sum / v_count;
  ELSE
    v_avg_fee := 0;
  END IF;

  DBMS_OUTPUT.PUT_LINE('--- Summary ---');
  DBMS_OUTPUT.PUT_LINE('Total enrollments processed: ' || v_count);
  DBMS_OUTPUT.PUT_LINE('Average final fee: ' || TO_CHAR(v_avg_fee, 'FM999,999,999.00'));
  DBMS_OUTPUT.PUT_LINE('Highest final fee: ' || CASE WHEN v_max_fee IS NOT NULL THEN TO_CHAR(v_max_fee, 'FM999,999,999.00') ELSE 'N/A' END);
  DBMS_OUTPUT.PUT_LINE('Number of enrollments with certificate discount applied: ' || v_cert_discount_count);
END;
/

```



# MONGOSH
## I. Insert multiple product documents at once into the Products collection.
```js
db.Products.insertMany([
   {
      productID: 101,
      name: "Gaming Laptop",
      category: "Electronics",
      price: 1500,
      stock: 45,
      ratings: [5, 4, 5]
   },
   {
      productID: 102,
      name: "Wireless Mouse",
      category: "Electronics",
      price: 25,
      stock: 150,
      ratings: [4, 3]
   },
   {
      productID: 103,
      name: "History Novel",
      category: "Books",
      price: 15,
      stock: 200,
      ratings: [5, 5]
   },
   {
      productID: 104,
      name: "Cheap Cable",
      category: "Electronics",
      price: 5,
      stock: 8,
      ratings: [2]
   }
])
```

## II. Find all products where the category is "Electronics" and the stock is greater than 50.
```js
db.Products.find({
    category: "Electronics",
    stock: { $gt: 50 }
})
```

## III. Find all products where the price is less than 100 or the category is "Books".
```js
db.Products.find({
    $or: [
        { price: { $lt: 100 } },
        { category: "Books" }
    ]
})
```

## IV. Update the stock quantity by adding 20 to the product with productID 101.
```js
db.Products.updateOne(
    { productID: 101 },
    { $inc: { stock: 20 } }
)
```


## V. Delete all products that have a stock less than 10.
```js
db.Products.deleteMany({
    stock: { $lt: 10 }
})
```


# Transaction + Triggger
```sql
DECLARE
  v_total NUMBER := 0;
  -- Example order items (you may replace these in tests)
  v_item1 NUMBER := 1;   v_qty1 NUMBER := 2;
  v_item2 NUMBER := 2;   v_qty2 NUMBER := 1;

BEGIN
  -- Start transaction implicitly
  SAVEPOINT start_order;

  --------------------------------------------------------------------------------
  -- Insert into orders (total_amount will be updated later)
  --------------------------------------------------------------------------------
  INSERT INTO orders (order_id, cust_id, res_id, total_amount)
  VALUES (5001, 1001, 10, 0);

  --------------------------------------------------------------------------------
  -- Process item 1
  --------------------------------------------------------------------------------
  DECLARE
    v_price NUMBER;
    v_stock NUMBER;
  BEGIN
    SELECT price, stock INTO v_price, v_stock
    FROM menu_items
    WHERE item_id = v_item1;

    IF v_stock < v_qty1 THEN
      RAISE_APPLICATION_ERROR(-20001, 'Insufficient stock for Item 1');
    END IF;

    INSERT INTO order_details (detail_id, order_id, item_id, qty)
    VALUES (9001, 5001, v_item1, v_qty1);

    UPDATE menu_items
    SET stock = stock - v_qty1
    WHERE item_id = v_item1;

    v_total := v_total + (v_price * v_qty1);
  END;

  --------------------------------------------------------------------------------
  -- Process item 2
  --------------------------------------------------------------------------------
  DECLARE
    v_price NUMBER;
    v_stock NUMBER;
  BEGIN
    SELECT price, stock INTO v_price, v_stock
    FROM menu_items
    WHERE item_id = v_item2;

    IF v_stock < v_qty2 THEN
      RAISE_APPLICATION_ERROR(-20002, 'Insufficient stock for Item 2');
    END IF;

    INSERT INTO order_details (detail_id, order_id, item_id, qty)
    VALUES (9002, 5001, v_item2, v_qty2);

    UPDATE menu_items
    SET stock = stock - v_qty2
    WHERE item_id = v_item2;

    v_total := v_total + (v_price * v_qty2);
  END;

  --------------------------------------------------------------------------------
  -- Update order total
  --------------------------------------------------------------------------------
  UPDATE orders
  SET total_amount = v_total
  WHERE order_id = 5001;

  --------------------------------------------------------------------------------
  -- Log activity
  --------------------------------------------------------------------------------
  INSERT INTO order_activity (activity_id, order_id, action)
  VALUES (3001, 5001, 'Order Placed Successfully');

  COMMIT;
  DBMS_OUTPUT.PUT_LINE('ORDER COMPLETED AND COMMITTED');

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK TO start_order;
    DBMS_OUTPUT.PUT_LINE('TRANSACTION FAILED: ' || SQLERRM);
END;
/

```
