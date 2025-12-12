SELECT
    MAX(fecha) AS fecha_liquidacion,
    cve_factu,
    no_fac,
    MAX(num) AS ultimo_numero_pago,
    tipo
FROM pagos2
WHERE no_fac = '25138'
  AND cve_factu = 'CC'
  AND tipo <> 'Nota Cred'
GROUP BY cve_factu, no_fac, tipo;
