# Identifying cancelled order volumes and late delivery by partner experienced months

SELECT
CASE
  WHEN delivery_partner_experience_months >=1 AND delivery_partner_experience_months <=15 THEN 'new'
  WHEN delivery_partner_experience_months >=16 AND delivery_partner_experience_months <=30 THEN 'developing'
  WHEN delivery_partner_experience_months >=31 AND delivery_partner_experience_months <=45 THEN 'experienced'
  WHEN delivery_partner_experience_months >=46 AND delivery_partner_experience_months <=60 THEN
  'expert'
  END AS partner_exp_group,
COUNT(CASE WHEN late_delivery = 1 THEN order_id END) AS late_arrivals,
COUNT(CASE WHEN late_delivery = 0 THEN order_id END) AS on_time_delivery,
COUNT(CASE WHEN late_delivery = 'Cancelled order' THEN order_id END) AS cancelled_order,
ROUND(AVG(actual_delivery_time_minutes),1) AS AVG_actual_dt
FROM del
GROUP BY partner_exp_group
ORDER BY late_arrivals DESC;


# Identifying  late order volumes by customer type and partner experienced months

SELECT
CASE
  WHEN delivery_partner_experience_months >=1 AND delivery_partner_experience_months <=15 THEN 'new'
  WHEN delivery_partner_experience_months >=16 AND delivery_partner_experience_months <=30 THEN 'developing'
  WHEN delivery_partner_experience_months >=31 AND delivery_partner_experience_months <=45 THEN 'experienced'
  WHEN delivery_partner_experience_months >=46 AND delivery_partner_experience_months <=60 THEN
  'expert'
  END AS partner_exp_group,
COUNT(CASE WHEN customer_type = 'Regular' THEN order_id END) AS regular_cst,
COUNT(CASE WHEN customer_type = 'Premium' THEN order_id END) AS premium_cst,
COUNT(CASE WHEN customer_type = 'New' THEN order_id END) AS new_cst,
ROUND(AVG(actual_delivery_time_minutes),1) AS AVG_actual_dt
FROM del
WHERE late_delivery = 1
GROUP BY partner_exp_group
ORDER BY premium_cst DESC;



# Identifying  cancelled order volumes by customer type and partner experienced months

SELECT
CASE
  WHEN delivery_partner_experience_months >=1 AND delivery_partner_experience_months <=15 THEN 'new'
  WHEN delivery_partner_experience_months >=16 AND delivery_partner_experience_months <=30 THEN 'developing'
  WHEN delivery_partner_experience_months >=31 AND delivery_partner_experience_months <=45 THEN 'experienced'
  WHEN delivery_partner_experience_months >=46 AND delivery_partner_experience_months <=60 THEN
  'expert'
  END AS partner_exp_group,
COUNT(CASE WHEN customer_type = 'Regular' THEN order_id END) AS regular_cst,
COUNT(CASE WHEN customer_type = 'Premium' THEN order_id END) AS premium_cst,
COUNT(CASE WHEN customer_type = 'New' THEN order_id END) AS new_cst,
ROUND(AVG(actual_delivery_time_minutes),1) AS AVG_actual_dt
FROM del
WHERE late_delivery = 'cancelled_order'
GROUP BY partner_exp_group
ORDER BY premium_cst DESC;


# Identifying averaged tip-amount and sub-total by customer type

SELECT customer_type,
ROUND(AVG(discount_percent),1) AS AVG_discount_percent,
ROUND(AVG(items_count),1) AS AVG_items,
ROUND(AVG(subtotal),1) AS AVG_subtotal,
ROUND(AVG(service_fee),1) AS AVG_service_fee,
ROUND(AVG(delivery_fee),1) AS AVG_delivery_fee,
ROUND(AVG(tip_amount),1) AS AVG_tip_amount,
FORMAT(COUNT(order_id),0) AS of_orders
FROM del
GROUP BY customer_type
ORDER BY of_orders DESC;


# Identifying averaged restaurant, partner and customer rating by customer type

SELECT customer_type,
ROUND(AVG(`restaurant_rating`),2) AS AVG_restaurant_rating,
ROUND(AVG(`delivery_partner_rating`),2) AS partner_rating,
ROUND(AVG(`customer_rating`),2) AS AVG_customer_rating,
FORMAT(COUNT(order_id),0) AS of_orders
FROM del
GROUP BY customer_type
ORDER BY of_orders DESC;




SELECT `restaurant_primary_category`,
ROUND(AVG(`restaurant_rating`),2) AS AVG_restaurant_rating,
ROUND(AVG(`delivery_partner_rating`),2) AS partner_rating,
ROUND(AVG(`customer_rating`),2) AS AVG_customer_rating,
FORMAT(COUNT(order_id),0) AS of_orders
FROM del
GROUP BY restaurant_primary_category
ORDER BY of_orders DESC;


# Identifying averaged restaurant, partner and customer rating by restaurant category

SELECT `restaurant_primary_category`,
ROUND(AVG(`restaurant_rating`),2) AS AVG_restaurant_rating,
ROUND(AVG(`delivery_partner_rating`),2) AS partner_rating,
ROUND(AVG(`customer_rating`),2) AS AVG_customer_rating,
FORMAT(COUNT(order_id),0) AS of_orders
FROM del
GROUP BY restaurant_primary_category
ORDER BY of_orders DESC;

# Identifying customer-cancelled orders by customer type and partner experienced months

SELECT
CASE
  WHEN delivery_partner_experience_months >=1 AND delivery_partner_experience_months <=15 THEN 'new'
  WHEN delivery_partner_experience_months >=16 AND delivery_partner_experience_months <=30 THEN 'developing'
  WHEN delivery_partner_experience_months >=31 AND delivery_partner_experience_months <=45 THEN 'experienced'
  WHEN delivery_partner_experience_months >=46 AND delivery_partner_experience_months <=60 THEN
  'expert'
  END AS partner_exp_group,
 
 COUNT(CASE WHEN customer_type = 'New' THEN order_id END) AS new_cst,
 COUNT(CASE WHEN customer_type = 'Regular' THEN order_id END) AS regular_cst,
 COUNT(CASE WHEN customer_type = 'Premium' THEN order_id END) AS premium_cst,
 COUNT(order_id) AS of_orders
 FROM del
 WHERE cancellation_reason = 'Customer Cancelled'
 GROUP BY partner_exp_group
 ORDER BY of_orders DESC;


# Identifying long-preparation-delayed orders by customer type and partner experienced months

SELECT
CASE
  WHEN delivery_partner_experience_months >=1 AND delivery_partner_experience_months <=15 THEN 'new'
  WHEN delivery_partner_experience_months >=16 AND delivery_partner_experience_months <=30 THEN 'developing'
  WHEN delivery_partner_experience_months >=31 AND delivery_partner_experience_months <=45 THEN 'experienced'
  WHEN delivery_partner_experience_months >=46 AND delivery_partner_experience_months <=60 THEN
  'expert'
  END AS partner_exp_group,
 
 COUNT(CASE WHEN customer_type = 'New' THEN order_id END) AS new_cst,
 COUNT(CASE WHEN customer_type = 'Regular' THEN order_id END) AS regular_cst,
 COUNT(CASE WHEN customer_type = 'Premium' THEN order_id END) AS premium_cst,
 COUNT(order_id) AS of_orders
 FROM del
 WHERE cancellation_reason = 'Long Prep Delay'
 GROUP BY partner_exp_group
 ORDER BY of_orders DESC;




# Identifying Driver Unassigned orders by customer type and partner experienced months


SELECT
CASE
  WHEN delivery_partner_experience_months >=1 AND delivery_partner_experience_months <=15 THEN 'new'
  WHEN delivery_partner_experience_months >=16 AND delivery_partner_experience_months <=30 THEN 'developing'
  WHEN delivery_partner_experience_months >=31 AND delivery_partner_experience_months <=45 THEN 'experienced'
  WHEN delivery_partner_experience_months >=46 AND delivery_partner_experience_months <=60 THEN
  'expert'
  END AS partner_exp_group,
 
 COUNT(CASE WHEN customer_type = 'New' THEN order_id END) AS new_cst,
 COUNT(CASE WHEN customer_type = 'Regular' THEN order_id END) AS regular_cst,
 COUNT(CASE WHEN customer_type = 'Premium' THEN order_id END) AS premium_cst,
 COUNT(order_id) AS of_orders
 FROM del
 WHERE cancellation_reason = 'Driver Unassigned'
 GROUP BY partner_exp_group
 ORDER BY of_orders DESC;


# Identifying restaurant preparation , estimated and actual time on average by cancellation reason


SELECT
     cancellation_reason,
     ROUND(AVG(restaurant_preparation_time_minutes),1) AS AVG_prep_time,
     ROUND(AVG(estimated_delivery_time_minutes),1) AS AVG_estimated_time,
     ROUND(AVG(actual_delivery_time_minutes),1) AS AVG_actual_dtime,
     COUNT(order_id) AS order_volume 
FROM del
GROUP BY cancellation_reason
ORDER BY order_volume;



# Identifying customer, partner, restaurant ratings , estimated dan actual 	
 time on average by customer type with condition customer_rating less than 4.0	
	
SELECT	
   `customer_type`,	
   ROUND(AVG(`customer_rating`),1) AS customer_rt,	
   ROUND(AVG(`restaurant_rating`),1) AS restaurant_rt,	
   ROUND(AVG(`delivery_partner_rating`),1) AS del_partner_rt,	
   ROUND(AVG(`restaurant_preparation_time_minutes`),1) AS rest_pre_time,	
   ROUND(AVG(estimated_delivery_time_minutes),1) AS est_del_time,	
   ROUND(AVG(`actual_delivery_time_minutes`),1) AS act_del_time,	
   FORMAT(COUNT(order_id),0) AS order_volume	
FROM del	
WHERE customer_rating < 4.0	
GROUP BY `customer_type`	
ORDER BY order_volume;	



# Identifying customer, partner, restaurant ratings , estimated dan actual 				
 time on average by customer type with condition customer_rating  equal and more than 4.0				
				
SELECT				
   `customer_type`,				
   ROUND(AVG(`customer_rating`),1) AS customer_rt,				
   ROUND(AVG(`restaurant_rating`),1) AS restaurant_rt,				
   ROUND(AVG(`delivery_partner_rating`),1) AS del_partner_rt,				
   ROUND(AVG(`restaurant_preparation_time_minutes`),1) AS rest_pre_time,				
   ROUND(AVG(estimated_delivery_time_minutes),1) AS est_del_time,				
   ROUND(AVG(`actual_delivery_time_minutes`),1) AS act_del_time,				
   FORMAT(COUNT(order_id),0) AS order_volume				
FROM del				
WHERE customer_rating >= 4.0				
GROUP BY `customer_type`				
ORDER BY order_volume;				


# Comparing order volume and restaurant preparation time on average on weekend and weekdays			
			
SELECT			
customer_type,			
COUNT(CASE WHEN is_weekend = 1 THEN order_id END) AS _of_order_w_end,			
ROUND(AVG(CASE WHEN is_weekend = 1 THEN `restaurant_preparation_time_minutes` END),1) AS AVG_prep_time_w_end,			
COUNT(CASE WHEN is_weekend = 0 THEN order_id END) AS _of_order_w_days,			
ROUND(AVG(CASE WHEN is_weekend = 0 THEN `restaurant_preparation_time_minutes` END),1) AS AVG_prep_time_w_days			
FROM del			
GROUP BY customer_type			
ORDER BY _of_order_w_end DESC;			























