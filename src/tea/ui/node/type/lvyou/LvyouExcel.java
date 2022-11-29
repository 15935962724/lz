package tea.ui.node.type.lvyou;


import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jxl.format.UnderlineStyle;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import tea.entity.Entity;
import tea.entity.MT;
import tea.entity.admin.mov.MemberOrder;
import tea.entity.lvyou.LvyouCity;
import tea.entity.lvyou.LvyouJob;
import tea.entity.lvyou.LvyouJobCatagory;
import tea.entity.lvyou.ProfileLvyou;
import tea.entity.member.Profile;
import tea.entity.member.WomenOptions;
import tea.entity.node.MessageBoard;
import tea.entity.node.MessageBoardReply;
import tea.entity.node.Node;
import tea.entity.node.Talkback;
import tea.entity.node.TalkbackReply;
import tea.entity.photography.Photography;
import tea.entity.util.Card;
import tea.entity.women.Contributions;
import tea.resource.Common;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;



public class LvyouExcel extends TeaServlet
{
	public void init(ServletConfig servletconfig) throws ServletException
	{
	   super.init(servletconfig);
		super.r.add("/tea/resource/Annuity");
	}

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		// response.setHeader("Expires", "0");
		// response.setHeader("Cache-Control", "no-cache");
		// response.setHeader("Pragma", "no-cache");

		request.setCharacterEncoding("UTF-8");

		TeaSession teasession = new TeaSession(request);

		String files = teasession.getParameter("files");
		String act = teasession.getParameter("act");

		response.setContentType("application/x-msdownload");
		response.setHeader("Content-Disposition", "attachment; filename=" + java.net.URLEncoder.encode(files + ".xls", "UTF-8"));
		javax.servlet.ServletOutputStream os = response.getOutputStream();
		try
		{
			jxl.write.WritableWorkbook wwb = jxl.Workbook.createWorkbook(os);
			jxl.write.WritableSheet ws = wwb.createSheet(files, 0);



            WritableFont wf = new WritableFont(WritableFont.TIMES, 10,WritableFont.BOLD, false, UnderlineStyle.NO_UNDERLINE,jxl.format.Colour.BLACK); // 定义格式 字体 下划线 斜体 粗体 颜色
            WritableCellFormat wcf = new WritableCellFormat(wf); // 单元格定义
            
            wcf.setAlignment(jxl.format.Alignment.LEFT); // 设置对齐方式
           
           // ws.getSettings().setPrintGridLines(true);//是否打印网格线
            

			int i = 0,j=0,a=0,b=0;
		if("Jobs".equals(act))//导出职位
			{

				ws.setColumnView(0, 20); // 设置列的宽度
				ws.setColumnView(1, 20); // 设置列的宽度
				ws.setColumnView(2, 20); // 设置列的宽度
				ws.setColumnView(3, 20); // 设置列的宽度
				ws.setColumnView(4, 20); // 设置列的宽度
				ws.setColumnView(5, 20); // 设置列的宽度
				ws.setColumnView(6, 20); // 设置列的宽度
				 
			 

                ws.addCell(new jxl.write.Label(j++,0,"用户名",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"联系人",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"公司名称",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"工作地点",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"联系电话",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"招聘职位",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"发布时间",wcf));
                
                //选中导出
                if(teasession.getParameter("jid")!=null && teasession.getParameter("jid").length()>0)
                {
                	String jids[]= teasession.getParameterValues("jid");
              	  for(int k=0;k<jids.length;k++)
              	     {
              	    	int  id = Integer.parseInt(jids[k]);
              	    	LvyouJob job= LvyouJob.find(id);
                    	ProfileLvyou plv=new ProfileLvyou();
                    	plv=plv.find(job.getMember());
                    	LvyouCity pro=LvyouCity.find(job.getProvince());
                    	LvyouCity cit=LvyouCity.find(job.getCity());
                    	LvyouJobCatagory cat=LvyouJobCatagory.find(job.getJobcatagory());
         
              	       ws.addCell(new jxl.write.Label(0,k + 1,job.getMember()));
                       ws.addCell(new jxl.write.Label(1,k + 1,plv.getCompanyperson()));
                       ws.addCell(new jxl.write.Label(2,k + 1,plv.getCompanyname())); 
                       ws.addCell(new jxl.write.Label(3,k + 1,pro.getName()+"-"+cit.getName()));
                       ws.addCell(new jxl.write.Label(4,k + 1,plv.getCompanytelephone()));
                       ws.addCell(new jxl.write.Label(5,k + 1,cat.getName()));
                       ws.addCell(new jxl.write.Label(6,k + 1,job.getIssueToString()));
                
              	     }
                	
                	
                }
			
			}else if("Users".equals(act))//导出职位
			{

				ws.setColumnView(0, 20); // 设置列的宽度
				ws.setColumnView(1, 20); // 设置列的宽度
				ws.setColumnView(2, 20); // 设置列的宽度
				ws.setColumnView(3, 20); // 设置列的宽度
				ws.setColumnView(4, 20); // 设置列的宽度
				ws.setColumnView(5, 20); // 设置列的宽度
				ws.setColumnView(6, 20); // 设置列的宽度
				 
			 

                ws.addCell(new jxl.write.Label(j++,0,"姓名",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"性别",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"工作地点",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"联系电话",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"身份种类",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"操作年限",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"发布时间",wcf));
                
                //选中导出
                if(teasession.getParameter("jid")!=null && teasession.getParameter("jid").length()>0)
                {
                	String jids[]= teasession.getParameterValues("jid");
              	  for(int k=0;k<jids.length;k++)
              	     {
              	    	String member = jids[k];
              	    	ProfileLvyou plv=new ProfileLvyou();
              	    	plv=plv.find(member);
                    	LvyouCity pro=LvyouCity.find(plv.getProvince());
                    	LvyouCity cit=LvyouCity.find(plv.getCity());
                    	LvyouJobCatagory cat=LvyouJobCatagory.find(plv.getJobcategory());
                        Profile profile=Profile.find(plv.getMember());
           
         
              	       ws.addCell(new jxl.write.Label(0,k + 1,plv.getName()));
                       ws.addCell(new jxl.write.Label(1,k + 1,plv.getSex()==1?"男":"女"));
                       ws.addCell(new jxl.write.Label(2,k + 1,pro.getName()+"-"+cit.getName())); 
                       ws.addCell(new jxl.write.Label(3,k + 1,profile.getMobile()));
                       ws.addCell(new jxl.write.Label(4,k + 1,cat.getName()));
                       ws.addCell(new jxl.write.Label(5,k + 1,plv.getYears()));
                       ws.addCell(new jxl.write.Label(6,k + 1,profile.getTimeToString()));
                
              	     }
                	
                	
                }
			
			}
 
 
			wwb.write();
			wwb.close();
			os.close();
		} catch (Exception ex)
		{
			ex.printStackTrace();
		}
	}


}
