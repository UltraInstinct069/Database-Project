insert into JOB values('Clerk'),
('Supervisor'),
('Guest Services'),
('Front desk assitant')

insert into Staff(JobID,FirstName,Lastname,Adress) 
values(101,'Karim','Ahmed','Road:5,Dhaka')

insert into Staff(JobID,FirstName,Lastname,Adress) 
values(102,'Mamun','Mia','Road:4,Banani')

create table RoomType(
RmTypeID int identity(50,1) primary key ,
RmType varchar(20) not null,
Price int not null,
Details varchar(20) not null
hello text 
)

create table testt(
id int primary key,
details text 
)

alter table RoomType
alter column Details text
insert into testt values(2,'hello bello maro,moro too,:khao khizz,polti')
insert into RoomType values ('Standard Room',800,'Room Service,Double bed,Non Ac,Television,Bathroom')
insert into RoomType values ('Standard Family',1200,'Room Service,Double Double bed,Non Ac,Television,Bathroom')
insert into RoomType values ('Superior Single',1000,'Room Service,Double bed,Ac,Television,Bathroom,Linen and Towels Provided')
insert into RoomType values ('Superior Single',1500,'Room Service,1 Double bed,1 single bed,Ac,Television,Bathroom,Linen and Towels Provided')
insert into RoomType values ('Executive Suite',3000,'Room Service,1 Double bed,Air Conditioned,Television,Bathroom,Linen and Towels Provided,Tea/Coffee Making,Newspapaper')
insert into RoomType values ('E.S Family',5000,'Room Service,1 Double bed,1 single bed,AC,Television,2 Bathroom,Linen and Towels Provided,Tea/Coffee Making,Newspapaper')
insert into RoomType values ('Apartment Suite',15000,'The luxurious Executive Suite has been totally refurbished to a four star plus standard,Room Service,1 Double bed,1 single bed,AC,Television,2 Bathroom,Linen and Towels Provided,Tea/Coffee Making,Newspapaper')




create table Room
(
RoomNum int primary key,
RmtypeID int foreign key references RoomType(RmTypeID),
Availability varchar(20)
)

select RoomNum,RmType,Details,price from Room,RoomType where Room.RmtypeID=RoomType.RmTypeID
insert into Room values(100,52,'YES')


create table PaymentMethod(
MethodID int identity(10,1) primary key,
Name varchar(20) not null
)

insert into PaymentMethod values('Cash'),
('Paypal'),
('Credit card')

create table Payment(
PaymentID int identity (125050,1) primary key,
MethodID int foreign key references PaymentMethod(MethodID),
Amount int not null,
DateOfPay date not null,
BookingID int foreign key references Booking(BookingID),
)

create table Booking(
BookingID int identity(7000,1) primary key,
GuestID int foreign key references Guest(GuestID),
RoomNum  int foreign key references Room(RoomNum),
StaffID  int foreign key references Staff(StaffID),
NumberOfguest int ,
BookingDate date,
CheckIn datetime,
Checkout datetime

)



**1** to get the details information about guest by using join table ( implemented in Booking.java)

select Guest.GuestID,Guest.FirstName+' '+ Guest.LastName as 'Guest Name',Telephone,Addresss,CheckIn,Checkout,DATEDIFF(DAY,CheckIn,Checkout) as 'Night Stay',NumberOfguest,Booking.RoomNum,RoomType.RmType
             from Guest,Booking,Room,RoomType,Staff
             where Guest.GuestID=Booking.GuestID and Booking.RoomNum=Room.RoomNum and Booking.StaffID=Staff.StaffID and Room.RmtypeID=RoomType.RmTypeID

**2** to get the Room information which are avaiable ( implemented in Booking.java)

select RoomNum,RmType,Availability,Price from Room,RoomType where Room.RmTypeID=RoomType.RmTypeID and Availability='YES'"

**3**to get the free (available)staffs information ( implemented in Booking.java)
select StaffID,JobType from Staff,JOB where Staff.JobID=JOB.JobID and BookingTo is null


***4** to get the number of check in in each dates( implemented in InformationDesk.java )

select CONVERT(date,CheckIn)as DATE,COUNT(BookingID) as 'Number Of CheckIn' from Booking group by CONVERT(date,CheckIn)

***5** to get the number of check in in each Month( implemented in InformationDesk.java )

select Datepart(M,CheckIn) as DATE,COUNT(BookingID) as 'Number Of CheckIn' from Booking group by Datepart(M,CheckIn)

***6** to get the information of the guest who have booked highest time( implemented in InformationDesk.java )

select Guest.GuestID,FirstName,LastName,COUNT(BookingID)as 'Number Of Bookings' from Guest,Booking where Booking.GuestID=Guest.GuestID group by Guest.GuestID,FirstName,LastName order by COUNT(BookingID) desc

**7** to get the information about payment each month and day( implemented in InformationDesk.java )

select DATEPART(M,DateOfPay) as 'Month',SUM(Amount) as 'Total Amount' from Payment group by DATEPART(M,DateOfPay)

select CONVERT(date,DateOfPay)as 'Date',SUM(Amount) as 'Total Amount' from Payment group by CONVERT(date,DateOfPay)

**8** to get the information about the Guest who didnt give paymentyet( implemented in Booking.java)

select Booking.BookingID,Guest.GuestID,Guest.FirstName+' '+ Guest.LastName as 'Guest Name',Booking.CheckIn 
                  from Booking,Guest where Guest.GuestID=Booking.GuestID and Booking.BookingID in 
                  (select BookingID from Booking where CheckIn is not null
                  except
                  select BookingID from Payment )
                  
**9**Query: Finding the Ac rooms which are not booked
select * from Room,RoomType 
   where Room.RmtypeID=RoomType.RmTypeID and RoomType.RmTypeID in (54,55,56,59,60,61) and Room.Availability='YES' 
   
**10**query: Finding the guest who takes Executive suite
select Guest.GuestID,Guest.FirstName+' '+ Guest.LastName as 'Guest Name',Telephone,Addresss,CheckIn,Checkout,NumberOfguest,Booking.RoomNum,RoomType.RmType
             from Guest,Booking,Room,RoomType,Staff
             where Guest.GuestID=Booking.GuestID and Booking.RoomNum=Room.RoomNum and Booking.StaffID=Staff.StaffID and Room.RmtypeID=RoomType.RmTypeID and
             RoomType.RmTypeID in (56,59,60)

**11**query for finding the number of rooms in each catagory

select RoomType.RmType,COUNT(Room.RoomNum) from Room,RoomType where Room.RmtypeID=RoomType.RmTypeID group by RoomType.RmType

**12**to find the customers who have checked in a certain date range( implemented in Booking.java section,date range will be selected from the UI..)

select Guest.GuestID,Guest.FirstName+' '+ Guest.LastName as 'Guest Name',Telephone,Addresss,CheckIn,Checkout,NumberOfguest,Booking.RoomNum,RoomType.RmType  
			 from Guest,Booking,Room,RoomType,Staff 
			  where Guest.GuestID=Booking.GuestID and Booking.RoomNum=Room.RoomNum and Booking.StaffID=Staff.StaffID and Room.RmtypeID=RoomType.RmTypeID and
			   CheckIn between ? and ?;
                        
**13** this query will update the room and staff info while anyone booking(Implemented in Booking section,staffID and roomnum will get from the input)
update Staff set BookingTo=NULL where StaffID=?
update Room set Availability='YES' where RoomNum=? 

**14**this will set the exact time when a guest check out or checkin(implmented on booking section,booking id will select from user)
update Booking set CheckOut=GETDATE() where BookingID=? 

**15** all details information about rooms (Implemented on StaffAndRoom.java )
select RoomNum,RmType,Details,Price,upper(Availability) from Room,RoomType where Room.RmtypeID=RoomType.RmTypeID
                
 

update Staff set BookingTo=null where StaffID=706
select * from Room
select * from RoomType
select * from Staff
select * from JOB
select * from Booking

delete from RoomType where RmTypeID=60
delete from Room where RoomNum=203

update RoomType 
set RmType='Superior Family' where RmTypeID=55

select GETDATE()

update Room set Availability='YES' where RoomNum=100