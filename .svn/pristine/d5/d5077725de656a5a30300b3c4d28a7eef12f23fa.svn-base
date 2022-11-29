package tea.ui.yl.shop;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

import sun.misc.BASE64Decoder;
import tea.entity.Attch;
import tea.entity.Filex;
import tea.entity.Http;
import tea.entity.MT;
import tea.entity.Seq;
import tea.entity.member.Profile;
import tea.entity.member.SMSMessage;
import tea.entity.yl.shop.ShopNvoice;
import tea.entity.yl.shop.ShopOrder;
import tea.entity.yl.shop.ShopOrderAddress;
import tea.entity.yl.shop.ShopOrderDispatch;
import tea.entity.yl.shop.ShopSMSSetting;
import util.CommonUtils;
import tea.entity.Seq;

/**
 * 提交订单
 * */
public class CompressImg2 extends HttpServlet{

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		PrintWriter out = resp.getWriter();
		resp.setContentType("text/html; charset=UTF-8");
        Http h = new Http(req, resp);
        String act = h.get("act"), nexturl = h.get("nexturl", "");
        
        	String img=req.getParameter("img");
			//String[] imgtype=req.getParameterValues("type");
			String savepath = "/res/Home/yl/";
			try {
				String name="";
				int imgsize = 0;
				
				String realPath = this.getServletConfig().getServletContext().getRealPath("/");

				String filePath = realPath + savepath;
				
				JSONArray jsonarray = new JSONArray();  
				

					
					JSONObject jsonobj = new JSONObject(); 
					int id = Seq.get();
					//Filex.logs("ytimg.txt", i+"==="+id);
					String fileData=img;
					//String newFileName=id+"."+imgtype[i];
					String newFileName=id+".png";
					File f = new File(filePath, newFileName);
					// 使用BASE64对图片文件数据进行解码操作
					BASE64Decoder decoder = new BASE64Decoder();
					// 通过Base64解密，将图片数据解密成字节数组
					fileData = fileData.substring(fileData.indexOf(",") + 1);
					byte[] bytes = decoder.decodeBuffer(fileData);
					// 构造字节数组输入流
					ByteArrayInputStream bais = new ByteArrayInputStream(bytes);
					// 读取输入流的数据
					BufferedImage bi = ImageIO.read(bais);
					// 将数据信息写进图片文件中
					ImageIO.write(bi, "jpg", new File(filePath, newFileName));// 不管输出什么格式图片，此处不需改动
					bais.close();
					name = id + "";
					//Filex.logs("ytimg.txt", i+"==="+id+"aaaaaa");
					Attch a = new Attch(id);
					a.node = 14050050;
					a.name = name + ".png";
					a.path = savepath + name + ".png";
					a.type = "png";
					a.length = imgsize;
					a.community = "Home";
					a.set();
					//Filex.logs("ytimg.txt", i+"==="+id+"bbbbbb");
					jsonobj.put("attch", a.attch);
					jsonarray.add(jsonobj);
				
				out.print(jsonarray);
				
			} catch (Exception es) {
				es.printStackTrace();
				
			}
        	
    			
    			
    	
		
		
		
		
	}

	
}
