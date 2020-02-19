-- 
-- Pregunta
-- ===========================================================================
-- 
-- Para el archivo `data.tsv` compute la cantidad de registros por letra. 
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

groups = GROUP data BY letter;

lettercount = FOREACH groups GENERATE group, COUNT(data);

STORE lettercount INTO 'output' using PigStorage('\t');
