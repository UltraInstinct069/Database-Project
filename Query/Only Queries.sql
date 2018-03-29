

**1** to get the details information about guest by using join table ( implemented in Booking.java)

select Guest.GuestID,Guest.FirstName+' '+ Guest.LastName as 'Guest Name',Telephone,Addresss,CheckIn,Checkout,DATEDIFF(DAY,CheckIn,Checkout) as 'Night Stay',NumberOfguest,Booking.RoomNum,RoomType.RmType
             from Guest,Booking,Room,RoomType,Staff
             where Guest.GuestID=Booking.GuestID and Booking.RoomNum=Room.RoomNum and Booking.StaffID=Staff.StaffID and Room.RmtypeID=RoomType.RmTypeID

**2** to get the Room information which are avaiable ( implemented in Booking.java)

select RoomNum,RmType,Availability,Price from Room,RoomType where Room.RmTypeID=RoomType.RmTypeID and Availability='YES'

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