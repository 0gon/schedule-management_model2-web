package model;

import java.util.ArrayList;
import java.util.List;

public class WeekVO {
	private int work;
	private int humu;
	private int huga;
	private int education;
	private int chul;
	private ArrayList members;
	
	
	public ArrayList getMembers() {
		return members;
	}
	public void setMembers(ArrayList members) {
		this.members = members;
	}
	public int getWork() {
		return work;
	}
	public void setWork(int work) {
		this.work = work;
	}
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
		return "WeekVO [work=" + work + ", humu=" + humu + ", huga=" + huga + ", education=" + education + ", chul="
				+ chul + ", members=" + members + "]";
	}
	
	
	
}
