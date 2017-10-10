use DATABASE_NAME;

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

CREATE TABLE `ajxp_users` (
  `login` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `groupPath` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `ajxp_users` (`login`, `password`, `groupPath`) VALUES
('admin', 'sha256:1000:SH2I3qCiMqtpKQiiGf16I9GJrZM22q8I:Tib5ZnN0lZDV/DwCC7s0LfZhBxH/myhz', '/');

ALTER TABLE `ajxp_users`
  ADD PRIMARY KEY (`login`);
