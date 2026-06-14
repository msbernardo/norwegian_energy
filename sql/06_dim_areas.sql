CREATE TABLE core.dim_areas (
    area_map_code       TEXT PRIMARY KEY,
    area_display_name   TEXT,
    area_type           TEXT,       -- 'Country', 'Bidding Zone', 'Neighbour'
    country             TEXT,
    region              TEXT,       -- geographic region within Norway
    tso                 TEXT,       -- Transmission System Operator
    is_norway           BOOLEAN,
    latitude            NUMERIC(7,4),
    longitude           NUMERIC(7,4)
);


INSERT INTO core.dim_areas VALUES
-- Norwegian aggregate
('NO',   'Norway',              'Country',      'Norway',  'National',  'Statnett', TRUE,  64.5731,  17.8880),

-- Norwegian bidding zones
('NO1',  'Norway SE',           'Bidding Zone', 'Norway',  'Southeast', 'Statnett', TRUE,  59.9139,  10.7522),
('NO2',  'Norway SW',           'Bidding Zone', 'Norway',  'Southwest', 'Statnett', TRUE,  58.9700,   5.7331),
('NO3',  'Norway Central',      'Bidding Zone', 'Norway',  'Central',   'Statnett', TRUE,  63.4305,  10.3951),
('NO4',  'Norway North',        'Bidding Zone', 'Norway',  'North',     'Statnett', TRUE,  68.4385,  17.4279),
('NO5',  'Norway West',         'Bidding Zone', 'Norway',  'West',      'Statnett', TRUE,  60.3913,   5.3221),

-- Neighbouring countries Norway trades with
('SE',   'Sweden',              'Country',      'Sweden',  'National',        'Svenska Kraftnät', FALSE, 60.1282, 18.6435),
('DK',   'Denmark',             'Country',      'Denmark', 'National',        'Energinet',        FALSE, 56.2639,  9.5018),
('DK1',  'Denmark West',        'Bidding Zone', 'Denmark', 'West',      'Energinet',        FALSE, 56.0000,  9.0000),
('DK2',  'Denmark East',        'Bidding Zone', 'Denmark', 'East',      'Energinet',        FALSE, 55.6761, 12.5683),
('DE',   'Germany',             'Country',      'Germany', 'National',        '50Hertz/TenneT',   FALSE, 51.1657, 10.4515),
('NL',   'Netherlands',         'Country',      'Netherlands', 'National',    'TenneT NL',        FALSE, 52.1326,  5.2913),
('GB',   'Great Britain',       'Country',      'Great Britain', 'National',  'National Grid',    FALSE, 55.3781, -3.4360),
('FI',   'Finland',             'Country',      'Finland', 'National',        'Fingrid',          FALSE, 61.9241, 25.7482);