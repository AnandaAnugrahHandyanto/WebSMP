/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author anandaanugrah
 */
public class Siswa {
    private int idSiswa;
    private String nis;
    private String nama;
    private String kelas;
    private String alamat;

    public Siswa() {}

    public Siswa(int idSiswa, String nis, String nama, String kelas, String alamat) {
        this.idSiswa = idSiswa;
        this.nis = nis;
        this.nama = nama;
        this.kelas = kelas;
        this.alamat = alamat;
    }

    public int getIdSiswa() { return idSiswa; }
    public void setIdSiswa(int idSiswa) { this.idSiswa = idSiswa; }

    public String getNis() { return nis; }
    public void setNis(String nis) { this.nis = nis; }

    public String getNama() { return nama; }
    public void setNama(String nama) { this.nama = nama; }

    public String getKelas() { return kelas; }
    public void setKelas(String kelas) { this.kelas = kelas; }

    public String getAlamat() { return alamat; }
    public void setAlamat(String alamat) { this.alamat = alamat; }
}