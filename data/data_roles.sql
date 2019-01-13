INSERT INTO `roles` (`id`, `name`, `display_name`, `description`, `deleted_at`, `created_at`, `updated_at`, `email`, `slack_channel`, `retained`) VALUES
  (1, 'member.approval', 'Awaiting Approval', 'Member awaiting approval', NULL, '2019-01-13 14:02:40', '2019-01-13 14:02:40', NULL, NULL, 0),
  (2, 'member.payment', 'Awaiting Payment', 'Awaiting standing order payment', NULL, '2019-01-13 14:02:40', '2019-01-13 14:02:40', NULL, NULL, 0),
  (3, 'member.young', 'Young Hacker', 'Member between 16 and 18', NULL, '2019-01-13 14:02:40', '2019-01-13 14:02:40', NULL, NULL, 0),
  (4, 'member.ex', 'Ex Member', 'Ex Member', NULL, '2019-01-13 14:02:40', '2019-01-13 14:02:40', NULL, NULL, 0),
  (5, 'member.current', 'Current Member', 'Current Member', NULL, '2019-01-13 14:02:40', '2019-01-13 14:02:40', NULL, NULL, 0),
  (6, 'member.temporarybanned', 'Temporary Banned Member', 'Temporary Banned Member', NULL, '2019-01-13 14:02:40', '2019-01-13 14:02:40', NULL, NULL, 1),
  (7, 'member.banned', 'Banned Member', 'Banned Member', NULL, '2019-01-13 14:02:40', '2019-01-13 14:02:40', NULL, NULL, 1),
  (8, 'user.super', 'Super User', 'Full access to all parts of the system', NULL, '2019-01-13 14:02:40', '2019-01-13 14:02:40', NULL, NULL, 0),
  (9, 'team.membership', 'Membership Team', 'Membership Team', NULL, '2019-01-13 14:02:40', '2019-01-13 14:02:40', 'membership@nottinghack.org.uk', '#membership', 0),
  (10, 'team.trustees', 'Nottingham Hackspace Trustees', 'The Trustees', NULL, '2019-01-13 14:02:41', '2019-01-13 14:02:41', 'trustees@nottinghack.org.uk', '#general', 0),
  (11, 'team.software', 'Software Team', 'Software Team', NULL, '2019-01-13 14:02:41', '2019-01-13 14:02:41', 'software@nottinghack.org.uk', '#software', 0),
  (12, 'team.finance', 'Finance Team', 'Finance Team', NULL, '2019-01-13 14:02:41', '2019-01-13 14:02:41', 'accounts@nottinghack.org.uk', NULL, 0),
  (13, 'team.network', 'Network Team', 'Network Team', NULL, '2019-01-13 14:02:41', '2019-01-13 14:02:41', 'network@nottinghack.org.uk', NULL, 0);
