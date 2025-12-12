/*
    Union de facturas del trimestre + devoluciones + notas de crédito.
*/

SELECT no_fac, cve_factu, falta_fac, subt_fac, descuento, status_fac, 1 AS fuente
FROM facturac
WHERE cve_age = 8
  AND falta_fac BETWEEN DATE(2023,01,01) AND DATE(2023,03,31)
  AND status_fac <> 'Cancelada'

UNION

SELECT no_fac, cve_factu, fecha, tot_imp * -1, tot_des * -1, tip_not, 2
FROM creditos
WHERE fecha BETWEEN DATE(2023,01,01) AND DATE(2023,03,31)
  AND no_agente = 8
  AND tip_not <> 'Descuento'
  AND no_estado <> 'Cancelada'

UNION

SELECT no_fac, cve_factu, fecha, 0,
       CASE WHEN tot_des = 0 THEN tot_imp ELSE 33 END,
       tip_not, 3
FROM creditos
WHERE fecha BETWEEN DATE(2023,01,01) AND DATE(2023,03,31)
  AND no_agente = 8
  AND tip_not = 'Descuento'
  AND no_estado <> 'Cancelada';
