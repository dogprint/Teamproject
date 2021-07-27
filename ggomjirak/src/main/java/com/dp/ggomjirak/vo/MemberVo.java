package com.dp.ggomjirak.vo;

import java.sql.Timestamp;

public class MemberVo {
	private String user_id;
	private String user_pw;
	private String user_name;
	private String user_email;
	private Timestamp reg_date;
	private Timestamp update_date;
	
	
	public MemberVo() {
		// TODO Auto-generated constructor stub
	}


	public MemberVo(String user_id, String user_pw, String user_name) {
		super();
		this.user_id = user_id;
		this.user_pw = user_pw;
		this.user_name = user_name;
	}


	public String getUser_id() {
		return user_id;
	}


	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}


	public String getUser_pw() {
		return user_pw;
	}


	public void setUser_pw(String user_pw) {
		this.user_pw = user_pw;
	}


	public String getUser_name() {
		return user_name;
	}


	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}


	public String getUser_email() {
		return user_email;
	}


	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}


	public Timestamp getReg_date() {
		return reg_date;
	}


	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}


	public Timestamp getUpdate_date() {
		return update_date;
	}


	public void setUpdate_date(Timestamp update_date) {
		this.update_date = update_date;
	}


	@Override
	public String toString() {
		return "MemberVo [user_id=" + user_id + ", user_pw=" + user_pw + ", user_name=" + user_name + ", user_email="
				+ user_email + ", reg_date=" + reg_date + ", update_date=" + update_date + "]";
	}
	
	

}
