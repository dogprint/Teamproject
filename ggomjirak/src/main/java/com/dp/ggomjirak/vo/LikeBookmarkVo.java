package com.dp.ggomjirak.vo;

import java.sql.Timestamp;

public class LikeBookmarkVo {
	private String user_id;
	private int hobby_no;
	private Timestamp bm_savetime;
	
	private String hobby_title;
	private String main_img;
	private String user_img;
	private String user_nick;
	
	public LikeBookmarkVo() {
		super();
		// TODO Auto-generated constructor stub
	}

	public LikeBookmarkVo(String user_id, int hobby_no, Timestamp bm_savetime, String hobby_title, String main_img,
			String user_img, String user_nick) {
		super();
		this.user_id = user_id;
		this.hobby_no = hobby_no;
		this.bm_savetime = bm_savetime;
		this.hobby_title = hobby_title;
		this.main_img = main_img;
		this.user_img = user_img;
		this.user_nick = user_nick;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public int getHobby_no() {
		return hobby_no;
	}

	public void setHobby_no(int hobby_no) {
		this.hobby_no = hobby_no;
	}

	public Timestamp getBm_savetime() {
		return bm_savetime;
	}

	public void setBm_savetime(Timestamp bm_savetime) {
		this.bm_savetime = bm_savetime;
	}

	public String getHobby_title() {
		return hobby_title;
	}

	public void setHobby_title(String hobby_title) {
		this.hobby_title = hobby_title;
	}

	public String getMain_img() {
		return main_img;
	}

	public void setMain_img(String main_img) {
		this.main_img = main_img;
	}

	public String getUser_img() {
		return user_img;
	}

	public void setUser_img(String user_img) {
		this.user_img = user_img;
	}

	public String getUser_nick() {
		return user_nick;
	}

	public void setUser_nick(String user_nick) {
		this.user_nick = user_nick;
	}

	@Override
	public String toString() {
		return "LikeBookmarkVo [user_id=" + user_id + ", hobby_no=" + hobby_no + ", bm_savetime=" + bm_savetime
				+ ", hobby_title=" + hobby_title + ", main_img=" + main_img + ", user_img=" + user_img + ", user_nick="
				+ user_nick + "]";
	}
	
}
