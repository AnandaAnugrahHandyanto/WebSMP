package dao;

import config.Koneksi;
import model.Nilai;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class NilaiDAO {

    private Connection koneksi;

    public NilaiDAO() {
        koneksi = Koneksi.getConnection();
    }

    private void simpanAtauUpdate(String sql, Nilai n) throws SQLException {
        try (PreparedStatement ps = koneksi.prepareStatement(sql)) {
            ps.setInt(1, n.getIdSiswa());
            ps.setInt(2, n.getIdMapel());
            ps.setInt(3, n.getNilaiTugas());
            ps.setInt(4, n.getNilaiUts());
            ps.setInt(5, n.getNilaiUas());
            ps.setDouble(6, n.getNilaiAkhir());
            ps.setString(7, n.getPredikat());
            ps.executeUpdate();
        }
    }

    public void simpan(Nilai n) {
        String sql = "INSERT INTO nilai (id_siswa, id_mapel, nilai_tugas, nilai_uts, nilai_uas, nilai_akhir, predikat) VALUES (?, ?, ?, ?, ?, ?, ?) ON DUPLICATE KEY UPDATE nilai_tugas=VALUES(nilai_tugas), nilai_uts=VALUES(nilai_uts), nilai_uas=VALUES(nilai_uas), nilai_akhir=VALUES(nilai_akhir), predikat=VALUES(predikat)";
        try {
            simpanAtauUpdate(sql, n);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void update(Nilai n) {
        String sql = "UPDATE nilai SET id_siswa=?, id_mapel=?, nilai_tugas=?, nilai_uts=?, nilai_uas=?, nilai_akhir=?, predikat=? WHERE id_nilai=?";
        try (PreparedStatement ps = koneksi.prepareStatement(sql)) {
            ps.setInt(1, n.getIdSiswa());
            ps.setInt(2, n.getIdMapel());
            ps.setInt(3, n.getNilaiTugas());
            ps.setInt(4, n.getNilaiUts());
            ps.setInt(5, n.getNilaiUas());
            ps.setDouble(6, n.getNilaiAkhir());
            ps.setString(7, n.getPredikat());
            ps.setInt(8, n.getIdNilai());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void hapus(int idNilai) {
        String sql = "DELETE FROM nilai WHERE id_nilai=?";
        try (PreparedStatement ps = koneksi.prepareStatement(sql)) {
            ps.setInt(1, idNilai);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Nilai> getAll() {
        List<Nilai> listNilai = new ArrayList<>();
        String sql = "SELECT n.*, s.nama_siswa, m.nama_mapel, k.nama_kelas FROM nilai n JOIN siswa s ON n.id_siswa = s.id_siswa JOIN mapel m ON n.id_mapel = m.id_mapel LEFT JOIN kelas k ON s.id_kelas = k.id_kelas ORDER BY s.nama_siswa, m.nama_mapel";
        try (PreparedStatement ps = koneksi.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                listNilai.add(map(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listNilai;
    }

    public List<Nilai> getByKelas(int idKelas) {
        List<Nilai> listNilai = new ArrayList<>();
        String sql = "SELECT n.*, s.nama_siswa, m.nama_mapel, k.nama_kelas FROM nilai n JOIN siswa s ON n.id_siswa = s.id_siswa JOIN mapel m ON n.id_mapel = m.id_mapel LEFT JOIN kelas k ON s.id_kelas = k.id_kelas WHERE s.id_kelas = ? ORDER BY s.nama_siswa, m.nama_mapel";
        try (PreparedStatement ps = koneksi.prepareStatement(sql)) {
            ps.setInt(1, idKelas);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    listNilai.add(map(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listNilai;
    }

    public Nilai getById(int idNilai) {
        Nilai hasil = null;
        String sql = "SELECT n.*, s.nama_siswa, m.nama_mapel, k.nama_kelas FROM nilai n JOIN siswa s ON n.id_siswa = s.id_siswa JOIN mapel m ON n.id_mapel = m.id_mapel LEFT JOIN kelas k ON s.id_kelas = k.id_kelas WHERE n.id_nilai=?";
        try (PreparedStatement ps = koneksi.prepareStatement(sql)) {
            ps.setInt(1, idNilai);
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

    public List<Nilai> getBySiswa(int idSiswa) {
        List<Nilai> listNilai = new ArrayList<>();
        String sql = "SELECT n.*, s.nama_siswa, m.nama_mapel, k.nama_kelas FROM nilai n JOIN siswa s ON n.id_siswa = s.id_siswa JOIN mapel m ON n.id_mapel = m.id_mapel LEFT JOIN kelas k ON s.id_kelas = k.id_kelas WHERE n.id_siswa = ? ORDER BY m.nama_mapel";
        try (PreparedStatement ps = koneksi.prepareStatement(sql)) {
            ps.setInt(1, idSiswa);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    listNilai.add(map(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listNilai;
    }

    private Nilai map(ResultSet rs) throws SQLException {
        Nilai n = new Nilai();
        n.setIdNilai(rs.getInt("id_nilai"));
        n.setIdSiswa(rs.getInt("id_siswa"));
        n.setIdMapel(rs.getInt("id_mapel"));
        n.setNilaiTugas(rs.getInt("nilai_tugas"));
        n.setNilaiUts(rs.getInt("nilai_uts"));
        n.setNilaiUas(rs.getInt("nilai_uas"));
        n.setNilaiAkhir(rs.getDouble("nilai_akhir"));
        n.setPredikat(rs.getString("predikat"));
        n.setNamaSiswa(rs.getString("nama_siswa"));
        n.setNamaMapel(rs.getString("nama_mapel"));
        n.setKelas(rs.getString("nama_kelas"));
        return n;
    }
}