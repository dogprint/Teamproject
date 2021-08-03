package com.dp.ggomjirak.vo;

public class CateVo {
	private int cate_no;
	private String cate_name;
	private int parent_cate_no;
	private int cate_level;
	
	
	public CateVo() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
	public CateVo(String cate_name, int parent_cate_no, int cate_level) {
		super();
		this.cate_name = cate_name;
		this.parent_cate_no = parent_cate_no;
		this.cate_level = cate_level;
	}
	
	public int getCate_no() {
		return cate_no;
	}
	public void setCate_no(int cate_no) {
		this.cate_no = cate_no;
	}
	public String getCate_name() {
		return cate_name;
	}
	public void setCate_name(String cate_name) {
		this.cate_name = cate_name;
	}
	public int getParent_cate_no() {
		return parent_cate_no;
	}
	public void setParent_cate_no(int parent_cate_no) {
		this.parent_cate_no = parent_cate_no;
	}
	public int getCate_level() {
		return cate_level;
	}
	public void setCate_level(int cate_level) {
		this.cate_level = cate_level;
	}
	@Override
	public String toString() {
		return "CateVo [cate_no=" + cate_no + ", cate_name=" + cate_name + ", parent_cate_no=" + parent_cate_no
				+ ", cate_level=" + cate_level + "]";
	}
	
	
}
