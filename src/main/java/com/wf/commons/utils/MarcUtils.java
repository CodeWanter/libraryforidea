package com.wf.commons.utils;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import org.apache.commons.lang.StringUtils;

public class MarcUtils {

	public static Map<String,Object> readFileByLines(String fileName) {
		Map<String,Object> marcMap = new HashMap<String,Object>(); 
		File file = new File(fileName);
		BufferedReader reader = null;
		try {
			System.out.println("以行为单位读取文件内容，一次读一整行：");
			reader = new BufferedReader(new InputStreamReader(new FileInputStream(file),"GBK"));
			String tempString = null;
			// 一次读入一行，直到读入null为文件结束
			MarcUtils rm=new MarcUtils();
			ArrayList<Map<String,String>> objectsList = new ArrayList<Map<String,String>>();
			HashSet<String> filedsSet = new HashSet<String>();
			int countNum = 1;
			while (StringUtils.isNotBlank(tempString = reader.readLine())) {
				try{
					HashMap<String,String> filedsMap = new HashMap<String,String>();
					rm.showMarc(tempString.getBytes("GBK"),filedsMap,filedsSet);
					objectsList.add(filedsMap);
					countNum++;
				}catch(Exception e){
					e.printStackTrace();
				}
			}
			marcMap.put("data",objectsList);
			marcMap.put("filed",filedsSet);
			for(Map<String,String> aa : objectsList){
				Map<String, String> resultMap = sortMapByKey(aa);    //按Key进行排序
				System.out.println("=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=");
				for (Map.Entry<String,String> entry : resultMap.entrySet()) { 
					  System.out.println("Key = " + entry.getKey() + ", Value = " + entry.getValue()); 
				}
			}
			/*System.out.println("一下是字段:===");
			for(String aa : filedsSet){
				System.out.println(aa);
			}*/
			
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (reader != null) {
				try {
					reader.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return marcMap;

	}

	public static void showMarc(byte[] bytes,HashMap<String,String> filedsMap,HashSet<String> filedsSet) {
		
		try {
			// 读取此条数据的总长度
			byte marcB[] = new byte[5];
			for (int i = 0; i < 5; i++) {
				marcB[i] = bytes[i];
			}
			String marcS = new String(marcB);
			int marcLen = Integer.parseInt(marcS);
			
			// 读取数据基地址
			byte marcB2[] = new byte[5];
			for (int i = 0; i < 5; i++) {
				marcB2[i] = bytes[i + 12];
			}
			String marcS2 = new String(marcB2);
			int dataStart = Integer.parseInt(marcS2);
			
			// 读取次目录区数据
			int cmLength = dataStart - 24 - 1;
			byte marcB3[] = new byte[cmLength];
			for (int i = 0; i < cmLength; i++) {
				marcB3[i] = bytes[i + 24];
			}
			
			// 读取记录控制信息
			String marcS3 = new String(marcB3);
			int n = cmLength / 12;
			String[] controls = new String[n];
			for (int i = 0; i < n; i++) {
				controls[i] = marcS3.substring(i * 12, (i + 1) * 12);
			}
			
			// 读取数据区信息
			int dataLength = marcLen - dataStart - 1;
			byte data[] = new byte[dataLength];
			for (int i = 0; i < dataLength; i++) {
				data[i] = bytes[i + dataStart];
			}
			String OKData[][] = new String[n][2];
			
			for (int i = 0; i < n; i++) {
				OKData[i][0] = controls[i].substring(0, 3);
				int length = Integer.parseInt(controls[i].substring(3, 7));
				int start = Integer.parseInt(controls[i].substring(7));
				//不取每个字段数据最后的结束符
				byte[] temp = new byte[length-1];
				for (int j = start; j < start + length-1; j++) {
					if(data[j]==31){
						//分隔符
						temp[j - start] = 124;
					}else{
						temp[j - start] = data[j];
					}
				}
				OKData[i][1] = new String(temp,"GBK");
				
				String head = OKData[i][0];
				String fields = OKData[i][1];
				System.out.print(head);
				System.out.print(fields);
				System.out.println();
				if(fields.contains("|")){
					String[] fieldsArr = fields.split("\\|");
					List<String> fieldsList = Arrays.asList(fieldsArr);
					for(int j =1;j<fieldsList.size();j++){
						String fieldStr = fieldsList.get(j);
//						System.out.println("fieldStr==" + fieldStr);
						String childHead = fieldStr.substring(0, 1);
						String content = fieldStr.substring(1,fieldStr.length());
						String key = ("_" + head + childHead).trim();
						String tempKey = key;
						int k = 2;
						while(filedsMap.containsKey(key)){
							key = tempKey + "_" + k;
							k++;
						}
						filedsSet.add(key);
						filedsMap.put(key, content);
					}
				}else{
					filedsMap.put(head, fields);
				}
			}
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
     * 使用 Map按key进行排序
     * @param map
     * @return
     */
    public static Map<String, String> sortMapByKey(Map<String, String> map) {
        if (map == null || map.isEmpty()) {
            return null;
        }

        Map<String, String> sortMap = new TreeMap<String, String>(
                new MapKeyComparator());

        sortMap.putAll(map);

        return sortMap;
    }
	public static void main(String args[]) throws Exception {
		String file1 = "F:/marc/hascopyright.iso";
		MarcUtils rm = new MarcUtils();
		rm.readFileByLines(file1);
	}
}


class MapKeyComparator implements Comparator<String>{
    @Override
    public int compare(String str1, String str2) {
        return str1.compareTo(str2);
    }
}
