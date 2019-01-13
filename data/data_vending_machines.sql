INSERT INTO `vending_machines` (`id`, `description`, `type`, `connection`, `address`) VALUES
  (1, 'Studio vending machine', 'VEND', 'UDP', '192.168.0.12'),
  (2, 'Note acceptor', 'NOTE', 'MQTT', 'nh/note_acc/'),
  (3, 'Coin acceptor', 'NOTE', 'MQTT', 'nh/coin_acc/'),
  (4, 'Can vending machine', 'VEND', 'MQTT', 'nh/can_vend/');
