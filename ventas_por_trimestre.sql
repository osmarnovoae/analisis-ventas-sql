/*
    Ventas por trimestre por agente
    Detalle de facturas, clientes y productos filtrados por periodo.
*/

SELECT *
FROM (
    SELECT ventas.*, facturad.cse_prod, facturad.cve_prod,
           facturad.cant_surt, facturad.subt_prod, facturad.valor_prod
    FROM (
        SELECT *
        FROM (
            SELECT cve_factu, status_2, status_fac, cve_cte, no_fac,
                   falta_fac, f_pago AS fecha_venc, subt_fac
            FROM facturac
            WHERE falta_fac BETWEEN DATE(2024,01,01) AND DATE(2024,03,31)
              AND cve_age = 8
              AND status_fac = 'Pagada'
        ) AS folios
        JOIN (
            SELECT nom_cte, cve_cte, dia_cre
            FROM clientes
        ) AS clientes
          ON clientes.cve_cte = folios.cve_cte
    ) AS ventas
    JOIN facturad
      ON facturad.no_fac = ventas.no_fac
     AND facturad.cve_factu = ventas.cve_factu
) AS venta_detalle
WHERE cse_prod IN ('A','AA','B','C','D'); 
