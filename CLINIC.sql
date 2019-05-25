CREATE TABLE Patients
(   Patient_ID INT NOT NULL PRIMARY KEY,
    Patient_FullName VARCHAR(100) NOT NULL,
    Patient_DateOfBirth DATE NOT NULL,
    Patient_Address VARCHAR(255) NOT NULL,
    Patient_PhoneNumber VARCHAR(11) NOT NULL
);
CREATE SEQUENCE Patients_seq
START WITH 1 
INCREMENT BY 1 
NOMAXVALUE;

INSERT INTO Patients (Patient_ID, Patient_FullName, Patient_DateOfBirth, Patient_Address, Patient_PhoneNumber) VALUES (Patients_seq.nextval, 'Кооритс Виктор', (TO_DATE('1999/04/14','YYYY/MM/DD')),'Москва, прекрасная улица Кошкина','79605030382');
INSERT INTO Patients (Patient_ID, Patient_FullName, Patient_DateOfBirth, Patient_Address, Patient_PhoneNumber) VALUES (Patients_seq.nextval, 'Сидорова Анна', (TO_DATE('1998/07/1','YYYY/MM/DD')),'Москва, улица Москворечье','79605000338');
INSERT INTO Patients (Patient_ID, Patient_FullName, Patient_DateOfBirth, Patient_Address, Patient_PhoneNumber) VALUES (Patients_seq.nextval, 'Пархомец Павел', (TO_DATE('1997/12/07','YYYY/MM/DD')),'Москва, улица Кошкина','79609840338');

SELECT * FROM Patients;


CREATE TABLE MedicalCard
(   Patient_ID INT NOT NULL PRIMARY KEY,
    Age INT NOT NULL,
    Sex VARCHAR(2) NOT NULL,
    Anamnesis CLOB,
    CONSTRAINT MedicalCard_fk
        FOREIGN KEY (Patient_ID)
        REFERENCES Patients(Patient_ID)
);


CREATE SEQUENCE Card_seq
START WITH 1 
INCREMENT BY 1 
NOMAXVALUE;

INSERT INTO MedicalCard (Patient_ID, Age, Sex, Anamnesis) VALUES (Card_seq.nextval, 20, 'M', 'Идеальное здоровье, в лечении не нуждается в принципе!');
INSERT INTO MedicalCard (Patient_ID, Age, Sex, Anamnesis) VALUES (Card_seq.nextval, 20, 'Ж', 'Группа крови: 3-я положительная, Прививки: от кори, столбняка, дифтерии сделаны');
INSERT INTO MedicalCard (Patient_ID, Age, Sex, Anamnesis) VALUES (Card_seq.nextval, 21, 'Ж', 'ИБшник, тяжелая форма поражения. Группа крови: 3-я положительная, Прививки: от кори, столбняка, дифтерии сделаны');

SELECT * FROM Appointment;

DROP TABLE Appointment;
CREATE TABLE Appointment
(   App_ID INT NOT NULL PRIMARY KEY,
    Patient_ID INT NOT NULL,
    Doctor_ID INT NOT NULL,
    App_Time DATE NOT NULL,
    Room_number INT,
    Treatment_number INT,
    CONSTRAINT App_fk
        FOREIGN KEY (Patient_ID)
        REFERENCES Patients(Patient_ID),
    CONSTRAINT App_fk1
        FOREIGN KEY (Room_number)
        REFERENCES Room(Room_number),
    CONSTRAINT App_fk2
        FOREIGN KEY (Doctor_ID)
        REFERENCES Doctors(Doctor_ID),
    CONSTRAINT App_fk3
        FOREIGN KEY (Treatment_number)
        REFERENCES Treatment(Treatment_number)
);

drop sequence App_seq;
CREATE SEQUENCE App_seq
START WITH 1 
INCREMENT BY 1 
NOMAXVALUE;
INSERT INTO Appointment (App_ID, Patient_ID, Doctor_ID, App_Time, Room_number, Treatment_number) VALUES (App_seq.nextval, 1, 1, TO_DATE('2019-05-26 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), 2, 1);
/*INSERT INTO Appointment (App_ID, Patient_ID, Doctor_ID, App_Time, Room_number, Treatment_number) VALUES (App_seq.nextval, 2, 1,TO_DATE('2019-05-26 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 2, 2);*/
INSERT INTO Appointment (App_ID, Patient_ID, Doctor_ID, App_Time, Room_number, Treatment_number) VALUES (App_seq.nextval, 3, 1,TO_DATE('2019-05-27 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), 2, 3);
CREATE TABLE Treatment
(   Treatment_number INT NOT NULL PRIMARY KEY,
    Treatment CLOB,
    Amount FLOAT NOT NULL,
    IsPaid VARCHAR(1)
);
INSERT INTO Treatment (Treatment_number, Treatment, Amount, IsPaid) VALUES (1, 'Авитаминоз. Жалоб нет. Назначены витамины "Алфавит.', 352.5, '+');
INSERT INTO Treatment (Treatment_number, Treatment, Amount, IsPaid) VALUES (2, ' Жалоб нет.', 100.0, '+');
INSERT INTO Treatment (Treatment_number, Treatment, Amount, IsPaid) VALUES (3, 'Жалоб нет.', 100, '+');
select * from Appointment;
CREATE TABLE Services
(   Service_ID INT NOT NULL PRIMARY KEY,
    Service_name varchar(255) NOT NULL,
    Service_type varchar(255) NOT NULL,
    DescriptionText  CLOB,
    Employee_ID INT NOT NULL,
    Price Float NOT NULL
);
INSERT INTO Services (Service_ID, Service_name, Service_type, DescriptionText, Employee_ID, Price) VALUES (45, 'Витамины АЛФАВИТ', 'Фармацевтическая', 'Прием: по 1 таблетке 3 раза в день', 1, 45.9 );


DROP TABLE Bill;
CREATE TABLE Bill
(   Treatment_number INT NOT NULL,
    Service_ID INT NOT NULL,
    Quantity INT NOT NULL,
    DateOfService DATE NOT NULL,
    CONSTRAINT Bill_fk
        FOREIGN KEY (Treatment_number)
        REFERENCES Treatment(Treatment_number),
    CONSTRAINT Bill_fk1
        FOREIGN KEY (Service_ID)
        REFERENCES Services(Service_ID)
);
INSERT INTO Bill (Treatment_number, Service_ID, Quantity, DateOfService) VALUES (1, 45, 1, (TO_DATE('2019/04/15','YYYY/MM/DD')));

select * from Bill;

CREATE SEQUENCE Room_seq
START WITH 1 
INCREMENT BY 1 
NOMAXVALUE;

CREATE TABLE Room
(   Room_number INT NOT NULL PRIMARY KEY,
    Room_name VARCHAR(255) NOT NULL
);
INSERT INTO Room (Room_number, Room_name) VALUES (2, 'Терапевтическая');
SELECT * FROM Room;


CREATE TABLE Doctors
(   Doctor_ID INT NOT NULL PRIMARY KEY,
    Doctor_FullName VARCHAR(100) NOT NULL,
    Specialization VARCHAR(255) NOT NULL,
    Cathegory NUMBER(1) NOT NULL,
    Education VARCHAR(255) NOT NULL
);
INSERT INTO Doctors (Doctor_ID, Doctor_Fullname, Specialization, Cathegory, Education) VALUES (1, 'Смирнов Валерий Евгеньевич', 'Терапевт',1 , 'РНИМУ им.Пирогова');

CREATE TABLE WorkSchedules
(   Doctor_ID INT NOT NULL,
    App_Date DATE NOT NULL,
    Ap1 DATE NOT NULL,
    Ap1IsFree VARCHAR(1) NOT NULL,
    Ap2 DATE NOT NULL,
    Ap2IsFree VARCHAR(1) NOT NULL,
    Ap3 DATE NOT NULL,
    Ap3IsFree VARCHAR(1) NOT NULL,
    CONSTRAINT SPK PRIMARY KEY (Doctor_ID,App_Date),
    CONSTRAINT Sfk
        FOREIGN KEY (Doctor_ID)
        REFERENCES Doctors(Doctor_ID)
    
);
INSERT INTO WorkSchedules (Doctor_ID, App_Date, Ap1, Ap1IsFree, Ap2, Ap2IsFree, Ap3, Ap3IsFree) VALUES (1, TO_DATE('2019-05-26', 'YYYY-MM-DD'), TO_DATE('2019-05-26 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), '-', TO_DATE('2019-05-26 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), '+', TO_DATE('2019-05-26 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), '+');
SELECT * from WorkSchedules;

CREATE VIEW FORPATIENT AS 
SELECT patients.patient_id, patients.patient_fullname, treatment.treatment, appointment.doctor_id
FROM Appointment
JOIN treatment ON appointment.treatment_number=treatment.treatment_number
JOIN Patients ON appointment.patient_id=patients.patient_id;
CREATE VIEW TREATMENTREPORT AS 
SELECT FORPATIENT.patient_id, FORPATIENT.patient_fullname, medicalcard.anamnesis, FORPATIENT.treatment, FORPATIENT.doctor_id
FROM
MedicalCard JOIN FORPATIENT
ON FORPATIENT.patient_id=medicalcard.patient_id;

select * from TREATMENTREPORT;
drop VIEW TREATMENTREPORT;


exec GET_REPORT(1);
DROP PROCEDURE GetAnamnesis;
create PROCEDURE GetAnamnesis (P_ID INT)
IS
Anam CLOB;
BEGIN
  SELECT MedicalCard.Anamnesis INTO Anam FROM MedicalCard WHERE MedicalCard.patient_ID = P_ID;
  dbms_output.put_line(Anam);
END;
/
exec GetAnamnesis(1);

DROP PROCEDURE GetTimeOfAppointment;
create PROCEDURE GetTimeOfAppointment (FullName VARCHAR)
IS
PatID INT;
ATime Date;
BEGIN
  SELECT Patients.Patient_ID INTO PatID FROM Patients WHERE Patients.patient_FullName = FullName;
  SELECT Appointment.App_Time INTO ATime FROM Appointment WHERE Appointment.Patient_ID = PatID;
  dbms_output.put_line('Добрый день,'||FullName|| '! Дата и время вашего приёма: '||to_char(ATime,'dd.mm.yyyy'));
END;
/
exec GetTimeOfAppointment('Сидорова Анна');






DROP PROCEDURE MakeApp;
create PROCEDURE MakeApp (Pat INT, Doc INT, den DATE, NumOfApp INT)
IS
varr VARCHAR(1);
AP1 DATE;
AP2 DATE;
AP3 DATE;
BEGIN 
IF NumOfApp=1 THEN
SELECT WorkSchedules.AP1ISFree INTO varr FROM WorkSchedules WHERE WorkSchedules.Doctor_ID = Doc AND WorkSchedules.APP_DATE = den;
IF varr='+' THEN
UPDATE WorkSchedules
SET AP1ISFREE='-' WHERE WorkSchedules.Doctor_ID = Doc AND WorkSchedules.APP_DATE = den;
SELECT WorkSchedules.AP1 INTO AP1 FROM WorkSchedules WHERE WorkSchedules.Doctor_ID = Doc AND WorkSchedules.APP_DATE = den;
INSERT INTO Appointment (App_ID, Patient_ID, Doctor_ID, App_Time) VALUES (App_seq.nextval, Pat, Doc , AP1);
dbms_output.put_line('This time is free, you will be recorded ON '||TO_CHAR(AP1, 'YYYY-MM-DD HH24:MI:SS'));
END IF;
ELSIF NumOfApp=2 THEN 
SELECT WorkSchedules.AP2ISFree INTO varr FROM WorkSchedules WHERE WorkSchedules.Doctor_ID = Doc AND WorkSchedules.APP_DATE = den;
IF varr='+' THEN
UPDATE WorkSchedules
SET AP2ISFREE='-' WHERE WorkSchedules.Doctor_ID = Doc AND WorkSchedules.APP_DATE = den;
SELECT WorkSchedules.AP2 INTO AP2 FROM WorkSchedules WHERE WorkSchedules.Doctor_ID = Doc AND WorkSchedules.APP_DATE = den;
INSERT INTO Appointment (App_ID, Patient_ID, Doctor_ID, App_Time) VALUES (App_seq.nextval, Pat, Doc , AP2);
dbms_output.put_line('This time is free, you will be recorded ON '||TO_CHAR(AP2, 'YYYY-MM-DD HH24:MI:SS'));
END IF;
ELSIF NumOfApp=3 THEN
SELECT WorkSchedules.AP3ISFree INTO varr FROM WorkSchedules WHERE WorkSchedules.Doctor_ID = Doc AND WorkSchedules.APP_DATE = den;
IF varr='+' THEN
UPDATE WorkSchedules
SET AP3ISFREE='-' WHERE WorkSchedules.Doctor_ID = Doc AND WorkSchedules.APP_DATE = den;
SELECT WorkSchedules.AP3 INTO AP3 FROM WorkSchedules WHERE WorkSchedules.Doctor_ID = Doc AND WorkSchedules.APP_DATE = den;
INSERT INTO Appointment (App_ID, Patient_ID, Doctor_ID, App_Time) VALUES (App_seq.nextval, Pat, Doc , AP3);
dbms_output.put_line('This time is free, you will be recorded ON '|| TO_CHAR(AP3, 'YYYY-MM-DD HH24:MI:SS'));
END IF;
END IF;
dbms_output.put_line('Sorry< we cannot record you on this time');
END;
/
exec MakeApp(2, 1, TO_DATE('2019-05-26', 'YYYY-MM-DD'), 3); 

SELECT * FROM WorkSchedules WHERE WorkSchedules.Doctor_ID = 1;
SELECT * FROM Appointment;