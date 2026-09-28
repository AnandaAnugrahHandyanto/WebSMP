/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import config.Koneksi;
import model.Siswa;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author anandaanugrah
 */
public class SiswaDAO {

    public void simpan(Siswa siswa) {
        String sql = "INSERT INTO siswa (nis, nama, kelas, alamat) VALUES (?, ?, ?, ?)";
        try (Connection conn = Koneksi.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, siswa.getNis());
            ps.setString(2, siswa.getNama());
            ps.setString(3, siswa.getKelas());
            ps.setString(4, siswa.getAlamat());
            ps.executeUpdate();
            System.out.println("Data siswa berhasil disimpan!");
        } catch (SQLException e) {
            System.out.println("Gagal simpan siswa: " + e.getMessage());
        }
    }

    public List<Siswa> getAll() {
        List<Siswa> listSiswa = new ArrayList<>();
        String sql = "SELECT * FROM siswa";
        try (Connection conn = Koneksi.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                Siswa s = new Siswa();
                s.setIdSiswa(rs.getInt("id_siswa"));
                s.setNis(rs.getString("nis"));
                s.setNama(rs.getString("nama"));
                s.setKelas(rs.getString("kelas"));
                s.setAlamat(rs.getString("alamat"));
                listSiswa.add(s);
            }
        } catch (SQLException e) {
            System.out.println("Gagal ambil data siswa: " + e.getMessage());
        }
        return listSiswa;
    }

    public void update(Siswa siswa) {
        String sql = "UPDATE siswa SET nis=?, nama=?, kelas=?, alamat=? WHERE id_siswa=?";
        try (Connection conn = Koneksi.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, siswa.getNis());
            ps.setString(2, siswa.getNama());
            ps.setString(3, siswa.getKelas());
            ps.setString(4, siswa.getAlamat());
            ps.setInt(5, siswa.getIdSiswa());
            ps.executeUpdate();
            System.out.println("Data siswa berhasil diupdate!");
        } catch (SQLException e) {
            System.out.println("Gagal update siswa: " + e.getMessage());
        }
    }

    public void hapus(int idSiswa) {
        String sql = "DELETE FROM siswa WHERE id_siswa=?";
        try (Connection conn = Koneksi.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idSiswa);
            ps.executeUpdate();
            System.out.println("Data siswa berhasil dihapus!");
        } catch (SQLException e) {
            System.out.println("Gagal hapus siswa: " + e.getMessage());
        }
    }
    
    public static void main(String[] args) {
        SiswaDAO dao = new SiswaDAO();
        
        Siswa s = new Siswa();
        s.setNis("2024001");
        s.setNama("Budi Santoso");
        s.setKelas("VII A");
        s.setAlamat("Jl. Merdeka No. 10");
        dao.simpan(s);
        
        List<Siswa> list = dao.getAll();
        System.out.println("\n=== DAFTAR SISWA ===");
        for (Siswa siswa : list) {
            System.out.println(siswa.getIdSiswa() + " | " + siswa.getNis() + " | " + 
                               siswa.getNama() + " | " + siswa.getKelas() + " | " + siswa.getAlamat());
        }
    }
}