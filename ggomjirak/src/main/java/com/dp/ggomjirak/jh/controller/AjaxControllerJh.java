package com.dp.ggomjirak.jh.controller;

import java.io.FileInputStream;
import javax.annotation.Resource;
import javax.inject.Inject;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.dp.ggomjirak.vo.CompleteImgVo;
import com.dp.ggomjirak.vo.MakeStepVo;
import com.dp.ggomjirak.yj.service.HobbyService;
import com.dp.ggomjirak.yj.util.MyFileUploadUtil;

@RequestMapping("eventImg")
@RestController
public class AjaxControllerJh {
	
	@Resource(name="rootPath")
	private String rootPath;
	
	private static final Logger logger = LoggerFactory.getLogger(AjaxControllerJh.class);
	
	private static final String MAIN_IMG_UPLOAD_PATH = "main_img";
	private static final String STEP_IMG_UPLOAD_PATH = "make_step";
	private static final String COMPLETE_IMG_UPLOAD_PATH = "complete_img";
	private static final String EVENT_IMG_UPLOAD_PATH = "event_img";
	
	@Inject
	private HobbyService hobbyService;
	
	//이미지 출력
	@RequestMapping(value="/displayImage", method=RequestMethod.GET)
	public ResponseEntity<byte[]> displayImage(String filePath) throws Exception {
		String fullFilePath = rootPath + "/" + filePath;
		FileInputStream fis = new FileInputStream(fullFilePath);
		logger.info("이미지출력시작", fullFilePath);
		HttpHeaders header = new HttpHeaders();
        header.setContentType(MediaType.IMAGE_JPEG);
        ResponseEntity<byte[]> entity = new ResponseEntity<byte[]>(
        		 IOUtils.toByteArray(fis), 
        		 header,
        		 HttpStatus.CREATED);
        fis.close();
		return entity;
	}
	
	//이미지 파일 업로드
	// filePath <- 루트경로 제외한 서버에 저장된 파일경로 리턴 
	@RequestMapping(value="/uploadImage", method=RequestMethod.POST, produces="application/text;charset=utf-8")
	public String uploadImg(MultipartFile file, String sort) throws Exception {
		System.out.println("file:" + file);
		System.out.println("sort:" + sort);
		String orgFileName = file.getOriginalFilename();
		System.out.println("orgFileName:" + orgFileName);
		String filePath = null;
		switch (sort) {
		case "mainImg":
			filePath = MyFileUploadUtil.uploadImage(rootPath, MAIN_IMG_UPLOAD_PATH, 
					 orgFileName, file.getBytes());
			break;

		case "stepImg":
			filePath = MyFileUploadUtil.uploadImage(rootPath, STEP_IMG_UPLOAD_PATH, 
					 orgFileName, file.getBytes());
			break;
		case "complImg":
			filePath = MyFileUploadUtil.uploadImage(rootPath, COMPLETE_IMG_UPLOAD_PATH, 
					 orgFileName, file.getBytes());
			break;
		case "eventImg":
			filePath = MyFileUploadUtil.uploadImage(rootPath, EVENT_IMG_UPLOAD_PATH, 
					orgFileName, file.getBytes());
			break;
		}
		return filePath;
	}
	
	//첨부파일 서버에서 삭제
	@RequestMapping(value="/deleteFile", method=RequestMethod.GET)
	public String deleteFile(String filePath) throws Exception {
		if (MyFileUploadUtil.deleteFile(rootPath, filePath)) {
			return "success";
		};
		return "fail";
	}
	
	//*수정작업 (db에 있는 사진인지 판단하는 부분)
	@RequestMapping(value="/selectCompleteImgName", method=RequestMethod.POST, produces="application/text;charset=utf-8") 
	@ResponseBody
	public String selectCompleteImgName(@RequestBody CompleteImgVo completeImgVo){
		System.out.println("완성사진: " + completeImgVo);
		return hobbyService.selectCompleteImgName(completeImgVo);
	}
	
	@RequestMapping(value="/selectMainImg", method=RequestMethod.GET, produces="application/text;charset=utf-8") 
	@ResponseBody
	public String selectMainImg(int hobby_no){
		return hobbyService.selectMainImg(hobby_no);
	}
	

}
