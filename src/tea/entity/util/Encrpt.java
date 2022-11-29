package tea.entity.util;

import java.io.IOException;
import java.security.SecureRandom;
import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;
import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

public class Encrpt
{

    /**
     * 自定义加密串
     */
    private static final String key = "d1cm_zxm_passport";

    private static byte[] desKey = key.getBytes();

    public Encrpt(String desKey)
    {
        this.desKey = desKey.getBytes();
    }

    public static byte[] desEncrypt(byte[] plainText) throws Exception
    {
        SecureRandom sr = new SecureRandom();
        byte rawKeyData[] = desKey;
        DESKeySpec dks = new DESKeySpec(rawKeyData);
        SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
        SecretKey key = keyFactory.generateSecret(dks);
        Cipher cipher = Cipher.getInstance("DES");
        cipher.init(Cipher.ENCRYPT_MODE,key,sr);
        byte data[] = plainText;
        byte encryptedData[] = cipher.doFinal(data);
        return encryptedData;
    }

    public static byte[] desDecrypt(byte[] encryptText) throws Exception
    {
        SecureRandom sr = new SecureRandom();
        byte rawKeyData[] = desKey;
        DESKeySpec dks = new DESKeySpec(rawKeyData);
        SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
        SecretKey key = keyFactory.generateSecret(dks);
        Cipher cipher = Cipher.getInstance("DES");
        cipher.init(Cipher.DECRYPT_MODE,key,sr);
        byte encryptedData[] = encryptText;
        byte decryptedData[] = cipher.doFinal(encryptedData);
        return decryptedData;
    }

    public static String base64Encode(byte[] s)
    {
        if(s == null)
            return null;
        BASE64Encoder b = new sun.misc.BASE64Encoder();
        return b.encode(s);
    }

    public static byte[] base64Decode(String s) throws IOException
    {
        if(s == null)
            return null;
        BASE64Decoder decoder = new BASE64Decoder();
        byte[] b = decoder.decodeBuffer(s);
        return b;
    }

    /**
     * 字符串加密
     * @author kgj
     * @method encrypt
     * @param input
     * @return
     * @throws Exception String
     * @time   Jul 1, 20114:26:20 PM
     */
    public static String encrypt(String input) throws Exception
    {
        return base64Encode(desEncrypt(input.getBytes()));
    }

    /**
     * 字符串解密
     * @author kgj
     * @method decrypt
     * @param input
     * @return
     * @throws Exception String
     * @time   Jul 1, 20114:26:05 PM
     */
    public static String decrypt(String input) throws Exception
    {
        byte[] result = base64Decode(input);
        return new String(desDecrypt(result));
    }

   /* public static void main(String[] args) throws Exception
    {
        String input = "admin";
        System.out.println("Encode:" + Encrpt.encrypt(input));
        System.out.println("Decode:"
                           + Encrpt.decrypt("48aXWEyngl5gsuDNvmr/QA=="));
    }*/
}
