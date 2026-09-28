package dao;

import config.Koneksi;
import model.Siswa;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class SiswaDAO {

    private Connection koneksi;

    public SiswaDAO() {
        koneksi = Koneksi.getConnection();
    }

    public void simpan(Siswa siswa) {
        String sql = "INSERT INTO siswa (nis, nama_siswa, jenis_kelamin, tanggal_lahir, alamat, no_hp, id_kelas) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = koneksi.prepareStatement(sql)) {
            ps.setString(1, siswa.getNis());
            ps.setString(2, siswa.getNamaSiswa());
            ps.setString(3, siswa.getJenisKelamin());
            ps.setString(4, siswa.getTanggalLahir()); // Menggunakan String, nanti di-parse jika perlu Date
            ps.setString(5, siswa.getAlamat());
            ps.setString(6, siswa.getNoHp());
            ps.setInt(7, siswa.getIdKelas());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void update(Siswa siswa) {
        String sql = "UPDATE siswa SET nis=?, nama_siswa=?, jenis_kelamin=?, tanggal_lahir=?, alamat=?, no_hp=?, id_kelas=? WHERE id_siswa=?";
        try (PreparedStatement ps = koneksi.prepareStatement(sql)) {
            ps.setString(1, siswa.getNis());
            ps.setString(2, siswa.getNamaSiswa());
            ps.setString(3, siswa.getJenisKelamin());
            ps.setString(4, siswa.getTanggalLahir());
            ps.setString(5, siswa.getAlamat());
            ps.setString(6, siswa.getNoHp());
            ps.setInt(7, siswa.getIdKelas());
            ps.setInt(8, siswa.getIdSiswa());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void hapus(int idSiswa) {
        String sql = "DELETE FROM siswa WHERE id_siswa=?";
        try (PreparedStatement ps = koneksi.prepareStatement(sql)) {
            ps.setInt(1, idSiswa);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Siswa> getAll() {
        List<Siswa> listSiswa = new ArrayList<>();
        String sql = "SELECT s.*, k.nama_kelas FROM siswa s LEFT JOIN kelas k ON s.id_kelas = k.id_kelas";
        try (PreparedStatement ps = koneksi.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Siswa siswa = new Siswa();
                siswa.setIdSiswa(rs.getInt("id_siswa"));
                siswa.setNis(rs.getString("nis"));
                siswa.setNamaSiswa(rs.getString("nama_siswa"));
                siswa.setJenisKelamin(rs.getString("jenis_kelamin"));
                siswa.setTanggalLahir(rs.getString("tanggal_lahir"));
                siswa.setAlamat(rs.getString("alamat"));
                siswa.setNoHp(rs.getString("no_hp"));
                siswa.setIdKelas(rs.getInt("id_kelas"));
                siswa.setNamaKelas(rs.getString("nama_kelas")); // Set nama kelas dari join
                listSiswa.add(siswa);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listSiswa;
    }

    public Siswa getById(int idSiswa) {
        Siswa siswa = null;
        String sql = "SELECT s.*, k.nama_kelas FROM siswa s LEFT JOIN kelas k ON s.id_kelas = k.id_kelas WHERE s.id_siswa=?";
        try (PreparedStatement ps = koneksi.prepareStatement(sql)) {
            ps.setInt(1, idSiswa);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    siswa = new Siswa();
                    siswa.setIdSiswa(rs.getInt("id_siswa"));
                    siswa.setNis(rs.getString("nis"));
                    siswa.setNamaSiswa(rs.getString("nama_siswa"));
                    siswa.setJenisKelamin(rs.getString("jenis_kelamin"));
                    siswa.setTanggalLahir(rs.getString("tanggal_lahir"));
                    siswa.setAlamat(rs.getString("alamat"));
                    siswa.setNoHp(rs.getString("no_hp"));
                    siswa.setIdKelas(rs.getInt("id_kelas"));
                    siswa.setNamaKelas(rs.getString("nama_kelas"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return siswa;
    }
}
