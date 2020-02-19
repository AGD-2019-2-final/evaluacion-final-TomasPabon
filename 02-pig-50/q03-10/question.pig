-- Pregunta
-- ===========================================================================
-- 
-- Obtenga los cinco (5) valores más pequeños de la 3ra columna.
-- Escriba el resultado a la carpeta `output` del directorio actual.
-- 
fs -rm -f -r output;
--
-- >>> Escriba su respuesta a partir de este punto <<<
--
data = LOAD 'data.tsv' USING PigStorage('\t')
    AS (letter:CHARARRAY,
        date:CHARARRAY,
        amount:INT);

dataordered = ORDER data BY amount;

firstfive = LIMIT dataordered 5;

firstfiveamount = FOREACH firstfive GENERATE amount;

STORE firstfiveamount INTO 'output' using PigStorage('\t');
