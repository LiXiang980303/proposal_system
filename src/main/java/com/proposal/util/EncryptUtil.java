package com.proposal.util;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import java.security.Key;
import java.security.spec.AlgorithmParameterSpec;

public class EncryptUtil {
    public static void main(String[] args){
        String s = EncryptPassword("static");
        String t = DecryptPassword(s);
        System.out.println(t);
    }

    private static byte[] DecryptData(Cipher cipher, byte cipherText[], String sKey) throws Exception {
        Key key = new SecretKeySpec(sKey.getBytes(), "DES");
        AlgorithmParameterSpec paramSpec = new IvParameterSpec(sKey.getBytes());
        cipher.init(2, key, paramSpec);
        return cipher.doFinal(cipherText);
    }

    /**
     * 解密
     * @param decryptString
     * */
    public static String DecryptPassword(String decryptString) {
        String decryptResult = decryptString;
        try {
            Cipher cipher = Cipher.getInstance("DES/CBC/PKCS5Padding");
            byte decryptByte[] = new byte[decryptString.length() / 2];
            for (int x = 0; x < decryptString.length() / 2; x++) {
                String s = decryptString.substring(x * 2, x * 2 + 2);
                int i = Integer.parseInt(s, 16);
                decryptByte[x] = (byte) i;
            }

            byte cleartext[] = DecryptData(cipher, decryptByte, sPwdKey);
            for (int i = 0; i < cleartext.length; i++) {
                int ii = cleartext[i] <= 0 ? cleartext[i] + 256 : ((int) (cleartext[i]));
            }
            decryptResult = new String(cleartext);
            return decryptResult;
        } catch (Exception enE) {
            enE.printStackTrace();
            return decryptResult;
        }

    }

    private static byte[] EncryptData(Cipher cipher, byte plainText[], String sKey) throws Exception {
        Key key = new SecretKeySpec(sKey.getBytes(), "DES");
        AlgorithmParameterSpec paramSpec = new IvParameterSpec(sKey.getBytes());
        cipher.init(1, key, paramSpec);
        return cipher.doFinal(plainText);
    }

    /**
     * 加密
     * @param encryptString
     * */
    public static String EncryptPassword(String encryptString) {
        String encryptResult = encryptString;
        try {
            StringBuffer encryptBuffer = new StringBuffer();
            Cipher cipher = Cipher.getInstance("DES/CBC/PKCS5Padding");
            byte ciphertext[] = EncryptData(cipher, encryptString.getBytes(), sPwdKey);
            for (int i = 0; i < ciphertext.length; i++) {
                int ii = ciphertext[i] <= 0 ? ciphertext[i] + 256 : ((int) (ciphertext[i]));
                String s = Integer.toHexString(ii);
                if (s.length() == 1)
                    s = "0" + s;
                else if (s.length() > 2)
                    s = s.substring(s.length() - 2, s.length());
                encryptBuffer.append(s);
            }

            encryptResult = encryptBuffer.toString().toUpperCase();
            return encryptResult;
        } catch (Exception enE) {
            enE.printStackTrace();
            return encryptResult;
        }
    }

    private static final String sPwdKey = "mailpass";
    private static final String transform = "DES/CBC/PKCS5Padding";
}
