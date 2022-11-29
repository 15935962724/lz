package tea.ui.yl.shop;

import java.io.IOException;
import java.util.Hashtable;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tea.entity.Filex;
import tea.entity.Http;
import util.MatrixToImageWriter;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.common.BitMatrix;

/**
 * 生成二维码 输出到页面
 * 
 * @author Guodh
 * 
 * */
public class CodeServlet extends HttpServlet{

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
        Http h = new Http(request, response);
        try {
        	String text = h.get("text","http://www.redcome.com");
        	Filex.logs("yt_qianshou.txt", "code2=================="+text);
			int width = h.getInt("w",300); 
			int height = h.getInt("h",300); 
			
			//二维码的图片格式 
			String format = "gif"; 
			Hashtable hints = new Hashtable(); 
			//内容所使用编码 
			hints.put(EncodeHintType.CHARACTER_SET, "utf-8"); 
			hints.put(EncodeHintType.MARGIN, 1); //设置边框 距离
			BitMatrix bitMatrix = new MultiFormatWriter().encode(text,BarcodeFormat.QR_CODE, width, height, hints); 
			
			//生成二维码  生成图片
//			File outputFile = new File("d:"+File.separator+"new.gif"); 
//			MatrixToImageWriter.writeToFile(bitMatrix, format, outputFile);
			
			//生成二维码  文件流输出到页面
			MatrixToImageWriter.writeToStream(bitMatrix, format, response.getOutputStream());
			
        	
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
