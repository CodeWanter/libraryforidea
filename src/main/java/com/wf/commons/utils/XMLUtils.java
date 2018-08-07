package com.wf.commons.utils;
  
import java.io.IOException;  
import java.io.StringWriter;  
import java.util.Iterator;   
import java.util.List;  
import java.util.Map;  
   

import org.dom4j.Document;  
import org.dom4j.DocumentException;  
import org.dom4j.DocumentHelper;  
import org.dom4j.Element;  
import org.dom4j.io.OutputFormat;  
import org.dom4j.io.XMLWriter;  

public class XMLUtils {
	
	/** 
     * map转xml map中没有根节点的键 
     * @param map 
     * @param rootName 
     * @throws DocumentException 
     * @throws IOException 
     */  
    public static Document map2xml(Map<String, Object> map, String rootName) throws DocumentException, IOException  {  
        Document doc = DocumentHelper.createDocument();  
        Element root = DocumentHelper.createElement(rootName);  
        doc.add(root);  
        map2xml(map, root);  
        //System.out.println(doc.asXML());  
        //System.out.println(formatXml(doc));  
        return doc;  
    }  
      
    /** 
     * map转xml map中含有根节点的键 
     * @param map 
     * @throws DocumentException 
     * @throws IOException 
     */  
    public static Document map2xml(Map<String, Object> map) throws DocumentException, IOException  {  
        Iterator<Map.Entry<String, Object>> entries = map.entrySet().iterator();  
        if(entries.hasNext()){ //获取第一个键创建根节点  
            Map.Entry<String, Object> entry = entries.next();  
            Document doc = DocumentHelper.createDocument();  
            Element root = DocumentHelper.createElement(entry.getKey());  
            doc.add(root);  
            map2xml((Map)entry.getValue(), root);  
            //System.out.println(doc.asXML());  
            //System.out.println(formatXml(doc));  
            return doc;  
        }  
        return null;  
    }  
      
    /** 
     * map转xml 
     * @param map 
     * @param body xml元素 
     * @return 
     */  
    private static Element map2xml(Map<String, Object> map, Element body) {  
        Iterator<Map.Entry<String, Object>> entries = map.entrySet().iterator();  
        while (entries.hasNext()) {  
            Map.Entry<String, Object> entry = entries.next();  
            String key = entry.getKey();  
            Object value = entry.getValue();  
            if(key.startsWith("@")){    //属性  
                body.addAttribute(key.substring(1, key.length()), value.toString());  
            } else if(key.equals("#text")){ //有属性时的文本  
                body.setText(value.toString());  
            } else {  
                if(value instanceof java.util.List ){
                    List list = (List)value;  
                    Object obj;  
                    for(int i=0; i<list.size(); i++){  
                        obj = list.get(i);  
                        //list里是map或String，不会存在list里直接是list的，  
                        if(obj instanceof java.util.Map){  
                            Element subElement = body.addElement(key);  
                            map2xml((Map)list.get(i), subElement);  
                        } else {  
                            body.addElement(key).setText((String)list.get(i));  
                        }  
                    }  
                } else if(value instanceof java.util.Map ){  
                    Element subElement = body.addElement(key);  
                    map2xml((Map)value, subElement);  
                } else {  
                    body.addElement(key).setText(value.toString());  
                }  
            }  
            //System.out.println("Key = " + entry.getKey() + ", Value = " + entry.getValue());  
        }  
        return body;  
    }  
      
    /** 
     * 格式化输出xml 
     * @param xmlStr 
     * @return 
     * @throws DocumentException 
     * @throws IOException 
     */  
    public static String formatXml(String xmlStr) throws DocumentException, IOException  {  
        Document document = DocumentHelper.parseText(xmlStr);  
        return formatXml(document);  
    }  
      
    /** 
     * 格式化输出xml 
     * @param document 
     * @return 
     * @throws DocumentException 
     * @throws IOException 
     */  
    public static String formatXml(Document document) throws DocumentException, IOException  {  
        // 格式化输出格式  
        OutputFormat format = OutputFormat.createPrettyPrint();  
        //format.setEncoding("UTF-8");  
        StringWriter writer = new StringWriter();  
        // 格式化输出流  
        XMLWriter xmlWriter = new XMLWriter(writer, format);  
        // 将document写入到输出流  
        xmlWriter.write(document);  
        xmlWriter.close();  
        return writer.toString();  
    }
    
    // 字符串转二进制  
    public static String hex2byte(String str) {
    	char[] strChar=str.toCharArray();
	    String result="";
	    for(int i=0;i<strChar.length;i++){
	        result +=Integer.toBinaryString(strChar[i])+ " ";
	    }
    	return result;
	}
    
    // 二进制转字符串  
    public static String byte2hex(String binStr){  
         String[] tempStr=binStr.split(" ");
         char[] tempChar=new char[tempStr.length];
         for(int i=0;i<tempStr.length;i++) {
            tempChar[i]=BinstrToChar(tempStr[i]);
         }
         return String.valueOf(tempChar);
	}
    //将二进制字符串转换成int数组
    public static int[] BinstrToIntArray(String binStr) {       
        char[] temp=binStr.toCharArray();
        int[] result=new int[temp.length];   
        for(int i=0;i<temp.length;i++) {
            result[i]=temp[i]-48;
        }
        return result;
    }
    
    //将二进制转换成字符
     public static char BinstrToChar(String binStr){
         int[] temp=BinstrToIntArray(binStr);
         int sum=0;
         for(int i=0; i<temp.length;i++){
             sum +=temp[temp.length-1-i]<<i;
         }   
         return (char)sum;
    }
    
	public static void main(String[] args) throws Exception {
		Document doc = DocumentHelper.createDocument();  
        Element root = DocumentHelper.createElement("catalogList");  
        doc.add(root);
        Element childRoot = DocumentHelper.createElement("catalog");
        childRoot.addElement("bookID").setText("001");
        childRoot.addElement("bookName").setText("格林童话");
        root.add(childRoot);
        Element childRoot2 = DocumentHelper.createElement("catalog");
        childRoot2.addElement("bookID").setText("002");
        childRoot2.addElement("bookName").setText("格林童话2");
        root.add(childRoot2);
        String catalog = formatXml(doc);
        System.out.println("转换前==" + catalog);
        
        String catalogByte = hex2byte(catalog);
        System.out.println("转化后==" + catalogByte);
        
        String result = byte2hex(catalogByte);
        System.out.println("转回来==" + result);
	}
}
