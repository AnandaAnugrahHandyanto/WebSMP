-- Admin
INSERT IGNORE INTO users (username, password, role) VALUES ('admin', 'admin', 'admin');
-- Guru (username = NIP guru)
INSERT IGNORE INTO users (username, password, role) VALUES ('198501012010011001', 'guru', 'guru');
INSERT IGNORE INTO users (username, password, role) VALUES ('198702022011012002', 'guru', 'guru');
-- Siswa (username = NIS siswa)
INSERT IGNORE INTO users (username, password, role) VALUES ('2024001', 'siswa', 'siswa');
INSERT IGNORE INTO users (username, password, role) VALUES ('2024002', 'siswa', 'siswa');
INSERT IGNORE INTO users (username, password, role) VALUES ('2024003', 'siswa', 'siswa');
