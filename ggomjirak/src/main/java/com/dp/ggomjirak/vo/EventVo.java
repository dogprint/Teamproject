package com.dp.ggomjirak.vo;

import java.sql.Date;
import java.sql.Timestamp;

public class EventVo {
	private int e_no;
	private int m_no;
	private String e_title;
	private String e_content;
	private String e_img;
	private Timestamp reg_date;
	private Timestamp mod_date;
	private String is_del;
	private Timestamp del_date;
	private Date start_date;
	private Date end_date;
	
	private String user_id;
	
	private int rnum;
	
	private int banner;
	
	
	public EventVo() {
		super();
	}


	public EventVo(int e_no, int m_no, String e_title, String e_content, String e_img, Timestamp reg_date,
			Timestamp mod_date, String is_del, Timestamp del_date, Date start_date, Date end_date, String user_id,
			int rnum, int banner) {
		super();
		this.e_no = e_no;
		this.m_no = m_no;
		this.e_title = e_title;
		this.e_content = e_content;
		this.e_img = e_img;
		this.reg_date = reg_date;
		this.mod_date = mod_date;
		this.is_del = is_del;
		this.del_date = del_date;
		this.start_date = start_date;
		this.end_date = end_date;
		this.user_id = user_id;
		this.rnum = rnum;
		this.banner = banner;
	}


	public int getE_no() {
		return e_no;
	}


	public void setE_no(int e_no) {
		this.e_no = e_no;
	}


	public int getM_no() {
		return m_no;
	}


	public void setM_no(int m_no) {
		this.m_no = m_no;
	}


	public String getE_title() {
		return e_title;
	}


	public void setE_title(String e_title) {
		this.e_title = e_title;
	}


	public String getE_content() {
		return e_content;
	}


	public void setE_content(String e_content) {
		this.e_content = e_content;
	}


	public String getE_img() {
		return e_img;
	}


	public void setE_img(String e_img) {
		this.e_img = e_img;
	}


	public Timestamp getReg_date() {
		return reg_date;
	}


	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}


	public Timestamp getMod_date() {
		return mod_date;
	}


	public void setMod_date(Timestamp mod_date) {
		this.mod_date = mod_date;
	}


	public String getIs_del() {
		return is_del;
	}


	public void setIs_del(String is_del) {
		this.is_del = is_del;
	}


	public Timestamp getDel_date() {
		return del_date;
	}


	public void setDel_date(Timestamp del_date) {
		this.del_date = del_date;
	}


	public Date getStart_date() {
		return start_date;
	}


	public void setStart_date(Date start_date) {
		this.start_date = start_date;
	}


	public Date getEnd_date() {
		return end_date;
	}


	public void setEnd_date(Date end_date) {
		this.end_date = end_date;
	}


	public String getUser_id() {
		return user_id;
	}


	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	

	public int getRnum() {
		return rnum;
	}


	public void setRnum(int rnum) {
		this.rnum = rnum;
	}


	public int getBanner() {
		return banner;
	}


	public void setBanner(int banner) {
		this.banner = banner;
	}


	@Override
	public String toString() {
		return "EventVo [e_no=" + e_no + ", m_no=" + m_no + ", e_title=" + e_title + ", e_content=" + e_content
				+ ", e_img=" + e_img + ", reg_date=" + reg_date + ", mod_date=" + mod_date + ", is_del=" + is_del
				+ ", del_date=" + del_date + ", start_date=" + start_date + ", end_date=" + end_date + ", user_id="
				+ user_id + ", rnum=" + rnum + ", banner=" + banner + "]";
	}





	
	}

