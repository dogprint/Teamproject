package com.dp.ggomjirak.vo;

import java.sql.Timestamp;

public class MadeByMeVo {
	private int mbm_no;
	private String user_id;
	private int hobby_no;
	private int level_no;
	private String mbm_content;
	private String mbm_img;
	private int like_cnt;
	private int view_cnt;
	private Timestamp reg_date;
	private Timestamp mod_date;
	
	private String hobby_title;
	private String hobby_intro;
	private String main_img;
	
	public MadeByMeVo() {
		super();
		// TODO Auto-generated constructor stub
	}

	public MadeByMeVo(int mbm_no, String user_id, int hobby_no, int level_no, String mbm_content, String mbm_img,
			int like_cnt, int view_cnt, Timestamp reg_date, Timestamp mod_date, String hobby_title, String hobby_intro,
			String main_img) {
		super();
		this.mbm_no = mbm_no;
		this.user_id = user_id;
		this.hobby_no = hobby_no;
		this.level_no = level_no;
		this.mbm_content = mbm_content;
		this.mbm_img = mbm_img;
		this.like_cnt = like_cnt;
		this.view_cnt = view_cnt;
		this.reg_date = reg_date;
		this.mod_date = mod_date;
		this.hobby_title = hobby_title;
		this.hobby_intro = hobby_intro;
		this.main_img = main_img;
	}

	public int getMbm_no() {
		return mbm_no;
	}

	public void setMbm_no(int mbm_no) {
		this.mbm_no = mbm_no;
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

	public int getLevel_no() {
		return level_no;
	}

	public void setLevel_no(int level_no) {
		this.level_no = level_no;
	}

	public String getMbm_content() {
		return mbm_content;
	}

	public void setMbm_content(String mbm_content) {
		this.mbm_content = mbm_content;
	}

	public String getMbm_img() {
		return mbm_img;
	}

	public void setMbm_img(String mbm_img) {
		this.mbm_img = mbm_img;
	}

	public int getLike_cnt() {
		return like_cnt;
	}

	public void setLike_cnt(int like_cnt) {
		this.like_cnt = like_cnt;
	}

	public int getView_cnt() {
		return view_cnt;
	}

	public void setView_cnt(int view_cnt) {
		this.view_cnt = view_cnt;
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

	public String getHobby_title() {
		return hobby_title;
	}

	public void setHobby_title(String hobby_title) {
		this.hobby_title = hobby_title;
	}

	public String getHobby_intro() {
		return hobby_intro;
	}

	public void setHobby_intro(String hobby_intro) {
		this.hobby_intro = hobby_intro;
	}

	public String getMain_img() {
		return main_img;
	}

	public void setMain_img(String main_img) {
		this.main_img = main_img;
	}

	@Override
	public String toString() {
		return "MadeByMeVo [mbm_no=" + mbm_no + ", user_id=" + user_id + ", hobby_no=" + hobby_no + ", level_no="
				+ level_no + ", mbm_content=" + mbm_content + ", mbm_img=" + mbm_img + ", like_cnt=" + like_cnt
				+ ", view_cnt=" + view_cnt + ", reg_date=" + reg_date + ", mod_date=" + mod_date + ", hobby_title="
				+ hobby_title + ", hobby_intro=" + hobby_intro + ", main_img=" + main_img + "]";
	}
	
}
