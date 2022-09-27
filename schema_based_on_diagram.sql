CREATE TABLE patients(
id INT GENERATED ALWAYS AS IDENTITY,
name VARCHAR,
date_of_birth date,
PRIMARY KEY(id)
);

Go

CREATE TABLE medical_histories(
id INT GENERATED ALWAYS AS IDENTITY,
admitted_at TIMESTAMP,
status VARCHAR,
PRIMARY KEY(id)
);

Go
CREATE TABLE invoice_items(
id INT GENERATED ALWAYS AS IDENTITY,
unit_price DECIMAL,
quantity INTEGER,
total_price DECIMAL,
PRIMARY KEY(id)
);
Go

CREATE TABLE invoices(
id INT GENERATED ALWAYS AS IDENTITY,
total_amount DECIMAL,
generated_at TIMESTAMP,
payed_at TIMESTAMP,
PRIMARY KEY(id)
);
Go
CREATE TABLE treatments(
id INT GENERATED ALWAYS AS IDENTITY,
type VARCHAR,
name VARCHAR,
PRIMARY KEY(id)
);

ALTER TABLE medical_histories
ADD COLUMN patient_id INT;
ALTER TABLE medical_histories
ADD CONSTRAINT patient_id 
FOREIGN KEY (patient_id) 
REFERENCES patients(id);

CREATE INDEX patient_id_asc ON medical_histories(patient_id ASC);

ALTER TABLE invoices 
ADD COLUMN medical_history_id INT;
ALTER TABLE invoices
ADD CONSTRAINT medical_history_id FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id);

CREATE INDEX medical_history_id_asc ON invoices(medical_history_id ASC);

ALTER TABLE invoice_items ADD COLUMN invoice_id INT;
ALTER TABLE invoice_items ADD COLUMN treatment_id INT;
ALTER TABLE invoice_items
ADD CONSTRAINT treatment_id FOREIGN KEY (treatment_id) REFERENCES treatments(id);
ALTER TABLE invoice_items
ADD CONSTRAINT invoice_id FOREIGN KEY (invoice_id) REFERENCES invoices(id);

CREATE INDEX invoice_id_asc ON invoice_items(invoice_id ASC);


CREATE INDEX treatment_id_asc ON invoice_items(treatment_id ASC);

CREATE TABLE medical_histories_treatment(
  treatment_id INT,
  CONSTRAINT treatment_id FOREIGN KEY (treatment_id) REFERENCES treatments(id),
  medical_history_id INT,
  CONSTRAINT medical_history_id FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id),
  PRIMARY KEY (treatment_id, medical_history_id)
);