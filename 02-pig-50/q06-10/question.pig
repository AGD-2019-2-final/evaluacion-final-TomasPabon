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

letter_list = FOREACH data GENERATE letter_list;

letters = FOREACH letter_list GENERATE FLATTEN(letter_list) AS letter;

groups = GROUP letters BY letter;

lettercount = FOREACH groups GENERATE group, COUNT(letters);

STORE lettercount INTO 'output' using PigStorage('\t');
