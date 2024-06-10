select  o. order_id,
		i. item_price,
        o.quantity,
        i.item_cat,
        i.item_name,
        o.created_at
from coffee_shop.order o
left join coffee_shop.items i on i.item_id = o.item_id;

