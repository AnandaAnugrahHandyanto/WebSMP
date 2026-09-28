package dao;

import config.Koneksi;
import model.Jadwal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class JadwalDAO {

    private Connection koneksi;

    public JadwalDAO() {
        koneksi = Koneksi.getConnection();
    }

    private static final String SELECT_JADWAL = "SELECT j.*, k.nama_kelas, m.nama_mapel, g.nama_guru FROM jadwal j JOIN kelas k ON j.id_kelas = k.id_kelas JOIN mapel m ON j.id_mapel = m.id_mapel JOIN guru g ON j.id_guru = g.id_guru ";

    public void simpan(Jadwal j) {
        String sql = "INSERT INTO jadwal (id_kelas, id_mapel, id_guru, hari, jam_mulai, jam_selesai, ruang) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = koneksi.prepareStatement(sql)) {
            ps.setInt(1, j.getIdKelas());
            ps.setInt(2, j.getIdMapel());
            ps.setInt(3, j.getIdGuru());
            ps.setString(4, j.getHari());
            ps.setString(5, j.getJamMulai());
            ps.setString(6, j.getJamSelesai());
            ps.setString(7, j.getRuang());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void update(Jadwal j) {
        String sql = "UPDATE jadwal SET id_kelas=?, id_mapel=?, id_guru=?, hari=?, jam_mulai=?, jam_selesai=?, ruang=? WHERE id_jadwal=?";
        try (PreparedStatement ps = koneksi.prepareStatement(sql)) {
            ps.setInt(1, j.getIdKelas());
            ps.setInt(2, j.getIdMapel());
            ps.setInt(3, j.getIdGuru());
            ps.setString(4, j.getHari());
            ps.setString(5, j.getJamMulai());
            ps.setString(6, j.getJamSelesai());
            ps.setString(7, j.getRuang());
            ps.setInt(8, j.getIdJadwal());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void hapus(int idJadwal) {
        String sql = "DELETE FROM jadwal WHERE id_jadwal=?";
        try (PreparedStatement ps = koneksi.prepareStatement(sql)) {
            ps.setInt(1, idJadwal);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Jadwal> getAll() {
        List<Jadwal> list = new ArrayList<>();
        String sql = SELECT_JADWAL + "ORDER BY FIELD(j.hari, 'Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat'), j.jam_mulai";
        try (PreparedStatement ps = koneksi.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(map(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Jadwal> getByHari(String hari) {
        List<Jadwal> list = new ArrayList<>();
        String sql = SELECT_JADWAL + "WHERE j.hari = ? ORDER BY j.jam_mulai";
        try (PreparedStatement ps = koneksi.prepareStatement(sql)) {
            ps.setString(1, hari);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(map(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Jadwal> getByGuru(int idGuru) {
        List<Jadwal> list = new ArrayList<>();
        String sql = SELECT_JADWAL + "WHERE j.id_guru = ? ORDER BY FIELD(j.hari, 'Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat'), j.jam_mulai";
        try (PreparedStatement ps = koneksi.prepareStatement(sql)) {
            ps.setInt(1, idGuru);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(map(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Jadwal> getByKelas(int idKelas) {
        List<Jadwal> list = new ArrayList<>();
        String sql = SELECT_JADWAL + "WHERE j.id_kelas = ? ORDER BY FIELD(j.hari, 'Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat'), j.jam_mulai";
        try (PreparedStatement ps = koneksi.prepareStatement(sql)) {
            ps.setInt(1, idKelas);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(map(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Jadwal getById(int idJadwal) {
        Jadwal hasil = null;
        String sql = SELECT_JADWAL + "WHERE j.id_jadwal = ?";
        try (PreparedStatement ps = koneksi.prepareStatement(sql)) {
            ps.setInt(1, idJadwal);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    hasil = map(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return hasil;
    }

    private Jadwal map(ResultSet rs) throws SQLException {
        Jadwal j = new Jadwal();
        j.setIdJadwal(rs.getInt("id_jadwal"));
        j.setIdKelas(rs.getInt("id_kelas"));
        j.setIdMapel(rs.getInt("id_mapel"));
        j.setIdGuru(rs.getInt("id_guru"));
        j.setHari(rs.getString("hari"));
        j.setJamMulai(rs.getString("jam_mulai"));
        j.setJamSelesai(rs.getString("jam_selesai"));
        j.setRuang(rs.getString("ruang"));
        j.setNamaKelas(rs.getString("nama_kelas"));
        j.setNamaMapel(rs.getString("nama_mapel"));
        j.setNamaGuru(rs.getString("nama_guru"));
        return j;
    }
}