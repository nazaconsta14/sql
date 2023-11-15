use  limpieza_de_datos;


select * from proyecto_1 ;



--------------------------------------------------------------------------------------------------------------
--Limpieza de datos


select SaleDate_2, convert(Date,SaleDate) as SaleDate_2
from proyecto_1;

alter table proyecto_1
add SaleDate_2 Date;
update proyecto_1
set SaleDate_2 = convert(Date,SaleDate) ;




--- mejoramos la tabla con las fechas



--------------------------------------------------------------------------------------------------------------
--. PRIMERO BUSCAMOS LOS VALORES NULOS DE UNA TABLA
--- ACA VIMOS QUE UNA TABLA TENIA UN MONTON DE VALORES NULOS
--- ENTONCES LO QUE HICIMOS FUE HACER UNA SUBCONSULTA CORRELACIONADA , PERO QUE LOS ID FUERAN DISTINTOS
--- LUEGO LA ACTUALIZAMOS CON LOS CAMBIOS REALIZADOS
select *
from proyecto_1
where PropertyAddress is null;


select a.ParcelID,a.PropertyAddress,b.ParcelID,b.PropertyAddress,isnull(a.PropertyAddress,b.PropertyAddress)
from proyecto_1 a
join proyecto_1 b
    on a.ParcelID=b.ParcelID
	and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null

update a
set PropertyAddress=isnull(a.PropertyAddress,b.PropertyAddress)
from proyecto_1 a
join proyecto_1 b
    on a.ParcelID=b.ParcelID
	and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null


select
*
from proyecto_1
where PropertyAddress is null


--------------------------------------------------------------------------------------------------------------


--- OTRO CASO MAS DE LIMPIEZA DE DATOS

--- EN PROPERTYADDRESS TENEMOS LA DIRECCION , LA CIUDAD Y EL ESTADO TODO JUNTO Y TENEMOS QUE SEPARARLO
---- dividir la dirección en columnas individuales (dirección, ciudad, estado)


select
substring(PropertyAddress,1,charindex(',',PropertyAddress)-1) as address,
substring(PropertyAddress,charindex(',',PropertyAddress)+1,len(PropertyAddress)) as state
from proyecto_1

alter table proyecto_1
add SaleDate_2 Date;
update proyecto_1
set SaleDate_2 = convert(Date,SaleDate) ;



alter table proyecto_1
add Property_Address nvarchar(255);
update proyecto_1 
set Property_Address = substring(PropertyAddress,1,charindex(',',PropertyAddress)-1) ;

alter table proyecto_1
add Property_City nvarchar(255);
update proyecto_1 
set Property_City = substring(PropertyAddress,charindex(',',PropertyAddress)+1,len(PropertyAddress)) ;



--------------------------------------------------------------------------------------------------------------

---- OWNER ADDRESS TENEMOS LA DIRECCION , LA CIUDAD Y EL ESTADO TODO JUNTO Y TENEMOS QUE SEPARARLO
---- dividir la dirección en columnas individuales (dirección, ciudad, estado)


select *
from proyecto_1
where OwnerAddress is null


select
OwnerAddress
from proyecto_1

---- hay una manera de hacerlo mas rapido y es usando otra funcion que no sea substring
--- tenemos que remplazar las comas por puntos , porque parsename no trabaja con comas

select     
PARSENAME(replace(OwnerAddress,',','.'),3) as direction,
PARSENAME(replace(OwnerAddress,',','.'),2) as city,
PARSENAME(replace(OwnerAddress,',','.'),1) as state
from proyecto_1



alter table proyecto_1
add OwnerAddress_2 nvarchar(255);
update proyecto_1 
set OwnerAddress_2 = PARSENAME(replace(OwnerAddress,',','.'),3) ;


alter table proyecto_1
add OwnerAddress_City nvarchar(255);

update proyecto_1 
set OwnerAddress_City = PARSENAME(replace(OwnerAddress,',','.'),2) ;


alter table proyecto_1
add OwnerAddress_State nvarchar(255);

update proyecto_1 
set OwnerAddress_State = PARSENAME(replace(OwnerAddress,',','.'),1) ;


--------------------------------------------------------------------------------------------------------------
---- Aca lo que veiamos es que teniamos en una tabla llamada SoldAsVacant
--- respuestas de este tipo : "Y" - "N" - "Yes" - "No" . Entonces las agrupapos la Y con Yes y la N con No

select
SoldAsVacant
from proyecto_1

select
*
from proyecto_1
where SoldAsVacant is null


select
distinct(SoldAsVacant),
count(SoldAsVacant)
from proyecto_1
group by SoldAsVacant
order by 2


select
SoldAsVacant,
case
when SoldAsVacant = 'Y' then 'Yes' 
else 'No'
end as SoldAsVacant_answer
from proyecto_1


update proyecto_1
set SoldAsVacant = case
when SoldAsVacant = 'Y' then 'Yes' 
else 'No'
end 
--------------------------------------------------------------------------------------------------------------

---- Otra forma de limpiar datos


----- REMOVER DUPLICADOS
with RowNumCTE as (
select
*,
 ROW_NUMBER()over(
 partition by ParcelID,
 PropertyAddress,
 SalePrice,
 SaleDate,
 LegalReference
 order by UniqueID)row_num
from proyecto_1
--order by ParcelID
)

delete
from RowNumCTE
where row_num >1



select 
*
from proyecto_1

--------------------------------------------------------------------------------------------------------------

----OTRO PASO ES REMOVER COLUMNAS QUE NO TIENEN IMPORTANCIA

alter table proyecto_1
drop column OwnerAddress,TaxDistrict,PropertyAddress

alter table proyecto_1
drop column SaleDate
