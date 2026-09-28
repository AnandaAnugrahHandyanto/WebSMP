package dao;

import config.Koneksi;
import model.Kelas;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class KelasDAO {

    private Connection koneksi;

    public KelasDAO() {
        koneksi = Koneksi.getConnection();
    }

    public void simpan(Kelas kelas) {
        String sql = "INSERT INTO kelas (nama_kelas, id_wali_kelas) VALUES (?, ?)";
        try (PreparedStatement ps = koneksi.prepareStatement(sql)) {
            ps.setString(1, kelas.getNamaKelas());
            // Handle case where idWaliKelas might be 0 or invalid if not selected
            if (kelas.getIdWaliKelas() > 0) {
                ps.setInt(2, kelas.getIdWaliKelas());
            } else {
                ps.setNull(2, java.sql.Types.INTEGER);
            }
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void update(Kelas kelas) {
        String sql = "UPDATE kelas SET nama_kelas=?, id_wali_kelas=? WHERE id_kelas=?";
        try (PreparedStatement ps = koneksi.prepareStatement(sql)) {
            ps.setString(1, kelas.getNamaKelas());
            if (kelas.getIdWaliKelas() > 0) {
                ps.setInt(2, kelas.getIdWaliKelas());
            } else {
                ps.setNull(2, java.sql.Types.INTEGER);
            }
            ps.setInt(3, kelas.getIdKelas());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void hapus(int idKelas) {
        String sql = "DELETE FROM kelas WHERE id_kelas=?";
        try (PreparedStatement ps = koneksi.prepareStatement(sql)) {
            ps.setInt(1, idKelas);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Kelas> getAll() {
        List<Kelas> listKelas = new ArrayList<>();
        // Query includes join to get teacher's name for display
        String sql = "SELECT k.*, g.nama_guru, COUNT(s.id_siswa) AS jumlah_siswa FROM kelas k LEFT JOIN guru g ON k.id_wali_kelas = g.id_guru LEFT JOIN siswa s ON s.id_kelas = k.id_kelas GROUP BY k.id_kelas, k.nama_kelas, g.nama_guru ORDER BY k.nama_kelas";
        try (PreparedStatement ps = koneksi.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Kelas kelas = new Kelas();
                kelas.setIdKelas(rs.getInt("id_kelas"));
                kelas.setNamaKelas(rs.getString("nama_kelas"));
                kelas.setIdWaliKelas(rs.getInt("id_wali_kelas"));
                kelas.setNamaWaliKelas(rs.getString("nama_guru")); // Get teacher name from join
                kelas.setJumlahSiswa(rs.getInt("jumlah_siswa"));
                listKelas.add(kelas);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listKelas;
    }

    public Kelas getById(int idKelas) {
        Kelas kelas = null;
        String sql = "SELECT k.*, g.nama_guru, (SELECT COUNT(*) FROM siswa WHERE id_kelas = k.id_kelas) AS jumlah_siswa FROM kelas k LEFT JOIN guru g ON k.id_wali_kelas = g.id_guru WHERE k.id_kelas=?";
        try (PreparedStatement ps = koneksi.prepareStatement(sql)) {
            ps.setInt(1, idKelas);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    kelas = new Kelas();
                    kelas.setIdKelas(rs.getInt("id_kelas"));
                    kelas.setNamaKelas(rs.getString("nama_kelas"));
                    kelas.setIdWaliKelas(rs.getInt("id_wali_kelas"));
                    kelas.setNamaWaliKelas(rs.getString("nama_guru"));
                    kelas.setJumlahSiswa(rs.getInt("jumlah_siswa"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return kelas;
    }
}
