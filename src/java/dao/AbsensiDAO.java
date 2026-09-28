package dao;

import config.Koneksi;
import model.Absensi;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AbsensiDAO {

    private Connection koneksi;

    public AbsensiDAO() {
        koneksi = Koneksi.getConnection();
    }

    private static final String SELECT_ABSENSI = "SELECT a.*, s.nama_siswa, k.nama_kelas FROM absensi a JOIN siswa s ON a.id_siswa = s.id_siswa LEFT JOIN kelas k ON s.id_kelas = k.id_kelas ";

    public void simpan(Absensi a) {
        String sql = "INSERT INTO absensi (id_siswa, tanggal, status, keterangan) VALUES (?, ?, ?, ?) ON DUPLICATE KEY UPDATE status=VALUES(status), keterangan=VALUES(keterangan)";
        try (PreparedStatement ps = koneksi.prepareStatement(sql)) {
            ps.setInt(1, a.getIdSiswa());
            ps.setString(2, a.getTanggal());
            ps.setString(3, a.getStatus());
            ps.setString(4, a.getKeterangan());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void update(Absensi a) {
        String sql = "UPDATE absensi SET id_siswa=?, tanggal=?, status=?, keterangan=? WHERE id_absensi=?";
        try (PreparedStatement ps = koneksi.prepareStatement(sql)) {
            ps.setInt(1, a.getIdSiswa());
            ps.setString(2, a.getTanggal());
            ps.setString(3, a.getStatus());
            ps.setString(4, a.getKeterangan());
            ps.setInt(5, a.getIdAbsensi());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void hapus(int idAbsensi) {
        String sql = "DELETE FROM absensi WHERE id_absensi=?";
        try (PreparedStatement ps = koneksi.prepareStatement(sql)) {
            ps.setInt(1, idAbsensi);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Absensi> getAll() {
        List<Absensi> list = new ArrayList<>();
        String sql = SELECT_ABSENSI + "ORDER BY a.tanggal DESC, s.nama_siswa";
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

    public List<Absensi> getByTanggal(String tanggal) {
        List<Absensi> list = new ArrayList<>();
        String sql = SELECT_ABSENSI + "WHERE a.tanggal = ? ORDER BY s.nama_siswa";
        try (PreparedStatement ps = koneksi.prepareStatement(sql)) {
            ps.setString(1, tanggal);
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

    public List<Absensi> getBySiswa(int idSiswa, String dari, String sampai) {
        List<Absensi> list = new ArrayList<>();
        String sql = SELECT_ABSENSI + "WHERE a.id_siswa = ? AND a.tanggal BETWEEN ? AND ? ORDER BY a.tanggal";
        try (PreparedStatement ps = koneksi.prepareStatement(sql)) {
            ps.setInt(1, idSiswa);
            ps.setString(2, dari);
            ps.setString(3, sampai);
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

    public Absensi getById(int idAbsensi) {
        Absensi hasil = null;
        String sql = SELECT_ABSENSI + "WHERE a.id_absensi = ?";
        try (PreparedStatement ps = koneksi.prepareStatement(sql)) {
            ps.setInt(1, idAbsensi);
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

    private Absensi map(ResultSet rs) throws SQLException {
        Absensi a = new Absensi();
        a.setIdAbsensi(rs.getInt("id_absensi"));
        a.setIdSiswa(rs.getInt("id_siswa"));
        a.setTanggal(rs.getString("tanggal"));
        a.setStatus(rs.getString("status"));
        a.setKeterangan(rs.getString("keterangan"));
        a.setNamaSiswa(rs.getString("nama_siswa"));
        a.setKelas(rs.getString("nama_kelas"));
        return a;
    }
}