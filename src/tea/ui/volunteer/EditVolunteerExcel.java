package tea.ui.volunteer;

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
import tea.entity.member.Profile;
import tea.entity.member.WomenOptions;
import tea.entity.node.MessageBoard;
import tea.entity.node.MessageBoardReply;
import tea.entity.node.Node;
import tea.entity.node.Poll;
import tea.entity.node.PollChoice;
import tea.entity.node.PollResult;
import tea.entity.node.Talkback;
import tea.entity.node.TalkbackReply;
import tea.entity.photography.Photography;
import tea.entity.volunteer.Volunteer;
import tea.entity.women.Contributions;
import tea.resource.Common;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;



public class EditVolunteerExcel extends TeaServlet
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
		response.setContentType("text/html;charset=UTF-8");
	       

		TeaSession teasession = new TeaSession(request);

		String sql = teasession.getParameter("sql");
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
            

			int i = 0,j=0; 
			if("EditVolunteer".equals(act))//
			{

				    ws.setColumnView(0, 20); // 设置列的宽度
				    ws.setColumnView(1, 20); // 设置列的宽度
				    ws.setColumnView(2, 20); // 设置列的宽度
				    ws.setColumnView(3, 20); // 设置列的宽度
				    ws.setColumnView(4, 20); // 设置列的宽度
				    ws.setColumnView(5, 20); // 设置列的宽度
				    ws.setColumnView(6, 20); // 设置列的宽度
				    ws.setColumnView(7, 20); // 设置列的宽度
				    ws.setColumnView(8, 20); // 设置列的宽度 
				    ws.setColumnView(9, 20); // 设置列的宽度
				    ws.setColumnView(10, 20); // 设置列的宽度
				 
				    
               // ws.addCell(new jxl.write.Label(j++,0,"主题",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"用户名",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"姓名",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"性别",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"出生日期",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"手机",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"座机电话",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"Email",wcf)); 
                ws.addCell(new jxl.write.Label(j++,0,"职业",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"现居住地所在区县",wcf));
               
                ws.addCell(new jxl.write.Label(j++,0,"图片路径",wcf));
              
                ws.addCell(new jxl.write.Label(j++,0,"身份证",wcf));//身份证
                
                //选中导出
        
                if(teasession.getParameter("membercheckbox")!=null && teasession.getParameter("membercheckbox").length()>0)
                {
                	String tal []  = teasession.getParameterValues("membercheckbox");
                	
                	for(int i2 =0;i2<tal.length;i2++)
                	{
                		String member = tal[i2];
                		  Profile pobj = Profile.find(member);
                		  Volunteer vt  =  Volunteer.find(member);
                		  Profile pro = Profile.find(member);
                		  String sexy = pro.isSex()?"男":"女";
                		  String cstring = null;
                		  if(pobj.getCity(teasession._nLanguage).matches("\\d+"))     //正则表达式 详细见java.util.regex 类 Pattern
                		  {
                			  cstring = Volunteer.CITYS[Integer.parseInt(pobj.getCity(teasession._nLanguage))];
                		  }else
                		  {
                			  cstring =pobj.getCity(teasession._nLanguage);
                		  }

                		
                		 
                          ws.addCell(new jxl.write.Label(0,i + 1,member));
                          ws.addCell(new jxl.write.Label(1,i + 1,pobj.getFirstName(teasession._nLanguage)));
                          ws.addCell(new jxl.write.Label(2,i + 1,sexy)); 
                          ws.addCell(new jxl.write.Label(3,i + 1,pobj.getBirthToString()));
                          ws.addCell(new jxl.write.Label(4,i + 1,pobj.getMobile()));
                          ws.addCell(new jxl.write.Label(5,i + 1,pobj.getTelephone(teasession._nLanguage)));
                          ws.addCell(new jxl.write.Label(6,i + 1,pobj.getEmail()));
                          ws.addCell(new jxl.write.Label(7,i + 1,vt.getZhiye()));
                          ws.addCell(new jxl.write.Label(8,i + 1,cstring));
                          
                          ws.addCell(new jxl.write.Label(9,i + 1,pobj.getPhotopath(teasession._nLanguage)));
                          ws.addCell(new jxl.write.Label(10,i + 1,pobj.getCard()));
                        
                          i++; 
                		 
                	} 
                }else//sql 语句导出
                {
                	sql = MT.dec(sql); 
                	Enumeration e  = Profile.find(sql.toString(),0,Integer.MAX_VALUE);
                	while ( e.hasMoreElements()) {
                		
                		String member = String.valueOf(e.nextElement()); 
                		 Profile pobj = Profile.find(member);
               		  Volunteer vt  =  Volunteer.find(member);
               		  Profile pro = Profile.find(member);
               		  String sexy = pro.isSex()?"男":"女";
               		  String cstring = null;
               		  if(pobj.getCity(teasession._nLanguage).matches("\\d+"))     //正则表达式 详细见java.util.regex 类 Pattern
               		  {
               			  cstring = Volunteer.CITYS[Integer.parseInt(pobj.getCity(teasession._nLanguage))];
               		  }else
               		  {
               			  cstring =pobj.getCity(teasession._nLanguage);
               		  }

               		
               		 
                         ws.addCell(new jxl.write.Label(0,i + 1,member));
                         ws.addCell(new jxl.write.Label(1,i + 1,pobj.getFirstName(teasession._nLanguage)));
                         ws.addCell(new jxl.write.Label(2,i + 1,sexy)); 
                         ws.addCell(new jxl.write.Label(3,i + 1,pobj.getBirthToString()));
                         ws.addCell(new jxl.write.Label(4,i + 1,pobj.getMobile()));
                         ws.addCell(new jxl.write.Label(5,i + 1,pobj.getTelephone(teasession._nLanguage)));
                         ws.addCell(new jxl.write.Label(6,i + 1,pobj.getEmail()));
                         ws.addCell(new jxl.write.Label(7,i + 1,vt.getZhiye()));
                         ws.addCell(new jxl.write.Label(8,i + 1,cstring));
                     
                         ws.addCell(new jxl.write.Label(9,i + 1,pobj.getPhotopath(teasession._nLanguage)));
                         ws.addCell(new jxl.write.Label(10,i + 1,pobj.getCard()));
                        
                         i++;
                	}
                }
                
              
                
                

			}else if("Download".equals(act)) 
			{

						    ws.setColumnView(0, 20); // 设置列的宽度
						    ws.setColumnView(1, 20); // 设置列的宽度
						    ws.setColumnView(2, 20); // 设置列的宽度
						    ws.setColumnView(3, 20); // 设置列的宽度
						    ws.setColumnView(4, 20); // 设置列的宽度
						    ws.setColumnView(5, 20); // 设置列的宽度
						    ws.setColumnView(6, 20); // 设置列的宽度
						    ws.setColumnView(7, 20); // 设置列的宽度
						    ws.setColumnView(8, 20); // 设置列的宽度
						    ws.setColumnView(9, 20); // 设置列的宽度
						

				
		                ws.addCell(new jxl.write.Label(j++,0,"姓名",wcf));
		                ws.addCell(new jxl.write.Label(j++,0,"性别",wcf));
		                ws.addCell(new jxl.write.Label(j++,0,"出生日期",wcf));
		                ws.addCell(new jxl.write.Label(j++,0,"手机",wcf));
		                ws.addCell(new jxl.write.Label(j++,0,"座机电话",wcf));
		                ws.addCell(new jxl.write.Label(j++,0,"Email",wcf));
		                ws.addCell(new jxl.write.Label(j++,0,"职业",wcf));
		                ws.addCell(new jxl.write.Label(j++,0,"现居住地所在区县",wcf));
		           
		                ws.addCell(new jxl.write.Label(j++,0,"图片路径",wcf));
		                ws.addCell(new jxl.write.Label(j++,0,"身份证",wcf));
		             
		              
		            
	 
		                		
	             		 
	                       ws.addCell(new jxl.write.Label(0,i + 1,"张某某"));
	                       ws.addCell(new jxl.write.Label(1,i + 1,"男"));
	                       ws.addCell(new jxl.write.Label(2,i + 1,"1980-01-01")); 
	                       ws.addCell(new jxl.write.Label(3,i + 1,"13888888888"));
	                       ws.addCell(new jxl.write.Label(4,i + 1,"01012345678"));
	                       ws.addCell(new jxl.write.Label(5,i + 1,"ceshi@163.com"));
	                       ws.addCell(new jxl.write.Label(6,i + 1,"自由职业"));
	                       ws.addCell(new jxl.write.Label(7,i + 1,"海淀"));
	                    
	                       ws.addCell(new jxl.write.Label(8,i + 1,"/res/redribbon/volunteer/ce .png"));
	                       ws.addCell(new jxl.write.Label(9,i + 1,"371525195623652125"));
	                    
		                          i++; 
		       
			}else if("PollMemberStatistics".equals(act)) 
			{
				    ws.setColumnView(0, 20); // 设置列的宽度
				    ws.setColumnView(1, 20); // 设置列的宽度
				    ws.setColumnView(2, 20); // 设置列的宽度
				    ws.setColumnView(3, 20); // 设置列的宽度
				  
				 
				    
	            // ws.addCell(new jxl.write.Label(j++,0,"主题",wcf));
	             ws.addCell(new jxl.write.Label(j++,0,"参与者ID",wcf));
	             ws.addCell(new jxl.write.Label(j++,0,"投票问题",wcf));
	             ws.addCell(new jxl.write.Label(j++,0,"投票结果",wcf));
	             ws.addCell(new jxl.write.Label(j++,0,"参与调查日期",wcf));
	            
	             
	             
	             sql = MT.dec(sql); 
	             Enumeration e2 = PollResult.find(sql,0,Integer.MAX_VALUE);

	             while(e2.hasMoreElements())
	             {  
	             	
	             	int prid = ((Integer)e2.nextElement()).intValue();
	             	PollResult probj = PollResult.find(prid);
	             	PollChoice pcobj = PollChoice.find(probj.getAnswer());
	             	Poll plobj = Poll.find(probj.getPoll());
	             	String member = probj.getMember()._strR;
	             		
	             	String time =Entity.sdf.format(probj.getTime());
	             	
	             	if(member!=null && member.length()>=32){
	             		member="匿名";
	             	}
	             	
	             	 ws.addCell(new jxl.write.Label(0,i + 1,member));
                     ws.addCell(new jxl.write.Label(1,i + 1,plobj.getQuestion() ));
                     ws.addCell(new jxl.write.Label(2,i + 1,pcobj.getTitle())); 
                     ws.addCell(new jxl.write.Label(3,i + 1,time));
                   i++;
	             	
	             }
             		
	             
	           
			}else if("PollProblemStatistics".equals(act))
			{

			    ws.setColumnView(0, 20); // 设置列的宽度
			    ws.setColumnView(1, 20); // 设置列的宽度
			    ws.setColumnView(2, 20); // 设置列的宽度
			    ws.setColumnView(3, 20); // 设置列的宽度
			  
			 
			    
            // ws.addCell(new jxl.write.Label(j++,0,"主题",wcf));
             ws.addCell(new jxl.write.Label(j++,0,"投票问题",wcf));
             ws.addCell(new jxl.write.Label(j++,0,"投票选项",wcf));
             ws.addCell(new jxl.write.Label(j++,0,"票数",wcf));
             ws.addCell(new jxl.write.Label(j++,0,"所占比例",wcf));
            
             
             
             sql = MT.dec(sql);  
             Enumeration e2 = PollChoice.find(sql.toString(),0,Integer.MAX_VALUE);

             while(e2.hasMoreElements())
             { 
             	
             	int pcid = ((Integer)e2.nextElement()).intValue();
             	
             	PollChoice pcobj = PollChoice.find(pcid);
             	Poll plobj = Poll.find(pcobj.getPoll());
             	int co = PollResult.count(" and poll ="+pcobj.getPoll()+" and answer = "+pcid);
             	
             	String su = PollChoice.getResults_ZJG(pcobj.getPoll(),pcid,1,teasession._nLanguage);
             	su = su.replaceAll("<SPAN ID=PollIDBallot_2>", "").replaceAll("</SPAN>","");
             	 
             	 
             	 ws.addCell(new jxl.write.Label(0,i + 1,plobj.getQuestion()));
                 ws.addCell(new jxl.write.Label(1,i + 1,pcobj.getTitle() ));
                 ws.addCell(new jxl.write.Label(2,i + 1,String.valueOf(co))); 
                 ws.addCell(new jxl.write.Label(3,i + 1,su)); 
               i++;
             	
             } 
			}
			
		
			
			
			
			wwb.write();
			wwb.close();
			os.close();
		} catch (Exception ex)
		{
			ex.printStackTrace();
			java.io.PrintWriter out = response.getWriter();
			
			 out.print("<script  language='javascript'>alert('你下载的数据量太大，请有条件的下载表格!');</script> ");
             out.close();
           
		} 
	}


}
