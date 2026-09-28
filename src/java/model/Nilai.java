package model;

public class Nilai {
    private int idNilai;
    private int idSiswa;
    private int idMapel;
    private int nilaiTugas;
    private int nilaiUts;
    private int nilaiUas;
    private double nilaiAkhir;
    private String predikat;
    private String namaSiswa;
    private String namaMapel;
    private String kelas;

    public Nilai() {
    }

    public static double hitungNilaiAkhir(int tugas, int uts, int uas) {
        return tugas * 0.3 + uts * 0.3 + uas * 0.4;
    }

    public static String hitungPredikat(double nilai) {
        if (nilai >= 85) {
            return "A";
        }
        if (nilai >= 75) {
            return "B";
        }
        if (nilai >= 65) {
            return "C";
        }
        return "D";
    }

    public int getIdNilai() {
        return idNilai;
    }

    public void setIdNilai(int idNilai) {
        this.idNilai = idNilai;
    }

    public int getIdSiswa() {
        return idSiswa;
    }

    public void setIdSiswa(int idSiswa) {
        this.idSiswa = idSiswa;
    }

    public int getIdMapel() {
        return idMapel;
    }

    public void setIdMapel(int idMapel) {
        this.idMapel = idMapel;
    }

    public int getNilaiTugas() {
        return nilaiTugas;
    }

    public void setNilaiTugas(int nilaiTugas) {
        this.nilaiTugas = nilaiTugas;
    }

    public int getNilaiUts() {
        return nilaiUts;
    }

    public void setNilaiUts(int nilaiUts) {
        this.nilaiUts = nilaiUts;
    }

    public int getNilaiUas() {
        return nilaiUas;
    }

    public void setNilaiUas(int nilaiUas) {
        this.nilaiUas = nilaiUas;
    }

    public double getNilaiAkhir() {
        return nilaiAkhir;
    }

    public void setNilaiAkhir(double nilaiAkhir) {
        this.nilaiAkhir = nilaiAkhir;
    }

    public String getPredikat() {
        return predikat;
    }

    public void setPredikat(String predikat) {
        this.predikat = predikat;
    }

    public String getNamaSiswa() {
        return namaSiswa;
    }

    public void setNamaSiswa(String namaSiswa) {
        this.namaSiswa = namaSiswa;
    }

    public String getNamaMapel() {
        return namaMapel;
    }

    public void setNamaMapel(String namaMapel) {
        this.namaMapel = namaMapel;
    }

    public String getKelas() {
        return kelas;
    }

    public void setKelas(String kelas) {
        this.kelas = kelas;
    }
}