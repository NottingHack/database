INSERT INTO `doors` (`id`, `side_a_zone_id`, `side_b_zone_id`, `description`, `short_name`, `state`, `state_change`) VALUES
  (1, 0, 5, 'Upstairs inner Gatekeeper door', 'UP-INNER', 'LOCKED', '2019-01-13 14:02:32'),
  (2, 0, 0, 'Upstairs outer door', 'UP-OUTER', 'UNKNOWN', '2019-01-13 14:02:32'),
  (3, 0, 5, 'Workshop door', 'WORKSHOP', 'UNKNOWN', '2019-01-13 14:02:32'),
  (4, 0, 2, 'CNC corridor door', 'CNCCORIDOR', 'LOCKED', '2019-01-13 14:02:32'),
  (5, 2, 4, 'Team storage', 'TEAMSTORE', 'UNKNOWN', UTC_TIMESTAMP()),
  (6, 0, 2, 'Communal (Left)', 'COMMUNAL-L', 'LOCKED', '2019-01-13 14:02:32');
