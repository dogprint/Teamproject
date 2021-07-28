package com.dp.ggomjirak.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class MakeStepVo {
	private int hobby_no;
	private int make_step_num;
	private String make_step_text;
	private String make_step_img;
	private String tip;
	private String note;
	private String link_url;
	private String link_desc;
	
	
	// not db Column
	UrlOGTag urlOgTag;
	
	public MakeStepVo() {
		// TODO Auto-generated constructor stub
	}
	

	public int getHobby_no() {
		return hobby_no;
	}

	public void setHobby_no(int hobby_no) {
		this.hobby_no = hobby_no;
	}

	public int getMake_step_num() {
		return make_step_num;
	}

	public void setMake_step_num(int make_step_num) {
		this.make_step_num = make_step_num;
	}

	public String getMake_step_text() {
		return make_step_text;
	}

	public void setMake_step_text(String make_step_text) {
		this.make_step_text = make_step_text;
	}

	public String getMake_step_img() {
		return make_step_img;
	}

	public void setMake_step_img(String make_step_img) {
		this.make_step_img = make_step_img;
	}
	
	

	public String getTip() {
		return tip;
	}

	public void setTip(String tip) {
		this.tip = tip;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public String getLink_url() {
		return link_url;
	}

	public void setLink_url(String link_url) {
		this.link_url = link_url;
	}

	public String getLink_desc() {
		return link_desc;
	}

	public void setLink_desc(String link_desc) {
		this.link_desc = link_desc;
	}


	public UrlOGTag getUrlOgTag() {
		return urlOgTag;
	}


	public void setUrlOgTag(UrlOGTag urlOgTag) {
		this.urlOgTag = urlOgTag;
	}


	@Override
	public String toString() {
		return "MakeStepVo [hobby_no=" + hobby_no + ", make_step_num=" + make_step_num + ", make_step_text="
				+ make_step_text + ", make_step_img=" + make_step_img + ", tip=" + tip + ", note=" + note
				+ ", link_url=" + link_url + ", link_desc=" + link_desc + ", urlOgTag=" + urlOgTag + "]";
	}











}
