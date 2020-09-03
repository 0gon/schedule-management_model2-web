package model;


public class WeekVO {
	private int humu;
	private int huga;
	private int education;
	private int chul;
	public int getHumu() {
		return humu;
	}
	public void setHumu(int humu) {
		this.humu = humu;
	}
	public int getHuga() {
		return huga;
	}
	public void setHuga(int huga) {
		this.huga = huga;
	}
	public int getEducation() {
		return education;
	}
	public void setEducation(int education) {
		this.education = education;
	}
	public int getChul() {
		return chul;
	}
	public void setChul(int chul) {
		this.chul = chul;
	}
	@Override
	public String toString() {
		return "WeekVO [humu=" + humu + ", huga=" + huga + ", education=" + education + ", chul=" + chul + "]";
	}
	
	
	
	
}
