create view stock2
as

select 
s1. item_name,
s1.ing_id,
s1.ing_name,
s1.ing_weight,
s1.order_quantity,
s1.recipe_quantity,
s1.order_quantity *s1.recipe_quantity as ordered_weight,
s1.ing_price/s1.ing_weight as unit_cost,
(s1.order_quantity *s1.recipe_quantity)*(s1.ing_price/s1.ing_weight) as ingredient_cost
from
(select  o.item_id,
		i.sku,
        i.item_name,
        sum(o.quantity) as order_quantity,
        r.ing_id,
        r.quantity as recipe_quantity,
        ing.ing_name, 
        ing.ing_weight,
        ing.ing_price
from coffee_shop.order o
left join coffee_shop.items i on o.item_id= i.item_id
left join coffee_shop.recipes r on r.recipe_id= i.sku
left join coffee_shop.ingredients ing on ing.ing_id= r.ing_id
group by 
o.item_id,
i.item_name,
i.sku,
r.ing_id,
r.quantity,
ing.ing_name,
ing.ing_weight,
ing.ing_price
having
i.sku is not null and i.item_name is not null) s1;


select
s2.ing_name,
s2.ordered_weight,
ing.ing_weight *inv.quantity as total_inv_weight,
(ing.ing_weight *inv.quantity) -s2.ordered_weight as remaining_weight
from
(select 
ing_id,
ing_name,
sum(ordered_weight) as ordered_weight
from stock2
group by ing_name, ing_id) s2

left join ingredients ing on s2.ing_id = ing.ing_id
left join inventory inv  on s2.ing_id = inv.ing_id


