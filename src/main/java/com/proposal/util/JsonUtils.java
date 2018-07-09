package com.proposal.util;

import com.fasterxml.jackson.core.JsonFactory;
import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.databind.JavaType;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.StringWriter;
import java.util.ArrayList;
import java.util.List;

/**
 * JSON工具类
 * @author hanyanwei
 *
 */
public class JsonUtils {

	private static final ObjectMapper mapper = new ObjectMapper();
	
	public static <T> T parseJson2Object(String strJson,Class<T> clazz){
		try{
			return mapper.readValue(strJson, clazz);	
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return null;
	}
	
	public static String transObject2Json(Object obj){
		StringWriter sw = new StringWriter();  
		try{
			JsonGenerator gen = new JsonFactory().createGenerator(sw);
			mapper.writeValue(gen, obj);  
			gen.close();
			return sw.toString();
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return null;
	}
	
	public static <T> List<T> parseJson2List(String strJson,Class<T> clazz){
		
		JavaType javaType = getCollectionType(ArrayList.class, clazz);
		try{
			return mapper.readValue(strJson, javaType);	
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return null;
	}
	
	private static JavaType getCollectionType(Class<?> collectionClass, Class<?>... elementClasses) {   
		return mapper.getTypeFactory().constructParametricType(collectionClass, elementClasses);   
	} 	
}
