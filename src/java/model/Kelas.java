package model;

public class Kelas {
    private int idKelas;
    private String namaKelas;
    private int idWaliKelas; // FK ke guru
    private String namaWaliKelas; // Untuk display, dari JOIN
    private int jumlahSiswa;

    public Kelas() {
    }

    public Kelas(int idKelas, String namaKelas, int idWaliKelas, String namaWaliKelas) {
        this.idKelas = idKelas;
        this.namaKelas = namaKelas;
        this.idWaliKelas = idWaliKelas;
        this.namaWaliKelas = namaWaliKelas;
    }

    public int getIdKelas() {
        return idKelas;
    }

    public void setIdKelas(int idKelas) {
        this.idKelas = idKelas;
    }

    public String getNamaKelas() {
        return namaKelas;
    }

    public void setNamaKelas(String namaKelas) {
        this.namaKelas = namaKelas;
    }

    public int getIdWaliKelas() {
        return idWaliKelas;
    }

    public void setIdWaliKelas(int idWaliKelas) {
        this.idWaliKelas = idWaliKelas;
    }

    public String getNamaWaliKelas() {
        return namaWaliKelas;
    }

    public void setNamaWaliKelas(String namaWaliKelas) {
        this.namaWaliKelas = namaWaliKelas;
    }

    public int getJumlahSiswa() {
        return jumlahSiswa;
    }

    public void setJumlahSiswa(int jumlahSiswa) {
        this.jumlahSiswa = jumlahSiswa;
    }
}