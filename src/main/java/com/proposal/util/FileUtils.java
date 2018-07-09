package com.proposal.util;

import java.io.*;

/**
 * Created by dynam on 2017/4/3.
 */
public class FileUtils {


    private static final String filePath = "F:\\jn.dbf";

    public static void main(String[] args) throws IOException {
        String str = "abcdefg";
        getTest();
    }



    private static void getTestDemo2(String str) throws IOException {
        try(ByteArrayInputStream in = new ByteArrayInputStream(str.getBytes());
            PushbackInputStream pbis = new PushbackInputStream(in, 3)){
            int n;
            byte[] buffer = new byte[3];
            while((n = pbis.read(buffer)) != -1){
                System.out.println(new String(buffer));
                if("abc".equals(new String(buffer))){
                    //pbis.unread(new byte[]{'M', 'N', 'O'});//返回一个缓存
                    pbis.unread(buffer, 1, 2);//只返回一部分数据
                }
                buffer = new byte[3];
            }
        }
    }

    private static void getTestDemo(String str) throws IOException {
        try(ByteArrayInputStream in = new ByteArrayInputStream(str.getBytes());
            PushbackInputStream pbis = new PushbackInputStream(in)){
            int n;
            while((n = pbis.read()) != -1){
                System.out.println((char) n);
                if('b' == n){
                    pbis.unread('U');
                }
            }
        }
    }

    private static void getTest(){
        File file = new File(filePath);
        FileInputStream fis = null;
        PushbackInputStream pis = null;
        FileOutputStream fos = null;
        FileOutputStream fos2 = null;
        try {
            fis = new FileInputStream(file);
            pis = new PushbackInputStream(fis);

            fos = new FileOutputStream("E:\\copy1.dbf");
            fos2 = new FileOutputStream("E:\\copy2.dbf");

            int length = 0;
            byte[] b = new byte[1024];
            byte[] buffer = new byte[3];
            while ((length = pis.read(b)) != -1) {

                fos.write(b, 0, length);
                pis.unread(b);
                fos2.write(b, 0, length);

            }
            length = 0;
            byte[] b1 = new byte[1024];
            while ((length = pis.read(b1)) != -1) {
                fos2.write(b1, 0, length);
            }

            fos2.close();
            fos.close();
            pis.close();
            fis.close();

        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}
