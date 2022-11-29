package tea.ui.taoism;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jxl.Workbook;
import jxl.format.UnderlineStyle;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import jxl.write.WriteException;
import jxl.write.biff.RowsExceededException;

import tea.entity.Attch;
import tea.entity.Http;
import tea.entity.MT;
import tea.entity.Seq;
import tea.entity.taoism.Cft;
import tea.entity.taoism.Country;
import tea.entity.taoism.Situation;
import tea.entity.taoism.Taoism;


public class Taoisms extends HttpServlet{
	WritableCellFormat HE,TH,DF,NF2;
	public void service(HttpServletRequest request, HttpServletResponse response)
    		throws ServletException, IOException {
    	request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		Http h = new Http(request);
		PrintWriter out=response.getWriter();
		if(h.member < 1)
        {
            out.print("<script>top.location.replace('/servlet/StartLogin?node=" + h.node + "');</script>");
            return;
        }
		out.println("<script>var mt=parent.mt;</script>");
		String act = h.get("act");
		String nexturl = h.get("nexturl");
		try {
			if(act.equals("upload")){
				out.println(Attch.find(h.getInt("file.attch")));
			}else if (act.equals("edit")) {
				int id=h.getInt("id",0);
				Taoism t=null;
				if(id==0){
					id=Seq.get();	
				}
				t=Taoism.find(id);
				t.a_name=h.get("a_name","");
				t.a_ramark=h.get("a_ramark");
				t.a_time=h.get("a_time");
				t.age=h.getInt("age");
				t.ass_opinion=h.get("ass_opinion");
				t.birthday=h.getDate("birthday");
				t.c_content=h.get("c_content");
				t.certificate=h.get("certificate");
				t.communication_address=h.get("communication_address");
				t.communication_c=h.get("country3");
				t.communication_p=h.get("city3");
				t.communication_s=h.get("county3");
				t.convert_time=h.get("convert_time");
				t.c_time=h.get("c_time");
				t.convertId=h.get("convertId");
				t.educ_lv=h.getInt("educ_lv");
				t.email=h.get("email");
				t.ethnic=h.getInt("ethnic");
				t.f_content=h.get("f_content");
				t.g_content=h.get("g_content");
				t.huji_address=h.get("huji_address");
				t.huji_c=h.get("country1");
				t.huji_p=h.get("city1");
				t.huji_s=h.get("county1");
				t.idCard=h.get("idCard");
				t.job=h.get("job");
				t.job_resume=h.get("job_resume");
				t.job_unit=h.get("job_unit");
				t.live_address=h.get("live_address");
				t.live_c=h.get("country2");
				t.live_p=h.get("city2");
				t.live_s=h.get("county2");
				t.master_name=h.get("master_name");
				t.mobile=h.get("mobile");
				t.name=h.get("name");
				t.phone=h.get("phone");
				t.picture=h.get("picture");
				t.professional=h.get("professional");
				t.qq=h.getInt("qq");
				t.school=h.get("school");
				t.sex=h.getInt("sex");
				t.situation=h.get("situation");
				t.specialty=h.get("specialty");
				t.sysId=h.get("sysId");
				t.t_name=h.get("t_name");
				t.t_ramark=h.get("t_ramark");
				t.t_time=h.get("t_time");
				t.time=new Date();
				t.temples_opinion=h.get("temples_opinion");
				t.weixinId=h.get("weixinId");
				t.x_content=h.get("x_content");
				t.z_content=h.get("z_content");
				t.otherway=h.get("otherway");
				t.o_mobile=h.get("o_mobile");
				/*String c_pic= h.get("c_pic.attch");
				if(c_pic!=null){
					t.c_pic=t.c_pic+c_pic+"|";
				}else if(t.c_pic==null){
					t.c_pic="|";
				}*/
				String Cftnames[]=h.getValues("Cftname");
				String Cftids[]=h.getValues("Cftid");
				String situations[]=h.getValues("situations");
				String situationsids[]=h.getValues("situationid");
				
				t.set();
				String cids[]=h.get("cids").split("[|]");
				for(int i=1;i<cids.length;i++){
					Cft cc=Cft.find(Integer.parseInt(cids[i]));
					cc.delete();
				}
				String sids[]=h.get("sids").split("[|]");
				for(int i=1;i<sids.length;i++){
					Situation stt=Situation.find(Integer.parseInt(sids[i]));
					stt.delete();
				}
                if(Cftids!=null){
					for(int i=0;i<Cftids.length;i++){
						String Cftname="",pic="";
						int cftid=0;
						Cftname=Cftnames[i];
						pic= h.get("pic"+i);
						cftid=Integer.parseInt(Cftids[i]);
						Cft c=null;
						if(cftid>0){
							c=Cft.find(cftid);
						}else{
							cftid=Seq.get();
							c=new Cft(cftid);
						}
						c.id=cftid;
						c.CftId=id;
						c.Cftname=Cftname;
						if(pic!=null){
							c.pic=pic;
						}
						c.set();
						
					}
				}
                if(situationsids!=null){
					for(int i=0;i<situationsids.length;i++){
						String situation="";
						int situationid=0;
						situationid=Integer.parseInt(situationsids[i]);
						situation=situations[i];
						Situation c=null;
						if(situationid>0){
							c=Situation.find(situationid);
						}else{
							situationid=Seq.get();
							c=new Situation(situationid);
						}
						c.id=situationid;
						c.situationId=id;
						c.situation=situation;
						c.set();
						
					}
				}
				out.print("<script>mt.show('操作成功！',1,'"+nexturl+"')</script>");
				
			}else if("del".equals(act)){
				int id=h.getInt("tid",0);
				if(id>0)
					Taoism.find(id).delete();
				out.print("<script>mt.show('删除成功！',1,'"+nexturl+"')</script>");
			}else if("export".equals(act)){
				String sql=h.get("sql","");
				List list=null;
				try {
					list = Taoism.find(sql, 0, Integer.MAX_VALUE);
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
//				pw.close();
				response.reset();
				ServletOutputStream s=response.getOutputStream();
				String name="皈依弟子信息表.xls";
				response.setHeader("Content-Disposition", "attachment; filename=\"" + new String(name.getBytes("GBK"),"ISO-8859-1") + "\""); 
                WritableWorkbook wwb = null;  
                wwb=Workbook.createWorkbook(s,Workbook.getWorkbook(new File(h.REAL_PATH+"/jsp/taoism/皈依弟子情况表.xls")));
                WritableSheet sheet= wwb.getSheet("Sheet0");
				int j=1;
				int k=0;
				Iterator it=list.iterator();
				while(it.hasNext()){
					Taoism t=(Taoism) it.next();
					String sit="";
					ArrayList al= Situation.find(" and situationId="+t.id, 0, Integer.MAX_VALUE);
					for(int i=0;i<al.size();i++){
						Situation st=(Situation)al.get(i);
						sit+=st.situation+",";
					}
					String c_c=t.communication_c.length()>0?Country.find(t.communication_c):"";
					String c_p=t.communication_p.length()>0?Country.find(t.communication_c+"-"+t.communication_p):"";
					String c_s=t.communication_s.length()>0?Country.find(t.communication_c+"-"+t.communication_p+"-"+t.communication_s):"";
					String h_c=t.huji_c.length()>0?Country.find(t.huji_c):"";
					String h_p=t.huji_c.length()>0?Country.find(t.huji_c+"-"+t.huji_p):"";
					String h_s=t.huji_c.length()>0?Country.find(t.huji_c+"-"+t.huji_p+"-"+t.huji_s):"";
					String l_c=t.live_c.length()>0?Country.find(t.live_c):"";
					String l_p=t.live_c.length()>0?Country.find(t.live_c+"-"+t.live_p):"";
					String l_s=t.live_c.length()>0?Country.find(t.live_c+"-"+t.live_p+"-"+t.live_s):"";
					try {
						sheet.addCell(new Label(0,j+1,MT.f(t.sysId)));
						sheet.addCell(new Label(1,j+1,MT.f(t.name)));
						sheet.addCell(new Label(2,j+1,MT.f(t.sex==0?"男":"女")));
						sheet.addCell(new Label(3,j+1,MT.f(t.birthday)));
						sheet.addCell(new Label(4,j+1,MT.f(t.age)));
						sheet.addCell(new Label(5,j+1,MT.f(Taoism.ETHNIC[t.ethnic])));
						sheet.addCell(new Label(6,j+1,MT.f(Taoism.EDUC_LV[t.educ_lv])));
						sheet.addCell(new Label(7,j+1,MT.f(t.school)));
						sheet.addCell(new Label(8,j+1,MT.f(t.professional)));
						sheet.addCell(new Label(9,j+1,MT.f(t.mobile)));
						sheet.addCell(new Label(10,j+1,MT.f(t.email)));
						sheet.addCell(new Label(11,j+1,MT.f(t.qq)));
						sheet.addCell(new Label(12,j+1,MT.f(t.idCard)));
						sheet.addCell(new Label(13,j+1,MT.f(t.weixinId)));
						sheet.addCell(new Label(14,j+1,MT.f(t.otherway)));
						sheet.addCell(new Label(15,j+1,MT.f(t.o_mobile)));
						sheet.addCell(new Label(16,j+1,MT.f(h_c)));
						sheet.addCell(new Label(17,j+1,MT.f(h_p)));
						sheet.addCell(new Label(18,j+1,MT.f(h_s)));
						sheet.addCell(new Label(19,j+1,MT.f(t.huji_address)));
						sheet.addCell(new Label(20,j+1,MT.f(l_c)));
						sheet.addCell(new Label(21,j+1,MT.f(l_p)));
						sheet.addCell(new Label(22,j+1,MT.f(l_s)));
						sheet.addCell(new Label(23,j+1,MT.f(t.live_address)));
						sheet.addCell(new Label(24,j+1,MT.f(c_c)));
						sheet.addCell(new Label(25,j+1,MT.f(c_p)));
						sheet.addCell(new Label(26,j+1,MT.f(c_s)));
						sheet.addCell(new Label(27,j+1,MT.f(t.communication_address)));
						sheet.addCell(new Label(28,j+1,MT.f(t.master_name)));
						sheet.addCell(new Label(29,j+1,MT.f(t.phone)));
						sheet.addCell(new Label(30,j+1,MT.f(t.convertId)));
						sheet.addCell(new Label(31,j+1,MT.f(t.convert_time)));
						sheet.addCell(new Label(32,j+1,MT.f(t.job)));
						sheet.addCell(new Label(33,j+1,MT.f(t.job_unit)));
						sheet.addCell(new Label(34,j+1,MT.f(t.specialty)));
						//sheet.addCell(new Label(33,j+1,MT.f(t.certificate)));
						sheet.addCell(new Label(35,j+1,MT.f(t.job_resume)));
						sheet.addCell(new Label(36,j+1,MT.f(t.temples_opinion)));
						sheet.addCell(new Label(37,j+1,MT.f(t.t_name)));
						sheet.addCell(new Label(38,j+1,MT.f(t.t_time)));
						sheet.addCell(new Label(39,j+1,MT.f(t.t_ramark)));
						sheet.addCell(new Label(40,j+1,MT.f(t.ass_opinion)));
						sheet.addCell(new Label(41,j+1,MT.f(t.a_name)));
						sheet.addCell(new Label(42,j+1,MT.f(t.a_time)));
						sheet.addCell(new Label(43,j+1,MT.f(t.a_ramark)));
						sheet.addCell(new Label(44,j+1,MT.f(t.c_time)));
						sheet.addCell(new Label(45,j+1,MT.f(sit)));
						sheet.addCell(new Label(46,j+1,MT.f(t.situation)));
						sheet.addCell(new Label(47,j+1,MT.f(t.g_content)));
						sheet.addCell(new Label(48,j+1,MT.f(t.c_content)));
						sheet.addCell(new Label(49,j+1,MT.f(t.x_content)));
						sheet.addCell(new Label(50,j+1,MT.f(t.f_content)));
						sheet.addCell(new Label(51,j+1,MT.f(t.z_content)));
						sheet.addCell(new Label(52,j+1,MT.f(t.picture)));
						
					} catch (RowsExceededException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					} catch (WriteException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}


					j++;
				}
				wwb.write();
				try {
					wwb.close();
				} catch (WriteException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				s.close();
				return ;
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
    }
	
}

