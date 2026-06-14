ALTER TABLE core.load ADD COLUMN total_load_mwh NUMERIC(12,2);


UPDATE core.load
SET total_load_mwh = total_load_mw *
    CASE resolution_code
        WHEN 'PT60M' THEN 1.0
        WHEN 'PT30M' THEN 0.5
        WHEN 'PT15M' THEN 0.25
        ELSE 1.0
    END;

ALTER TABLE core.generation ADD COLUMN actual_generation_mwh NUMERIC(12,2);

UPDATE core.generation
SET actual_generation_mwh = generation_mw *
    CASE resolution_code
        WHEN 'PT60M' THEN 1.0
        WHEN 'PT30M' THEN 0.5
        WHEN 'PT15M' THEN 0.25
        ELSE 1.0
    END;

ALTER TABLE core.generation ADD COLUMN actual_consumption_mwh NUMERIC(12,2);

UPDATE core.generation
SET actual_consumption_mwh = consumption_mw *
    CASE resolution_code
        WHEN 'PT60M' THEN 1.0
        WHEN 'PT30M' THEN 0.5
        WHEN 'PT15M' THEN 0.25
        ELSE 1.0
    END;

ALTER TABLE core.flows ADD COLUMN flow_mwh NUMERIC(12,2);

UPDATE core.flows
SET flow_mwh = flow_mw *
    CASE resolution_code
        WHEN 'PT60M' THEN 1.0
        WHEN 'PT30M' THEN 0.5
        WHEN 'PT15M' THEN 0.25
        ELSE 1.0
    END;