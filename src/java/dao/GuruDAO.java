package dao;

import config.Koneksi;
import model.Guru;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class GuruDAO {

    private Connection koneksi;

    public GuruDAO() {
        koneksi = Koneksi.getConnection();
    }

    public void simpan(Guru guru) {
        String sql = "INSERT INTO guru (nip, nama_guru, jenis_kelamin, no_hp) VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = koneksi.prepareStatement(sql)) {
            ps.setString(1, guru.getNip());
            ps.setString(2, guru.getNamaGuru());
            ps.setString(3, guru.getJenisKelamin());
            ps.setString(4, guru.getNoHp());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void update(Guru guru) {
        String sql = "UPDATE guru SET nip=?, nama_guru=?, jenis_kelamin=?, no_hp=? WHERE id_guru=?";
        try (PreparedStatement ps = koneksi.prepareStatement(sql)) {
            ps.setString(1, guru.getNip());
            ps.setString(2, guru.getNamaGuru());
            ps.setString(3, guru.getJenisKelamin());
            ps.setString(4, guru.getNoHp());
            ps.setInt(5, guru.getIdGuru());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void hapus(int idGuru) {
        String sql = "DELETE FROM guru WHERE id_guru=?";
        try (PreparedStatement ps = koneksi.prepareStatement(sql)) {
            ps.setInt(1, idGuru);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Guru> getAll() {
        List<Guru> listGuru = new ArrayList<>();
        String sql = "SELECT * FROM guru";
        try (PreparedStatement ps = koneksi.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Guru guru = new Guru();
                guru.setIdGuru(rs.getInt("id_guru"));
                guru.setNip(rs.getString("nip"));
                guru.setNamaGuru(rs.getString("nama_guru"));
                guru.setJenisKelamin(rs.getString("jenis_kelamin"));
                guru.setNoHp(rs.getString("no_hp"));
                listGuru.add(guru);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listGuru;
    }

    public Guru getById(int idGuru) {
        Guru guru = null;
        String sql = "SELECT * FROM guru WHERE id_guru=?";
        try (PreparedStatement ps = koneksi.prepareStatement(sql)) {
            ps.setInt(1, idGuru);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    guru = new Guru();
                    guru.setIdGuru(rs.getInt("id_guru"));
                    guru.setNip(rs.getString("nip"));
                    guru.setNamaGuru(rs.getString("nama_guru"));
                    guru.setJenisKelamin(rs.getString("jenis_kelamin"));
                    guru.setNoHp(rs.getString("no_hp"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return guru;
    }
}
