select
    -- from raw orders
    o.orderid,
    o.orderdate,
    o.shipdate,
    o.shipmode,
    o.ordersellingprice - o.ordercostprice as orderprofit,
    o.ordercostprice,
    o.ordersellingprice,
    -- from raw customers
    c.customerid,
    c.customername,
    c.segment,
    c.country,
    -- from raw product
    p.productid,
    p.category,
    p.productname,
    p.subcategory,
    {{ markup('ordersellingprice', 'ordercostprice') }} as markup,
    d.delivery_team
from {{ ref('raw_orders') }} as o
left join {{ ref('raw_customer') }} c
on o.customerid = c.customerid
left join {{ ref('raw_product') }} p
on o.productid = p.productid
left join {{ ref('delivery_team') }} d 
on o.shipmode = d.shipmode