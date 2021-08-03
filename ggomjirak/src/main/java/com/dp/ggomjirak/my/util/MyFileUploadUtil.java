package com.dp.ggomjirak.my.util;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.UUID;

import javax.annotation.Resource;
import javax.imageio.ImageIO;

import org.imgscalr.Scalr;
import org.springframework.util.FileCopyUtils;

import com.mortennobel.imagescaling.AdvancedResizeOp;
import com.mortennobel.imagescaling.MultiStepRescaleOp;

public class MyFileUploadUtil {
	
	/**
	 * @param uploadPath
	 * @param orgFileName
	 * @param fileData
	 * @return rootPath제외한 파일경로 리턴
	 * @throws Exception
	 */
	public static String uploadImage (String rootPath, String uploadPath, 
				String orgFileName, byte[] fileData) throws Exception {
		
		String datePath = getDatePath();
		// -> 2021/07/31
	
		String dateDirPath = makeDateDir(rootPath, uploadPath, datePath);
		// -> D:/ggomjirak/hobby/main_img/2021/07/31
		
		String uuidFileName = getUUIDFileName(orgFileName); // -> uuid_메인이미지.jpg
		String fullFilePath = dateDirPath + "/" + uuidFileName;
		// -> D:/ggomjirak/hobby/main_img/2021/07/31 + "/" + uuid_메인이미지.jpg
		
		File target = new File(fullFilePath);
		FileCopyUtils.copy(fileData, target); // fileData를 target에 복사
		
		String filePath = uploadPath + "/" + datePath + "/" + uuidFileName;
		// -> hobby/main_img/2021/07/31 + "/" + uuid_메인이미지.jpg
		return filePath;
	}

	private static String makeDateDir(String rootPath, String uploadPath, String datePath) {
		String dateDirPath = rootPath + "/" + uploadPath + "/" + datePath;
		// -> D:/ggomjirak + / +  hobby/main_img + / + 2021/07/31
		
		//날짜별 폴더 생성
		File f = new File(dateDirPath);
		if (!f.exists()) {
			f.mkdirs();
		} 
		return dateDirPath;
	}

	private static String getDatePath() {
		Calendar cal = Calendar.getInstance();
		int year = cal.get(Calendar.YEAR);
		String month = new DecimalFormat("00").format(cal.get(Calendar.MONTH) + 1);
		String date = new DecimalFormat("00").format(cal.get(Calendar.DATE));
		
		String datePath = year + "/" + month + "/" + date; 
		return datePath;
	}

	private static String getUUIDFileName(String orgFileName) {
		UUID uuid = UUID.randomUUID(); 
		String uuidFileName = uuid + "_" + orgFileName;
		return uuidFileName;
	}
	
	// 첨부파일 삭제
	public static boolean deleteFile(String rootPath, String filePath) throws Exception {
		String fullFilePath = rootPath + "/" + filePath;
		System.out.println(fullFilePath);
		File file = new File(fullFilePath);
		if(file.exists()) {
			if (file.delete()) {
				return true;
			}
		}
		return false;
	}
	
}
