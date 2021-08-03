package com.dp.ggomjirak.vo;

import java.sql.Timestamp;
import java.util.Arrays;

public class MemberVo {

	// 회원 정보 기본 정보 테이블	
	private String user_id;
	private String user_pw;
	private String user_name;
	private String user_email;
	private String user_tel;
	private Timestamp reg_date;
	private String is_del;
	private Timestamp del_date;
	
	// 회원 상세 정보 테이블
	private String user_nick;
	private int cate_no1;
	private int cate_no2;
	private int cate_no3;
	private String cate_etc;
	private int follower_cnt;
	private int following_cnt;
	private String user_img; // 회원 프로필 이미지
	private int user_grade; // 회원 등급
	
	// 회원 등급
	private int cd;
	private String name;
	
	// 회원 알림 설정
	private String onOff;
	// private Timestamp savetime; // 이름 변경함
	private Timestamp setup_save_time;	
	
	// 회원이 관심취미(1,2,3)로 저장한 취미 카테고리 컬럼 내용  받아오는 부분 
	private String cate_name1;
	private String cate_name2;
	private String cate_name3;
	
	// 메시지 보내기 내용
	private int notReadCount;

	// 번호 매기기
	private int rnum;
	
	public int getNotReadCount() {
		return notReadCount;
	}
	
	public void setNotReadCount(int notReadCount) {
		this.notReadCount = notReadCount;
	}

	//첨부파일
	private String[] files;
	
	public String[] getFiles() {
		return files;
	}

	public void setFiles(String[] files) {
		this.files = files;
	}
	//

	public MemberVo() {
		super();
		// TODO Auto-generated constructor stub
	}

	public MemberVo(String user_id, String user_pw, String user_name, String user_email, String user_tel,
			Timestamp reg_date, String is_del, Timestamp del_date, String user_nick, int cate_no1, int cate_no2,
			int cate_no3, String cate_etc, int follower_cnt, int following_cnt, String user_img, int user_grade, int cd,
			String name, String onOff, Timestamp setup_save_time, String cate_name1, String cate_name2,
			String cate_name3, int notReadCount, int rnum) {
		super();
		this.user_id = user_id;
		this.user_pw = user_pw;
		this.user_name = user_name;
		this.user_email = user_email;
		this.user_tel = user_tel;
		this.reg_date = reg_date;
		this.is_del = is_del;
		this.del_date = del_date;
		this.user_nick = user_nick;
		this.cate_no1 = cate_no1;
		this.cate_no2 = cate_no2;
		this.cate_no3 = cate_no3;
		this.cate_etc = cate_etc;
		this.follower_cnt = follower_cnt;
		this.following_cnt = following_cnt;
		this.user_img = user_img;
		this.user_grade = user_grade;
		this.cd = cd;
		this.name = name;
		this.onOff = onOff;
		this.setup_save_time = setup_save_time;
		this.cate_name1 = cate_name1;
		this.cate_name2 = cate_name2;
		this.cate_name3 = cate_name3;
		this.notReadCount = notReadCount;
		this.rnum = rnum;
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

	public String getUser_tel() {
		return user_tel;
	}

	public void setUser_tel(String user_tel) {
		this.user_tel = user_tel;
	}

	public Timestamp getReg_date() {
		return reg_date;
	}

	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
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

	public String getUser_nick() {
		return user_nick;
	}

	public void setUser_nick(String user_nick) {
		this.user_nick = user_nick;
	}

	public int getCate_no1() {
		return cate_no1;
	}

	public void setCate_no1(int cate_no1) {
		this.cate_no1 = cate_no1;
	}

	public int getCate_no2() {
		return cate_no2;
	}

	public void setCate_no2(int cate_no2) {
		this.cate_no2 = cate_no2;
	}

	public int getCate_no3() {
		return cate_no3;
	}

	public void setCate_no3(int cate_no3) {
		this.cate_no3 = cate_no3;
	}

	public String getCate_etc() {
		return cate_etc;
	}

	public void setCate_etc(String cate_etc) {
		this.cate_etc = cate_etc;
	}

	public int getFollower_cnt() {
		return follower_cnt;
	}

	public void setFollower_cnt(int follower_cnt) {
		this.follower_cnt = follower_cnt;
	}

	public int getFollowing_cnt() {
		return following_cnt;
	}

	public void setFollowing_cnt(int following_cnt) {
		this.following_cnt = following_cnt;
	}

	public String getUser_img() {
		return user_img;
	}

	public void setUser_img(String user_img) {
		this.user_img = user_img;
	}

	public int getUser_grade() {
		return user_grade;
	}

	public void setUser_grade(int user_grade) {
		this.user_grade = user_grade;
	}

	public int getCd() {
		return cd;
	}

	public void setCd(int cd) {
		this.cd = cd;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getOnOff() {
		return onOff;
	}

	public void setOnOff(String onOff) {
		this.onOff = onOff;
	}

	public Timestamp getSetup_save_time() {
		return setup_save_time;
	}

	public void setSetup_save_time(Timestamp setup_save_time) {
		this.setup_save_time = setup_save_time;
	}

	public String getCate_name1() {
		return cate_name1;
	}

	public void setCate_name1(String cate_name1) {
		this.cate_name1 = cate_name1;
	}

	public String getCate_name2() {
		return cate_name2;
	}

	public void setCate_name2(String cate_name2) {
		this.cate_name2 = cate_name2;
	}

	public String getCate_name3() {
		return cate_name3;
	}

	public void setCate_name3(String cate_name3) {
		this.cate_name3 = cate_name3;
	}

	public int getRnum() {
		return rnum;
	}

	public void setRnum(int rnum) {
		this.rnum = rnum;
	}

	@Override
	public String toString() {
		return "MemberVo [user_id=" + user_id + ", user_pw=" + user_pw + ", user_name=" + user_name + ", user_email="
				+ user_email + ", user_tel=" + user_tel + ", reg_date=" + reg_date + ", is_del=" + is_del
				+ ", del_date=" + del_date + ", user_nick=" + user_nick + ", cate_no1=" + cate_no1 + ", cate_no2="
				+ cate_no2 + ", cate_no3=" + cate_no3 + ", cate_etc=" + cate_etc + ", follower_cnt=" + follower_cnt
				+ ", following_cnt=" + following_cnt + ", user_img=" + user_img + ", user_grade=" + user_grade + ", cd="
				+ cd + ", name=" + name + ", onOff=" + onOff + ", setup_save_time=" + setup_save_time + ", cate_name1="
				+ cate_name1 + ", cate_name2=" + cate_name2 + ", cate_name3=" + cate_name3 + ", notReadCount="
				+ notReadCount + ", files=" + Arrays.toString(files) + "]";

	}


	
}
