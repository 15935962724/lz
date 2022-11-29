import java.io.*;
import java.util.*;
import org.w3c.dom.*;
import javax.mail.internet.MimeUtility;
import sun.misc.*;
import java.text.SimpleDateFormat;

public class Xml
{
    public static void main(String[] args) throws Exception
    {
        SimpleDateFormat sdf = new SimpleDateFormat("EEE, d MMM yyyy HH:mm:ss Z",Locale.ENGLISH);
        String content = "测试中文abc123";
        String str = MimeUtility.encodeText("测试中文abc123","UTF-8","Q");
        System.out.println(str);
        String line = "----=_Part_2_13236543." + System.currentTimeMillis();
        StringBuilder sb = new StringBuilder();
        sb.append("EDN: " + str + " <robot@redcome.com>");
        sb.append("\r\nFrom: " + str + " <robot@redcome.com>");
        sb.append("\r\nTo: 1926314498@qq.com");
        sb.append("\r\nMessage-ID: <111HOme>");
        sb.append("\r\nSubject: " + str);
        sb.append("\r\nDate: " + sdf.format(new Date()));
        sb.append("\r\nContent-Type: multipart/mixed; boundary=" + line);
        sb.append("\r\n");
        //
        sb.append("\r\n--" + line);
        sb.append("\r\nContent-Type: application/octet-stream; name=" + MimeUtility.encodeText("测试中文.jpg","UTF-8","Q"));
        sb.append("\r\nContent-Transfer-Encoding: base64");
        sb.append("\r\n\r\n");
        byte[] by = tea.entity.Filex.read("D:/测试用图/test.jpg");
        sb.append(new BASE64Encoder().encodeBuffer(by));
        //
        sb.append("\r\n--" + line);
        sb.append("\r\nContent-Type: text/html;charset=UTF-8");
        sb.append("\r\nContent-Transfer-Encoding: quoted-printable");
        sb.append("\r\n\r\n");
        sb.append("=EF=BB=BF");
        sb.append(str.substring(10,str.length() - 2));
        //
        sb.append("\r\n--" + line + "--");
        tea.entity.Filex.write("D:/test.eml",sb.toString(),"UTF-8");

    }

}
