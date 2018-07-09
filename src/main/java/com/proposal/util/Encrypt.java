package com.proposal.util;

/*
 用途: 简单加密/解密方法包装
 */
import java.net.URLEncoder;
import java.security.*;
import javax.crypto.*;
import sun.misc.BASE64Encoder;
import sun.misc.BASE64Decoder;

public class Encrypt {
    private static String Algorithm = "DES"; //定义 加密算法,可用 DES,DESede,Blowfish
    public static byte[] key = "!@#$%^&*".getBytes();//只能输入8个字节

    static boolean debug = false;

    static {
        Security.addProvider(new com.sun.crypto.provider.SunJCE());
    }

    //生成密钥, 注意此步骤时间比较长
    private static byte[] getKey() throws Exception {
        KeyGenerator keygen = KeyGenerator.getInstance(Algorithm);
        SecretKey deskey = keygen.generateKey();
        if (debug)
            System.out.println("生成密钥:" + byte2hex(deskey.getEncoded()));
        return deskey.getEncoded();
    }

    //加密
    private static byte[] encode(byte[] input, byte[] key) throws Exception {
        SecretKey deskey = new javax.crypto.spec.SecretKeySpec(key, Algorithm);
        if (debug) {
            System.out.println("加密前的二进串:" + byte2hex(input));
            System.out.println("加密前的字符串:" + new String(input));
        }
        Cipher c1 = Cipher.getInstance(Algorithm);
        c1.init(Cipher.ENCRYPT_MODE, deskey);
        byte[] cipherByte = c1.doFinal(input);
        if (debug)
            System.out.println("加密后的二进串:" + byte2hex(cipherByte));
        return cipherByte;
    }

    //解密
    private static byte[] decode(byte[] input, byte[] key) throws Exception {
        SecretKey deskey = new javax.crypto.spec.SecretKeySpec(key, Algorithm);
        if (debug)
            System.out.println("解密前的信息:" + byte2hex(input));
        Cipher c1 = Cipher.getInstance(Algorithm);
        c1.init(Cipher.DECRYPT_MODE, deskey);
        byte[] clearByte = c1.doFinal(input);
        if (debug) {
            System.out.println("解密后的二进串:" + byte2hex(clearByte));
            System.out.println("解密后的字符串:" + (new String(clearByte)));
        }
        return clearByte;
    }

    //md5()信息摘要, 不可逆
    private static byte[] md5(byte[] input) throws Exception {
        MessageDigest alg = MessageDigest
                .getInstance("MD5"); //or "SHA-1"
        if (debug) {
            System.out.println("摘要前的二进串:" + byte2hex(input));
            System.out.println("摘要前的字符串:" + new String(input));
        }
        alg.update(input);
        byte[] digest = alg.digest();
        if (debug)
            System.out.println("摘要后的二进串:" + byte2hex(digest));
        return digest;
    }

    //字节码转换成16进制字符串
    private static String byte2hex(byte[] b) {
        String hs = "";
        String stmp = "";
        for (int n = 0; n < b.length; n++) {
            stmp = (Integer.toHexString(b[n] & 0XFF));
            if (stmp.length() == 1)
                hs = hs + "0" + stmp;
            else
                hs = hs + stmp;
            if (n < b.length - 1)
                hs = hs + ":";
        }
        return hs.toUpperCase();
    }

    ///////////////////////////////////////////////////////////////

    public static String DataEncrypt(String str, byte[] key) {
        String encrypt = null;
        try {
            byte[] ret = encode(str.getBytes("UTF-8"), key);
            encrypt = new String(new BASE64Encoder().encodeBuffer(ret));
        } catch (Exception e) {
            //System.out.print(e);
            encrypt = str;
        }
        return encrypt;
    }

    public static String DataEncrypt(String str) {
        return DataEncrypt(str, key);
    }

    public static String DataDecrypt(String str, byte[] key) {
        String decrypt = null;
        try {
            byte[] ret = decode(new BASE64Decoder().decodeBuffer(str), key);
            decrypt = new String(ret, "UTF-8");
        } catch (Exception e) {
            //System.out.print(e);
            decrypt = str;
        }
        return decrypt;
    }

    public static String DataDecrypt(String str) {
        return DataDecrypt(str, key);
    }

    public static void main(String[] args) throws Exception {
        String username = "admin";
        username = URLEncoder.encode(username, "UTF-8");

        String password = DataEncrypt("111111").trim() + "_||_" + System.currentTimeMillis();
        password = DataEncrypt(password).trim();
        password = URLEncoder.encode(password, "UTF-8");

        System.out.println("http://oa-doc.bjeea.cn/ExamGW/enterForYZ.jsp?username=" + username + "&password=" + password + "&modeId=1");
        System.out.println("http://oa-meeting.bjeea.cn/ExamMR/enterForYZ.jsp?username=" + username + "&password=" + password + "&modeId=2");
        System.out.println("http://oa-org.bjeea.cn/ExamOrg/enterForYZ.jsp?username=" + username + "&password=" + password + "&modeId=3");
        System.out.println("http://oa-uim.bjeea.cn/ExamAuth/enterForYZ.jsp?username=" + username + "&password=" + password + "&modeId=4");
        System.out.println("http://oa-org.bjeea.cn/ExamOrg/enterForYZ.jsp?username=" + username + "&password=" + password + "&modeId=5");
        System.out.println("http://oa-org.bjeea.cn/ExamOrg/enterForYZ.jsp?username=" + username + "&password=" + password + "&modeId=6");
        System.out.println("http://oa-meeting.bjeea.cn/ExamMR/enterForYZ.jsp?username=" + username + "&password=" + password + "&modeId=7");
        System.out.println("http://oa-doc.bjeea.cn/ExamGW/enterForYZ.jsp?username=" + username + "&password=" + password + "&modeId=8");
        System.out.println("----------------------------------------");

        //		String[] s = password.split("_\\|\\|_");
//		long loginTime = Long.parseLong(s[1]);
//		long curTime = System.currentTimeMillis();
//		boolean isCanLogin = (curTime-loginTime)>=(5*60*1000)?false:true;//5 minute
        /////////////////////////////////////////////////////
        String ddd = DataEncrypt("Fksyoadbadmin72");
        String eee = DataDecrypt("hlerPAxjKuo=");
        System.out.println(ddd);
        System.out.println(eee);
    }
}