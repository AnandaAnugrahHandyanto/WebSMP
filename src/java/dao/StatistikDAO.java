package dao;

import config.Koneksi;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class StatistikDAO {

    private Connection koneksi;

    public StatistikDAO() {
        koneksi = Koneksi.getConnection();
    }

    public int totalSiswa() {
        return hitung("SELECT COUNT(*) FROM siswa");
    }

    public int totalGuru() {
        return hitung("SELECT COUNT(*) FROM guru");
    }

    public int totalKelas() {
        return hitung("SELECT COUNT(*) FROM kelas");
    }

    public int totalMapel() {
        return hitung("SELECT COUNT(*) FROM mapel");
    }

    public int hitung(String sql) {
        int hasil = 0;
        try (PreparedStatement ps = koneksi.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                hasil = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return hasil;
    }

    public Map<String, Integer> siswaPerKelas() {
        Map<String, Integer> data = new LinkedHashMap<>();
        String sql = "SELECT k.nama_kelas, COUNT(s.id_siswa) AS total FROM kelas k LEFT JOIN siswa s ON s.id_kelas = k.id_kelas GROUP BY k.id_kelas, k.nama_kelas ORDER BY k.nama_kelas";
        try (PreparedStatement ps = koneksi.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                data.put(rs.getString("nama_kelas"), rs.getInt("total"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return data;
    }

    public Map<String, Double> rataRataNilaiPerMapel() {
        Map<String, Double> data = new LinkedHashMap<>();
        String sql = "SELECT m.nama_mapel, ROUND(AVG(n.nilai_akhir), 2) AS rata FROM nilai n JOIN mapel m ON n.id_mapel = m.id_mapel GROUP BY m.id_mapel, m.nama_mapel ORDER BY m.nama_mapel";
        try (PreparedStatement ps = koneksi.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                data.put(rs.getString("nama_mapel"), rs.getDouble("rata"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return data;
    }

    public List<String[]> siswaTerbaru(int limit) {
        List<String[]> hasil = new ArrayList<>();
        String sql = "SELECT s.nis, s.nama_siswa, k.nama_kelas FROM siswa s LEFT JOIN kelas k ON s.id_kelas = k.id_kelas ORDER BY s.id_siswa DESC LIMIT ?";
        try (PreparedStatement ps = koneksi.prepareStatement(sql)) {
            ps.setInt(1, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    hasil.add(new String[]{
                        rs.getString("nis"),
                        rs.getString("nama_siswa"),
                        rs.getString("nama_kelas")
                    });
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return hasil;
    }
}