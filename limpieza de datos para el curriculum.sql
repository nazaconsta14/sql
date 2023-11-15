select
*
from club_member

select
*
from club_member
where age is null

--------------------------------------------------------------------------------------------------------------------------

-----Many records in the name contained question marks, which we proceeded to eliminate.

select
*
from club_member
where full_name like '%?%'


select
replace(full_name,'???',''),
full_name
from club_member

update club_member
set full_name=replace(full_name,'???','')



select
full_name,
case
when full_name  like '  %'  then ' '
end
from club_member
  

select
full_name,
replace(full_name,'  ','')
from club_member

update club_member
set full_name =replace(full_name,'   ','')


select
martial_status,
count(martial_status)
from club_member
group by martial_status


update club_member
set martial_status=replace(martial_status,'divored','divorced')

--------------------------------------------------------------------------------------------------------------------------


---We also saw that there are records in the name where some are lowercase and others are uppercase. 

-- And also some names had more blank spaces than others.

select
*
from club_member
where full_name like '  %'

select
upper(full_name)
from club_member

update club_member
set full_name = lower(full_name)


--------------------------------------------------------------------------------------------------------------------------


--We saw that the address, the city and the state were all together. Then we proceeded to separate them

select
full_address
from club_member

select
full_address,
SPLIT_PART(full_address,',',1) as direction,
SPLIT_PART(full_address,',',2) as city,
SPLIT_PART(full_address,',',3) as state
from club_member

alter table club_member
add full_direction varchar(255);

alter table club_member
add full_city varchar(255);

alter table club_member
add full_state varchar(255);


update club_member
set full_direction = SPLIT_PART(full_address,',',1) 

update club_member
set full_city =SPLIT_PART(full_address,',',2) 

update club_member
set full_state =SPLIT_PART(full_address,',',3) 

--------------------------------------------------------------------------------------------------------------------------

---we saw many errors in the names of the states

select
count(full_city),
full_state
from club_member
group by full_state


select
full_state
from club_member
where full_state = 'Kalifornia'

select
full_state,
replace(full_state,'Kalifornia','California')
from club_member

update club_member
set full_state=replace(full_state,'Kalifornia','California')



select
full_state,
replace(full_state,'Tennesseeee','Tennessee')
from club_member

update club_member
set full_state=replace(full_state,'Tennesseeee','Tennessee')


select
full_state,
replace(full_state,'Kansus','Kansas')
from club_member

update club_member
set full_state=replace(full_state,'Kansus','Kansas')


select
full_state,
replace(full_state,'South Dakotaaa','South Dakota')
from club_member

update club_member
set full_state=replace(full_state,'South Dakotaaa','South Dakota')


select
full_state,
replace(full_state,'NorthCarolina','North Carolina')
from club_member

update club_member
set full_state=replace(full_state,'NorthCarolina','North Carolina')

select
full_state,
replace(full_state,'Tejas','Texas')
from club_member

update club_member
set full_state=replace(full_state,'Tejas','Texas')


select
full_state,
replace(full_state,'NewYork','New York')
from club_member

update club_member
set full_state=replace(full_state,'NewYork','New York')

select
full_state,
replace(full_state,'Tej+F823as','Texas')
from club_member

update club_member
set full_state=replace(full_state,'Tej+F823as','Texas')


--------------------------------------------------------------------------------------------------------------------------



