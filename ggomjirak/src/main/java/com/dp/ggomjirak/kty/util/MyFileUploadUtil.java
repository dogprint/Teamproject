package com.dp.ggomjirak.kty.util;

import java.awt.image.BufferedImage;
import java.io.File;
import java.util.Calendar;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.imgscalr.Scalr;
import org.springframework.util.FileCopyUtils;

public class MyFileUploadUtil {

	public static String serverFilePath = "//192.168.0.217/ggomjirak/";
	public static String serverUploadPath_Profile = "profile";
	
	public static String uploadFile(String uploadPath, String originalFilename, byte[] fileData) throws Exception {
		// uuid_noname01.png
		String datePath = calcPath(uploadPath);
		//System.out.println("datePath:" + datePath);
		
		UUID uuid = UUID.randomUUID(); // 중복되지 않는 고유한 값
		// D:/upload/2021/6/30/uuid_noname.png
		//String filePath = datePath + "/" + uuid + "_" + originalFilename;
		String filePath = serverFilePath + datePath + "/" + uuid + "_" + originalFilename;
		System.out.println("fullfilePath:" + filePath);
		File target = new File(filePath);
		FileCopyUtils.copy(fileData, target);

		boolean isImage = isImage(filePath);
		if (isImage) {
			// 썸네일 이미지
			filePath = makeThumbnail(filePath);
		}
		
		filePath = datePath + "/" + uuid + "_" + originalFilename;
		return filePath;
	}

	private static String calcPath(String uploadPath) {
		Calendar cal = Calendar.getInstance();
		int year = cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH) + 1;
		int date = cal.get(Calendar.DATE);

		String dateString = year + "/" + month + "/" + date; // 2021/6/30
		String datePath = uploadPath + "/" + dateString;
		// -> D:/upload/2021/6/30
		System.out.println("datePath:" + datePath);

		File f = new File(datePath);
		if (!f.exists()) {
			f.mkdirs();
		}

		return datePath;
	}

	// 파일의 확장명 얻기
	private static String getExtName(String fileName) {
		// noname01.png
		int docIndex = fileName.lastIndexOf(".");
		String ext = fileName.substring(docIndex + 1);
		return ext.toUpperCase();
	}

	// 이미지 파일인지 여부
	public static boolean isImage(String fileName) {
		String ext = getExtName(fileName);
		if (ext.equals("JPG") || ext.equals("GIF") || ext.equals("PNG")) {
			return true;
		}
		return false;
	}

	// 썸네일 이미지 만들기
	public static String makeThumbnail(String filePath) {
		// D:/upload/2021/6/30/uuid_noname.png
		// D:/upload/2021/6/30/sm_uuid_noname.png
		int slashIndex = filePath.lastIndexOf("/");
		String front = filePath.substring(0, slashIndex + 1);
		// -> D:/upload/2021/6/30/
		String rear = filePath.substring(slashIndex + 1);
		// -> uuid_noname.png
		String thumbnailPath = front + "sm_" + rear;
		// D:/upload/2021/6/30/sm_uuid_noname.png

		File orgFile = new File(filePath);
		File thumbFile = new File(thumbnailPath);

		try {
			// 이미 업로드 된 원본 파일을 메모리에 로딩
			BufferedImage srcImage = ImageIO.read(orgFile);
			BufferedImage destImage = Scalr.resize(srcImage, // 원본 이미지
					Scalr.Method.AUTOMATIC, // 비율 맞추기
					Scalr.Mode.FIT_TO_HEIGHT, // 높이에 맞추기
					100); // 해당 높이
			ImageIO.write(destImage, getExtName(thumbnailPath), thumbFile);
			// -> 썸네일 이미지를 해당파일의 확장자 형식을 썸네일 파일로 저장
		} catch (Exception e) {
			e.printStackTrace();
		}

		return thumbnailPath;

	}

	// 첨부파일 삭제가 바로 안되는 걸로 보여서 추가한 부분
	private static void deleteWhile(File f) {
		while (true) {
			if (f.exists()) {
				boolean b = f.delete();
				System.out.println("deleteWhile(File f): " + f + " f.delete(): " + b);
				if (b)
					break;
				try {
					// Thread.sleep(2000); // 수정해봄...
					Thread.sleep(1000);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			}
		}
	}

	// 첨부파일 삭제
	public static void deleteFile(String fileName) throws Exception {
		System.out.println("첨부파일 삭제 들어옴... fileName: " + fileName);
		//File f = new File(fileName);
		File f = new File(serverFilePath + fileName);
		deleteWhile(f);

//		// 첨부파일이 이미지이면 썸네일 이미지도 만들었기 때문에 추가로 삭제하는 부분
//		if (isImage(fileName)) {
//			String[] names = fileName.split("sm_");
//			String orgFile = names[0] + names[1];
//			System.out.println("orgFile: " + orgFile);
//			File f2 = new File(orgFile);
//			deleteWhile(f2);
//		}
		
		// 첨부파일이 이미지이면 썸네일 이미지도 만들었기 때문에 추가로 삭제하는 부분
		if (isImage(serverFilePath + fileName)) {
			String[] names = fileName.split("sm_");
			String orgFile = names[0] + names[1];
			System.out.println("orgFile: " + orgFile);
			File f2 = new File(serverFilePath + orgFile);
			deleteWhile(f2);
		}
	}
}
