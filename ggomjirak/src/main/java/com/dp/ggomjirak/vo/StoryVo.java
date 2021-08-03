package com.dp.ggomjirak.vo;

import java.sql.Timestamp;

public class StoryVo {
	int st_no;
	String user_id;
	String st_content;
	Timestamp st_date;
	String st_img;
	int st_like_count;
	int st_c_count;
	
	public StoryVo() {
		super();
		// TODO Auto-generated constructor stub
	}

	public StoryVo(int st_no, String user_id, String st_content, Timestamp st_date, String st_img, int st_like_count,
			int st_c_count) {
		super();
		this.st_no = st_no;
		this.user_id = user_id;
		this.st_content = st_content;
		this.st_date = st_date;
		this.st_img = st_img;
		this.st_like_count = st_like_count;
		this.st_c_count = st_c_count;
	}

	public int getSt_no() {
		return st_no;
	}

	public void setSt_no(int st_no) {
		this.st_no = st_no;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getSt_content() {
		return st_content;
	}

	public void setSt_content(String st_content) {
		this.st_content = st_content;
	}

	public Timestamp getSt_date() {
		return st_date;
	}

	public void setSt_date(Timestamp st_date) {
		this.st_date = st_date;
	}

	public String getSt_img() {
		return st_img;
	}

	public void setSt_img(String st_img) {
		this.st_img = st_img;
	}

	public int getSt_like_count() {
		return st_like_count;
	}

	public void setSt_like_count(int st_like_count) {
		this.st_like_count = st_like_count;
	}

	public int getSt_c_count() {
		return st_c_count;
	}

	public void setSt_c_count(int st_c_count) {
		this.st_c_count = st_c_count;
	}

	@Override
	public String toString() {
		return "StoryVo [st_no=" + st_no + ", user_id=" + user_id + ", st_content=" + st_content + ", st_date="
				+ st_date + ", st_img=" + st_img + ", st_like_count=" + st_like_count + ", st_c_count=" + st_c_count
				+ "]";
	}
	
}
