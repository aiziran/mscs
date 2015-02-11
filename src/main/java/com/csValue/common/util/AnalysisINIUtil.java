package com.csValue.common.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Properties;

import org.ini4j.Ini;
import org.ini4j.Profile;

public class AnalysisINIUtil {
	public static boolean flag=false; 
	public static void main(String[] args) {
	
		String s = "biiiiiiiiiiiiiiiiiiiiiiiiiiipoiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiijhbvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvkjhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhgggggggggggggggggggggggggggggggggtttttttttttttttttttttttttttttttttttttfffffffffffffffffffffffffvccccccccccccccccccccccccccccccccccxab".toLowerCase();   
		System.out.println(perfect(s));
	}
	public static int perfect(String s){
		int[] num = new int[26];   
		for (char c : s.toCharArray()) {   
		    num[(int)c - 97]++;   
		}  
		AnalysisINIUtil.sortArray(num);
		int count=26;
		int total=0;
		for(int i=num.length-1;i>0;i--){
			if(num[i]==0){
				break;
			}
			total=total+num[i]*count;
			count--;
		}
		return total;
	}

	public static void sortArray(int[] nums){
		for(int i=0;i<nums.length;i++){
			if(flag){
				break;
			}
			sortArray(nums,i);
		}
	}
	public static void sortArray(int[] nums,int count){
		int changeCount=0;
		for(int i=1;i<nums.length-count;i++){
			int frist=nums[i-1];
			int last=nums[i];
			if(frist>last){
				nums[i]=nums[i-1];
				nums[i-1]=last;
				changeCount++;
			}
		}
		if(changeCount==0){
			flag=true;
		}
	}
	
	
	public static void DichotomySort(int[] array)
    {
        for (int i = 0; i < array.length; i++)
        {
            int start, end, mid;
            start = 0;
            end = i - 1;
            mid = 0;
            int temp = array[i];
            while (start <= end)
            {
                mid = (start + end) / 2;
                if (array[mid] > temp)//要排序元素在已经排过序的数组左边
                {
                    end = mid - 1;
                }
                else
                {
                    start = mid + 1;
                }
            }
            for (int j = i - 1; j > end; j--)//找到了要插入的位置，然后将这个位置以后的所有元素向后移动

            {
                array[j + 1] = array[j];
            }
            array[end + 1] = temp;


        }
    }
	
	public static void writeData(String PROPERTY_FILE,String key, String value) {  
        Properties prop = new Properties();  
        try {  
            File file = new File(PROPERTY_FILE);  
            if (!file.exists())  
                file.createNewFile();  
            InputStream fis = new FileInputStream(file);  
            prop.load(fis);  
            fis.close();//一定要在修改值之前关闭fis  
            OutputStream fos = new FileOutputStream(PROPERTY_FILE);  
            prop.setProperty(key, value);  
            prop.store(fos, "Update '" + key + "' value");  
            fos.close();  
        } catch (IOException e) {  
            System.err.println("Visit " + PROPERTY_FILE + " for updating "  
                    + value + " value error");  
        }  
    }
	/**
	 * 简单解析ini文件.无视selection 遇到重复的KEY值会只去最后一个 支持中文
	 * 如果ini中没有此key值.返回null
	 * @param args
	 */

	public static String AnalysisIni(String path, String key) throws Exception {
		Properties ppt = new Properties();
		try {
			ppt.load(new FileInputStream(path));
		} catch (Exception e) {
		}

		return AnalysisINIUtil.Transcoding(ppt.getProperty(key));
		//		String p1 = AnalysisINIUtil.Transcoding(ppt.getProperty("NAME"));
		//		String p2 = AnalysisINIUtil.Transcoding(ppt.getProperty("NUM"));
		//		String p3 = AnalysisINIUtil.Transcoding(ppt.getProperty("IMAGESOURCE"));
		//		String p4 = AnalysisINIUtil.Transcoding(ppt.getProperty("BACKGROUND"));
		//
		//		System.out.println("NAME: "+p1);
		//		System.out.println("NUM: "+p2);
		//		System.out.println("IMAGESOURCE: "+p3);
		//		System.out.println("BACKGROUND: "+p4);

	}

	/**
	 * 使用尾递归取出所有例如DOC0，DOC1 等key值并使用逗号,拼成字符串返回回去
	 * @param path
	 * @param basekey 如 DOC  等
	 * @return
	 * @throws Exception
	 */
	public static String AnalysisIniByBaseKey(String path, String basekey) throws Exception {
		Properties ppt = new Properties();
		try {
			ppt.load(new FileInputStream(path));
		} catch (Exception e) {
		}
		StringBuffer sb = new StringBuffer("");
		AnalysisIniByBaseKey(basekey, ppt, sb, 0);
		System.out.print(sb.toString());
		return sb.toString();
	}

	private static void AnalysisIniByBaseKey(String basekey, Properties pt, StringBuffer sb, int count)
			throws Exception {
		String temp = AnalysisINIUtil.Transcoding(pt.getProperty(basekey + count));
		if (temp != null && !temp.equals("")) {
			if (sb.length() == 0) {
				sb.append(temp);
			} else {
				sb.append("," + temp);
			}
			AnalysisIniByBaseKey(basekey, pt, sb, count + 1);
		}
	}

	/**
	 * 使用ini4j简单解析ini文件支持区分 selection 同selection中KEY值重复还是会取最后一个
	 * 不支持中文
	 *@param args
	 * */
	public static void ini4jWay(String path) throws IOException {
		Ini ini = new Ini(new File(path));
		Profile.Section sec = ini.get("project1"); // get the section
		String p1 = sec.get("NAME");
		String p2 = sec.get("NUM");
		String p3 = sec.get("IMAGESOURCE");
		String p4 = sec.get("BACKGROUND");
		System.out.println("NAME: " + p1);
		System.out.println("NUM: " + p2);
		System.out.println("IMAGESOURCE: " + p3);
		System.out.println("BACKGROUND: " + p4);
	}

	public static String Transcoding(String str) throws Exception {
		if (str == null) {
			return "";
		}
		return new String(str.getBytes("ISO8859-1"), "gbk").trim();
	}

}
