-- Pregunta
-- ===========================================================================
-- 
-- Para el archivo `data.tsv` compute la cantidad de registros por letra de la 
-- columna 2 y clave de al columna 3; esto es, por ejemplo, la cantidad de 
-- registros en tienen la letra `b` en la columna 2 y la clave `jjj` en la 
-- columna 3 es:
-- 
--   ((b,jjj), 216)
-- 
-- Escriba el resultado a la carpeta `output` del directorio actual.
-- 
fs -rm -f -r output;
--
-- >>> Escriba su respuesta a partir de este punto <<<
--
data = LOAD 'data.tsv' USING PigStorage('\t')
    AS (letter:CHARARRAY,
        letter_list:BAG{t: tuple(a:CHARARRAY)},
        list:MAP[]);

ans = FOREACH data GENERATE FLATTEN(letter_list) AS letter_list, FLATTEN(list) AS keylist;

groups = GROUP ans BY (letter_list,keylist);

ans = FOREACH groups GENERATE group, COUNT(ans);

STORE ans INTO 'output' using PigStorage('\t');
