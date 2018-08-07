package com.wf.commons.utils;

import java.io.File;
import java.io.IOException;
import java.util.Date;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
/**
* 
* <p>Title: FileUtils</p>  
* <p>Description: 文件操作类</p>  
* @author zjh  
* @date 2018年7月19日
 */
public class FileUtils {
	//文件上传
	public static String fileUpload(MultipartFile file,String path){
		File newFile = new File(path);
		if (!newFile.exists()){
			newFile.mkdirs();
		} 
		String savePath = path + "/" + file.getOriginalFilename();
		try {
			file.transferTo(new File(savePath));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return savePath;
	}
}
