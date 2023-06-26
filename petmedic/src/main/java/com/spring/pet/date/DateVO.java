package com.spring.pet.date;

public class DateVO {
	private String today;
	private String hos_cate;
	private int firstday;
	private int lastday;
	private int wk;
	
	private int week_1;
	private int week_2;
	private int week_3;
	private int week_4;
	private int week_5;
	
	public String getToday() {
		return today;
	}
	public void setToday(String today) {
		this.today = today;
	}
	public String getHos_cate() {
		return hos_cate;
	}
	public void setHos_cate(String hos_cate) {
		this.hos_cate = hos_cate;
	}
	public int getFirstday() {
		return firstday;
	}
	public void setFirstday(int firstday) {
		this.firstday = firstday;
	}
	public int getLastday() {
		return lastday;
	}
	public void setLastday(int lastday) {
		this.lastday = lastday;
	}
	public int getWk() {
		return wk;
	}
	public void setWk(int wk) {
		this.wk = wk;
	}
	public int getWeek_1() {
		return week_1;
	}
	public void setWeek_1(int week_1) {
		this.week_1 = week_1;
	}
	public int getWeek_2() {
		return week_2;
	}
	public void setWeek_2(int week_2) {
		this.week_2 = week_2;
	}
	public int getWeek_3() {
		return week_3;
	}
	public void setWeek_3(int week_3) {
		this.week_3 = week_3;
	}
	public int getWeek_4() {
		return week_4;
	}
	public void setWeek_4(int week_4) {
		this.week_4 = week_4;
	}
	public int getWeek_5() {
		return week_5;
	}
	public void setWeek_5(int week_5) {
		this.week_5 = week_5;
	}
	@Override
	public String toString() {
		return "DateVO [today=" + today + ", hos_cate=" + hos_cate + ", firstday=" + firstday + ", lastday=" + lastday
				+ ", wk=" + wk + ", week_1=" + week_1 + ", week_2=" + week_2 + ", week_3=" + week_3 + ", week_4="
				+ week_4 + ", week_5=" + week_5 + "]";
	}
}
