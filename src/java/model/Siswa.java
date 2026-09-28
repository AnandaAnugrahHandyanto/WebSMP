package model;

public class Siswa {
    private int idSiswa;
    private String nis;
    private String namaSiswa;
    private String jenisKelamin;
    private String tanggalLahir; // String untuk kemudahan di JSP/Servlet, bisa di-parse ke Date
    private String alamat;
    private String noHp;
    private int idKelas;

    // Field tambahan untuk display, bukan dari tabel siswa
    private String namaKelas;

    public Siswa() {
    }

    public Siswa(int idSiswa, String nis, String namaSiswa, String jenisKelamin, String tanggalLahir, String alamat, String noHp, int idKelas, String namaKelas) {
        this.idSiswa = idSiswa;
        this.nis = nis;
        this.namaSiswa = namaSiswa;
        this.jenisKelamin = jenisKelamin;
        this.tanggalLahir = tanggalLahir;
        this.alamat = alamat;
        this.noHp = noHp;
        this.idKelas = idKelas;
        this.namaKelas = namaKelas;
    }

    // Constructor tanpa idSiswa (untuk CREATE)
    public Siswa(String nis, String namaSiswa, String jenisKelamin, String tanggalLahir, String alamat, String noHp, int idKelas) {
        this.nis = nis;
        this.namaSiswa = namaSiswa;
        this.jenisKelamin = jenisKelamin;
        this.tanggalLahir = tanggalLahir;
        this.alamat = alamat;
        this.noHp = noHp;
        this.idKelas = idKelas;
    }

    // --- Getters and Setters ---
    public int getIdSiswa() {
        return idSiswa;
    }

    public void setIdSiswa(int idSiswa) {
        this.idSiswa = idSiswa;
    }

    public String getNis() {
        return nis;
    }

    public void setNis(String nis) {
        this.nis = nis;
    }

    public String getNamaSiswa() {
        return namaSiswa;
    }

    public void setNamaSiswa(String namaSiswa) {
        this.namaSiswa = namaSiswa;
    }

    public String getJenisKelamin() {
        return jenisKelamin;
    }

    public void setJenisKelamin(String jenisKelamin) {
        this.jenisKelamin = jenisKelamin;
    }

    public String getTanggalLahir() {
        return tanggalLahir;
    }

    public void setTanggalLahir(String tanggalLahir) {
        this.tanggalLahir = tanggalLahir;
    }

    public String getAlamat() {
        return alamat;
    }

    public void setAlamat(String alamat) {
        this.alamat = alamat;
    }

    public String getNoHp() {
        return noHp;
    }

    public void setNoHp(String noHp) {
        this.noHp = noHp;
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
}