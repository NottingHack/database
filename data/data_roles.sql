INSERT INTO `zones` (`id`, `description`, `short_name`, `permission_code`, `restricted`, `building_id`) VALUES
('0', 'Off-site', 'Off-site', 'gatekeeper.zoneEntry.outside', '0', NULL),
('1', 'Metalworking, classroom & bike storage', 'Zone 1', 'gatekeeper.zoneEntry.classRoomMetalworking', '0', '1'),
('2', 'CNC & blue room', 'Zone 2', 'gatekeeper.zoneEntry.cncBlueRoom', '0', '1'),
('3', 'Downstairs Team storage', 'Zone 3', 'gatekeeper.zoneEntry.teamStorage', '1', '1'),
('4', 'Downstairs Member storage', 'Zone 4', 'gatekeeper.zoneEntry.downstairsMembersStorage', '0', '1'),
('5', 'Upstairs / HS2.0', 'Zone 5', 'gatekeeper.zoneEntry.upstairs', '0', '1');
