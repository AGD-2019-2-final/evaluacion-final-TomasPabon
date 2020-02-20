--
-- Pregunta
-- ===========================================================================
--
-- Para el archivo `data.tsv` Calcule la cantidad de registros por clave de la
-- columna 3. En otras palabras, cuántos registros hay que tengan la clave
-- `aaa`?
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

list = FOREACH data GENERATE list;

keyvalues = FOREACH list GENERATE FLATTEN(list) AS keyvalues;

groups = GROUP keyvalues BY keyvalues;

keycount = FOREACH groups GENERATE group, COUNT(keyvalues);

STORE keycount INTO 'output' using PigStorage(',');
