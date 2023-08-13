-- 1. obtener los ingresos totales para marzo de 2012
SELECT SUM(amount) AS monto_total, DATE_FORMAT(billing.charged_datetime, '%M') AS mes
FROM billing
WHERE MONTH(billing.charged_datetime) = 3 AND YEAR(billing.charged_datetime) = 2012;

-- 2. obtener los ingresos totales recaudados del cliente con un id de 2
SELECT billing.client_id, SUM(billing.amount) AS ingresos_totales
FROM billing
WHERE client_id = 2;

-- 3. obtener todos los sitios que posee client = 10
SELECT sites.domain_name, sites.client_id
FROM sites
WHERE sites.client_id = 10;

-- 4. obtener el número total de sitios creados por mes por año para los clientes con una id de 1 y de 20
SELECT sites.client_id, COUNT(sites.site_id) AS numero_sitios, DATE_FORMAT(sites.created_datetime, '%M') AS mes, DATE_FORMAT(sites.created_datetime, '%Y') AS anio
FROM sites
WHERE sites.client_id = 1 OR sites.client_id = 20
GROUP BY mes, anio
ORDER BY client_id, anio, mes;

-- 5. obtener el número total de clientes potenciales generados para cada uno de los sitios entre el 1 de enero de 2011 y el 15 de febrero de 2011
SELECT sites.domain_name, COUNT(leads.leads_id) AS num_clientes_potenciales, DATE_FORMAT(leads.registered_datetime, '%M %d, %Y') AS fecha_registro
FROM sites
JOIN leads ON sites.site_id = leads.site_id
WHERE leads.registered_datetime BETWEEN '2011-01-01' AND '2011-02-15'
GROUP BY sites.site_id
ORDER BY registered_datetime;

-- 6. obtener una lista de nombres de clientes y número total de clientes potenciales que hemos generado para cada uno de nuestros clientes entre el 1 de enero de 2011 y el 31 de diciembre de 2011?
SELECT CONCAT(clients.first_name, ' ', clients.last_name) AS clientes, COUNT(leads.leads_id) AS clientes_potenciales
FROM clients
LEFT JOIN sites ON clients.client_id = sites.client_id
LEFT JOIN leads ON leads.site_id = sites.site_id
WHERE YEAR(leads.registered_datetime) = 2011
GROUP BY clients.client_id;

-- 7. obtener una lista de nombres de clientes y número total de clientes potenciales que hemos generado para cada cliente cada mes entre los meses 1 y 6 del año 2011
SELECT CONCAT(clients.first_name,' ',clients.last_name) AS nombre_cliente, COUNT(leads_id) AS clientes_potenciales, DATE_FORMAT(leads.registered_datetime, '%M') AS mes
FROM clients
LEFT JOIN sites ON clients.client_id = sites.client_id
JOIN leads ON leads.site_id = sites.site_id
WHERE leads.registered_datetime BETWEEN '2011-01-01' AND '2011-06-30'
GROUP BY clients.client_id, MONTH(leads.registered_datetime);

-- 8. obtener una lista de nombres de clientes y el número total de clientes potenciales que hemos generado para cada uno de los sitios de nuestros clientes entre el 1 de enero de 2011 y el 31 de diciembre de 2011. Solicite esta consulta por ID de cliente.
SELECT CONCAT(clients.first_name,' ',clients.last_name) AS nombre_cliente, sites.domain_name, COUNT(leads.leads_id) AS clientes_potenciales, DATE_FORMAT(leads.registered_datetime, '%M %d, %Y') AS fecha
FROM clients
LEFT JOIN sites ON clients.client_id = sites.client_id
JOIN leads ON leads.site_id = sites.site_id
WHERE YEAR(leads.registered_datetime) = 2011
GROUP BY sites.domain_name
ORDER BY clients.client_id, created_datetime;

--  Presente una segunda consulta que muestre todos los clientes, los nombres del sitio y el número total de clientes potenciales generados en cada sitio en todo momento.
SELECT CONCAT(clients.first_name,' ',clients.last_name) AS nombre_cliente, sites.domain_name, COUNT(leads.leads_id) AS clientes_potenciales
FROM clients
LEFT JOIN sites ON clients.client_id = sites.client_id
LEFT JOIN leads ON leads.site_id = sites.site_id
GROUP BY sites.domain_name, clients.client_id
ORDER BY clients.client_id;

-- 9. Escriba una sola consulta que recupere los ingresos totales recaudados de cada cliente para cada mes del año. Pídalo por ID de cliente.
SELECT CONCAT(clients.first_name, " ",clients.last_name) AS client_name, SUM(billing.amount) AS total_revenue, DATE_FORMAT(billing.charged_datetime, '%m') as month_charge, DATE_FORMAT(billing.charged_datetime, '%Y') as year_charge
FROM clients
JOIN billing ON clients.client_id = billing.client_id
GROUP BY clients.client_id, month_charge, year_charge
ORDER BY clients.client_id, YEAR(billing.charged_datetime), MONTH(billing.charged_datetime);

-- 10. Escriba una sola consulta que recupere todos los sitios que posee cada cliente. Agrupe los resultados para que cada fila muestre un nuevo cliente. Se volverá más claro cuando agregue un nuevo campo llamado 'sitios' que tiene todos los sitios que posee el cliente. (SUGERENCIA: use GROUP_CONCAT)
SELECT CONCAT(clients.first_name, " ",clients.last_name) AS nombre_cliente, GROUP_CONCAT(' ',sites.domain_name) AS sitios
FROM clients
LEFT JOIN sites ON clients.client_id = sites.client_id
GROUP BY clients.client_id;
