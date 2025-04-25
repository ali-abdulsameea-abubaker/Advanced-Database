


# I, Ali Abubaker, student number 000857347, certify that this material is my original work. No other person's work has been used without due acknowledgment and I have not made my work available to anyone else.


-- #1 Add your name as a patient in the chdb database. Complete all the columns. All the information other than your name can be made up (i.e., you do not need to put in your actual birth date or street address, etc.)
insert into patients (
first_name,
last_name,
gender,
birth_date,
street_address,
city,
province_id,
postal_code,
email,
health_card_num,
allergies,
patient_height,
patient_weight
)

Values (
'Ali',
'Abubaker',
 'M',
 '1997-11-12',
 '316 limeridge rd w',
 'Hamilton',
 'ON',
 'L9C 7V8',
 'aliabdulaameea96@gmail.com',
 '3245746323AC',
 'Pork',
 186,
 95
 );
 /**
 select * from patients
 where last_name = 'Abubaker';
**/
-- #2 Using your newly added patient_id, create your admission row such that admission date is the current date and there is no discharge date.
INSERT INTO admissions (
    patient_id,
    admission_date,
    discharge_date,
    primary_diagnosis,
    secondary_diagnoses,
    attending_physician_id,
    nursing_unit_id,
    room,
    bed
)
VALUES (
    (SELECT patient_id FROM patients WHERE first_name = 'Ali' AND last_name = 'Abubaker'),
    CURDATE(),
    NULL,
    'General Checkup',
    NULL,
    NULL,
    NULL,
    101,
    1
);
/**#3 
Look up the physicians table to find the physician_id for Samantha Carter and update your admission table
 info to include Samantha Carter as your attending physician.
 Based on their specialty make sure to also add the corresponding nursing_unit_id as well.
*/
UPDATE admissions 
SET attending_physician_id = 3, nursing_unit_id = '1WEST' 
WHERE patient_id = 792;

-- #4 Create a view that returns the patient id and patients’ first name and last name for all the patients that ordered morphine in the year 2022.

CREATE VIEW patients_Information AS
SELECT patients.patient_id, patients.first_name, patients.last_name
FROM patients
JOIN medications ON patients.patient_id = medications.medication_id
WHERE medications.medication_description = 'morphine' 
  AND YEAR(medications.last_prescribed_date) = 2022;

/**#5
Create a trigger that updates the value of the total_amount in the purchase_orders table 
if a corresponding purchase_order information is deleted in the purchase_order_lines table. 
(For example: If the total_amount for purchase_order_id 47 is 800 and we delete the row in 
purchase_order_lines for purchase_order_id 47 then this should trigger an update in the purchase_order table 
so that the total_amount for purchase_order_id 47 is 0).
**/
DELIMITER //
CREATE TRIGGER after_delete_purchase_order_lines
AFTER DELETE ON purchase_order_lines
FOR EACH ROW
BEGIN
    DECLARE remaining_lines INT;
    SELECT COUNT(*) INTO remaining_lines
    FROM purchase_order_lines
    WHERE purchase_order_id = OLD.purchase_order_id;
    IF remaining_lines = 0 THEN
        UPDATE purchase_orders
        SET total_amount = 0
        WHERE purchase_order_id  = OLD.purchase_order_id;
    END IF;
END; //
DELIMITER ;

-- #6 Demonstrate that you trigger works by running the following queries:
-- #1 check the row of data for purchase order id 47 
SELECT * FROM purchase_orders WHERE purchase_order_id = 47;

-- #2 Delete row of data in purchase_order_lines table for purchase_id 47
DELETE FROM purchase_order_lines WHERE purchase_order_id = 47;

-- 3- Check to see if trigger has worked on purchase_orders table
SELECT * FROM purchase_orders WHERE purchase_order_id = 47;