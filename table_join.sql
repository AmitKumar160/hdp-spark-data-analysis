use organisation;
select
a.Id as OrderId,
a.OrderDate,
a.TotalAmount,
a.OrderNumber,
b.Id as orderItemId,
b.UnitPrice,
b.Quantity,
c.Id as ProductId,
c.ProductName,
c.Package,
c.IsDiscontinued,
d.Id as SupplierId,
d.CompanyName,
d.ContactName,
d.City as supplierCity,
d.Country as supplierCty,
d.Phone as supplierPhone,
d.Fax as supplierFax,
e.Id as CustomerId, 
e.FirstName as Customer_first_name,
e.LastName as Customer_last_name,
e.City as customer_city,
e.Country as customer_cty,
e.Phone as customer_phone
into cus_sup_ord_join
from Orders a
INNER JOIN OrderItem b on a.Id=b.OrderId 
FULL OUTER JOIN Product c on b.ProductId=c.Id
LEFT OUTER JOIN Supplier d on c.SupplierId=d.Id 
FULL OUTER JOIN Customer e on a.CustomerId=e.Id
;
