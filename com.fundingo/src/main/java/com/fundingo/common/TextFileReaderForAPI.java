package com.fundingo.common;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;

public class TextFileReaderForAPI {

	public TextFileReaderForAPI() {
		// TODO Auto-generated constructor stub
	}
	
	public static String getIDPwd(String key) throws IOException {
		
		String value = null;

        File file = new File("C:\\z.utility\\api_key.txt");
        FileReader filereader = new FileReader(file);
        BufferedReader bufReader = new BufferedReader(filereader);
        String line = "";
        
        while((line = bufReader.readLine()) != null){
            if(line.indexOf(key)!=-1) {
            	value= line.substring(line.indexOf("=")+1);
            	System.out.println(value);
            }
        }          
        bufReader.close();
		
		return value;
	}

}
