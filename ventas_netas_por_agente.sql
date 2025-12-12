/*
    Obtiene la venta neta del trimestre considerando:
    - facturación
    - devoluciones
    - notas de crédito
*/

SELECT CAST((SUM(ventas.subt_fac) - SUM(ventas.descuento)) AS NUMERIC(8,2)) AS venta_neta
FROM (
    SELECT no_fac, cve_factu, falta_fac, subt_fac, descuento, status_fac
    FROM facturac
    WHERE cve_age = 10
      AND falta_fac BETWEEN DATE(2023,01,01) AND DATE(2023,03,31)
      AND status_fac <> 'Cancelada'

    UNION

    SELECT no_fac, cve_factu, fecha, tot_imp * -1, tot_des * -1, tip_not
    FROM creditos
    WHERE fecha BETWEEN DATE(2023,01,01) AND DATE(2023,03,31)
      AND no_agente = 10
      AND tip_not <> 'Descuento'
      AND no_estado <> 'Cancelada'

    UNION

    SELECT no_fac, cve_factu, fecha, 0,
           CASE WHEN tot_des = 0 THEN tot_imp ELSE 33 END,
           tip_not
    FROM creditos
    WHERE fecha BETWEEN DATE(2023,01,01) AND DATE(2023,03,31)
      AND no_agente = 10
      AND tip_not = 'Descuento'
      AND no_estado <> 'Cancelada'
) AS ventas;
