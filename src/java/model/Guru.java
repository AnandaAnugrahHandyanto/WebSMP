package model;

public class Guru {
    private int idGuru;
    private String nip;
    private String namaGuru;
    private String jenisKelamin;
    private String noHp;

    public Guru() {
    }

    public Guru(int idGuru, String nip, String namaGuru, String jenisKelamin, String noHp) {
        this.idGuru = idGuru;
        this.nip = nip;
        this.namaGuru = namaGuru;
        this.jenisKelamin = jenisKelamin;
        this.noHp = noHp;
    }

    public int getIdGuru() {
        return idGuru;
    }

    public void setIdGuru(int idGuru) {
        this.idGuru = idGuru;
    }

    public String getNip() {
        return nip;
    }

    public void setNip(String nip) {
        this.nip = nip;
    }

    public String getNamaGuru() {
        return namaGuru;
    }

    public void setNamaGuru(String namaGuru) {
        this.namaGuru = namaGuru;
    }

    public String getJenisKelamin() {
        return jenisKelamin;
    }

    public void setJenisKelamin(String jenisKelamin) {
        this.jenisKelamin = jenisKelamin;
    }

    public String getNoHp() {
        return noHp;
    }

    public void setNoHp(String noHp) {
        this.noHp = noHp;
    }
}