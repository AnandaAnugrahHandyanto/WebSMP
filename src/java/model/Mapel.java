package model;

public class Mapel {
    private int idMapel;
    private String kodeMapel;
    private String namaMapel;
    private int idGuruPengampu;
    private int kkm;
    private String namaGuruPengampu;

    public Mapel() {
    }

    public Mapel(int idMapel, String kodeMapel, String namaMapel, int idGuruPengampu, int kkm, String namaGuruPengampu) {
        this.idMapel = idMapel;
        this.kodeMapel = kodeMapel;
        this.namaMapel = namaMapel;
        this.idGuruPengampu = idGuruPengampu;
        this.kkm = kkm;
        this.namaGuruPengampu = namaGuruPengampu;
    }

    public int getIdMapel() {
        return idMapel;
    }

    public void setIdMapel(int idMapel) {
        this.idMapel = idMapel;
    }

    public String getKodeMapel() {
        return kodeMapel;
    }

    public void setKodeMapel(String kodeMapel) {
        this.kodeMapel = kodeMapel;
    }

    public String getNamaMapel() {
        return namaMapel;
    }

    public void setNamaMapel(String namaMapel) {
        this.namaMapel = namaMapel;
    }

    public int getIdGuruPengampu() {
        return idGuruPengampu;
    }

    public void setIdGuruPengampu(int idGuruPengampu) {
        this.idGuruPengampu = idGuruPengampu;
    }

    public int getKkm() {
        return kkm;
    }

    public void setKkm(int kkm) {
        this.kkm = kkm;
    }

    public String getNamaGuruPengampu() {
        return namaGuruPengampu;
    }

    public void setNamaGuruPengampu(String namaGuruPengampu) {
        this.namaGuruPengampu = namaGuruPengampu;
    }
}