INSERT INTO `doors` (`id`, `side_a_zone_id`, `side_b_zone_id`, `description`, `short_name`, `state`, `state_change`, `permission_code`) VALUES
  (1, 0, NULL, 'Upstairs inner Gatekeeper door', 'UP-INNER', 'LOCKED', '2019-01-13 14:02:32', NULL),
  (2, NULL, NULL, 'Upstairs outer door', 'UP-OUTER', 'UNKNOWN', '2019-01-13 14:02:32', NULL),
  (3, NULL, NULL, 'Workshop door', 'WORKSHOP', 'UNKNOWN', '2019-01-13 14:02:32', NULL),
  (4, 0, 2, 'CNC corridor door', 'CNCCORIDOR', 'LOCKED', '2019-01-13 14:02:32', NULL),
  (6, 0, 2, 'Communal (Left)', 'COMMUNAL-L', 'LOCKED', '2019-01-13 14:02:32', NULL);
