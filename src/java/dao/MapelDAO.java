package dao;

import config.Koneksi;
import model.Mapel;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MapelDAO {

    private Connection koneksi;

    public MapelDAO() {
        koneksi = Koneksi.getConnection();
    }

    public void simpan(Mapel mapel) {
        String sql = "INSERT INTO mapel (kode_mapel, nama_mapel, id_guru_pengampu, kkm) VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = koneksi.prepareStatement(sql)) {
            ps.setString(1, mapel.getKodeMapel());
            ps.setString(2, mapel.getNamaMapel());
            if (mapel.getIdGuruPengampu() > 0) {
                ps.setInt(3, mapel.getIdGuruPengampu());
            } else {
                ps.setNull(3, java.sql.Types.INTEGER);
            }
            ps.setInt(4, mapel.getKkm());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void update(Mapel mapel) {
        String sql = "UPDATE mapel SET kode_mapel=?, nama_mapel=?, id_guru_pengampu=?, kkm=? WHERE id_mapel=?";
        try (PreparedStatement ps = koneksi.prepareStatement(sql)) {
            ps.setString(1, mapel.getKodeMapel());
            ps.setString(2, mapel.getNamaMapel());
            if (mapel.getIdGuruPengampu() > 0) {
                ps.setInt(3, mapel.getIdGuruPengampu());
            } else {
                ps.setNull(3, java.sql.Types.INTEGER);
            }
            ps.setInt(4, mapel.getKkm());
            ps.setInt(5, mapel.getIdMapel());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void hapus(int idMapel) {
        String sql = "DELETE FROM mapel WHERE id_mapel=?";
        try (PreparedStatement ps = koneksi.prepareStatement(sql)) {
            ps.setInt(1, idMapel);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Mapel> getAll() {
        List<Mapel> listMapel = new ArrayList<>();
        String sql = "SELECT m.*, g.nama_guru FROM mapel m LEFT JOIN guru g ON m.id_guru_pengampu = g.id_guru";
        try (PreparedStatement ps = koneksi.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Mapel mapel = new Mapel();
                mapel.setIdMapel(rs.getInt("id_mapel"));
                mapel.setKodeMapel(rs.getString("kode_mapel"));
                mapel.setNamaMapel(rs.getString("nama_mapel"));
                mapel.setIdGuruPengampu(rs.getInt("id_guru_pengampu"));
                mapel.setKkm(rs.getInt("kkm"));
                mapel.setNamaGuruPengampu(rs.getString("nama_guru"));
                listMapel.add(mapel);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listMapel;
    }

    public Mapel getById(int idMapel) {
        Mapel mapel = null;
        String sql = "SELECT m.*, g.nama_guru FROM mapel m LEFT JOIN guru g ON m.id_guru_pengampu = g.id_guru WHERE m.id_mapel=?";
        try (PreparedStatement ps = koneksi.prepareStatement(sql)) {
            ps.setInt(1, idMapel);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    mapel = new Mapel();
                    mapel.setIdMapel(rs.getInt("id_mapel"));
                    mapel.setKodeMapel(rs.getString("kode_mapel"));
                    mapel.setNamaMapel(rs.getString("nama_mapel"));
                    mapel.setIdGuruPengampu(rs.getInt("id_guru_pengampu"));
                    mapel.setKkm(rs.getInt("kkm"));
                    mapel.setNamaGuruPengampu(rs.getString("nama_guru"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return mapel;
    }
}