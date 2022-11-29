package tea.ui.node.type.event;



import java.io.IOException;
import java.util.Enumeration;
import java.util.Iterator;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jxl.format.UnderlineStyle;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import tea.db.DbAdapter;
import tea.entity.Entity;
import tea.entity.MT;
import tea.entity.member.Profile;
import tea.entity.node.Poll;
import tea.entity.node.PollChoice;
import tea.entity.node.PollVote;
import tea.entity.node.PollVoteList;
import tea.entity.util.Card;
import tea.entity.westrac.Eventregistration;
import tea.entity.westrac.WestracClue;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;



public class EditWestracExcel extends TeaServlet
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
            
            tea.entity.node.Event eobj = tea.entity.node.Event.find(teasession._nNode, teasession._nLanguage);
			int i = 0,j=0,a=0,b=0; 
			if("Download".equals(act)) 
			{
				
						    ws.setColumnView(a++, 20); // 设置列的宽度
						    ws.setColumnView(a++, 20); // 设置列的宽度
						    ws.setColumnView(a++, 20); // 设置列的宽度
						    ws.setColumnView(a++, 20); // 设置列的宽度
						    ws.setColumnView(a++, 20); // 设置列的宽度
						    ws.setColumnView(a++, 20); // 设置列的宽度
						    ws.setColumnView(a++, 20); // 设置列的宽度
						    ws.setColumnView(a++, 20); // 设置列的宽度
						    ws.setColumnView(a++, 20); // 设置列的宽度
						    ws.setColumnView(a++, 20); // 设置列的宽度
						    ws.setColumnView(a++, 20); // 设置列的宽度
						    ws.setColumnView(a++, 20); // 设置列的宽度
						    ws.setColumnView(a++, 20); // 设置列的宽度
						    ws.setColumnView(a++, 20); // 设置列的宽度
						    ws.setColumnView(a++, 20); // 设置列的宽度
						    ws.setColumnView(a++, 20); // 设置列的宽度
						    ws.setColumnView(a++, 20); // 设置列的宽度
						    ws.setColumnView(a++, 20); // 设置列的宽度
						    ws.setColumnView(a++, 20); // 设置列的宽度
						    ws.setColumnView(a++, 20); // 设置列的宽度
						    ws.setColumnView(a++, 20); // 设置列的宽度
						    ws.setColumnView(a++, 20); // 设置列的宽度

				
		                ws.addCell(new jxl.write.Label(j++,0,"会员编号",wcf));
		                ws.addCell(new jxl.write.Label(j++,0,"用户名",wcf));
		                ws.addCell(new jxl.write.Label(j++,0,"手机号",wcf));
		                ws.addCell(new jxl.write.Label(j++,0,"现工作地省",wcf));
		                ws.addCell(new jxl.write.Label(j++,0,"现工作地市",wcf));
		                ws.addCell(new jxl.write.Label(j++,0,"现工作地详细地址",wcf));
		                ws.addCell(new jxl.write.Label(j++,0,"是否安排餐饮",wcf));
		                ws.addCell(new jxl.write.Label(j++,0,"安排餐饮特殊要求",wcf));
		                ws.addCell(new jxl.write.Label(j++,0,"是否需要安排住宿",wcf));
		                ws.addCell(new jxl.write.Label(j++,0,"房间数 ",wcf));
		                ws.addCell(new jxl.write.Label(j++,0,"房间类型",wcf));
		                ws.addCell(new jxl.write.Label(j++,0,"安排住宿其他要求",wcf));
		               	ws.addCell(new jxl.write.Label(j++,0,"是否需要安排接送",wcf));
		                ws.addCell(new jxl.write.Label(j++,0,"交通工具",wcf));
		                ws.addCell(new jxl.write.Label(j++,0,"去程车次",wcf));
		                ws.addCell(new jxl.write.Label(j++,0,"去程到达日期",wcf));
		                ws.addCell(new jxl.write.Label(j++,0,"去程到达时间",wcf));
		                ws.addCell(new jxl.write.Label(j++,0,"返程车次",wcf));
		                ws.addCell(new jxl.write.Label(j++,0,"返程到达日期",wcf));
		                ws.addCell(new jxl.write.Label(j++,0,"返程到达时间",wcf));
		                ws.addCell(new jxl.write.Label(j++,0,"是否到会",wcf));
		       
	                       ws.addCell(new jxl.write.Label(b++,i + 1,"000001"));
	                       ws.addCell(new jxl.write.Label(b++,i + 1,"ceshi"));
	                       ws.addCell(new jxl.write.Label(b++,i + 1,"13888888888")); 
	                       ws.addCell(new jxl.write.Label(b++,i + 1,"北京"));
	                       ws.addCell(new jxl.write.Label(b++,i + 1,"海淀"));
	                       ws.addCell(new jxl.write.Label(b++,i + 1,"上地"));
	                       ws.addCell(new jxl.write.Label(b++,i + 1,"是"));
	                       ws.addCell(new jxl.write.Label(b++,i + 1,"如果没有不填写"));
	                       ws.addCell(new jxl.write.Label(b++,i + 1,"是"));
	                       ws.addCell(new jxl.write.Label(b++,i + 1,"1"));
	                       ws.addCell(new jxl.write.Label(b++,i + 1,"单人间大床或标准间合住"));
	                       ws.addCell(new jxl.write.Label(b++,i + 1,"如果没有，不填写"));
	                       ws.addCell(new jxl.write.Label(b++,i + 1,"是"));
	                       ws.addCell(new jxl.write.Label(b++,i + 1,"火车"));
	                       ws.addCell(new jxl.write.Label(b++,i + 1,"12"));
	                       ws.addCell(new jxl.write.Label(b++,i + 1,"2011-01-01"));
	                       ws.addCell(new jxl.write.Label(b++,i + 1,"12点"));
	                       ws.addCell(new jxl.write.Label(b++,i + 1,"11"));
	                       ws.addCell(new jxl.write.Label(b++,i + 1,"2011-01-03"));
	                       ws.addCell(new jxl.write.Label(b++,i + 1,"1点"));
	                       ws.addCell(new jxl.write.Label(b++,i + 1,"是"));
	                  
	                    
		                          i++; 
		       
			}else if("WestracEventMemberList".equals(act))
			{

				sql = MT.dec(sql);
				//威斯特报名会员导出
				
				ws.setColumnView(a++, 20); // 设置列的宽度
				ws.setColumnView(a++, 20); // 设置列的宽度
				ws.setColumnView(a++, 20); // 设置列的宽度
				ws.setColumnView(a++, 20); // 设置列的宽度
				ws.setColumnView(a++, 20); // 设置列的宽度
				ws.setColumnView(a++, 20); // 设置列的宽度
				ws.setColumnView(a++, 20); // 设置列的宽度
				ws.setColumnView(a++, 20); // 设置列的宽度
				ws.setColumnView(a++, 20); // 设置列的宽度
				ws.setColumnView(a++, 20); // 设置列的宽度
				ws.setColumnView(a++, 20); // 设置列的宽度
				ws.setColumnView(a++, 20); // 设置列的宽度
				ws.setColumnView(a++, 20); // 设置列的宽度
				ws.setColumnView(a++, 20); // 设置列的宽度
				ws.setColumnView(a++, 20); // 设置列的宽度
				ws.setColumnView(a++, 20); // 设置列的宽度
				ws.setColumnView(a++, 20); // 设置列的宽度
				ws.setColumnView(a++, 20); // 设置列的宽度
				ws.setColumnView(a++, 20); // 设置列的宽度
				ws.setColumnView(a++, 20); // 设置列的宽度
				ws.setColumnView(a++, 20); // 设置列的宽度
				

                ws.addCell(new jxl.write.Label(j++,0,"会员编号",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"用户名 ",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"姓名 ",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"手机号",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"现工作地",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"是否有随从人员",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"人数",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"是否安排餐饮",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"特殊要求",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"是否需要安排住宿",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"房间数",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"房间类型",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"其他要求",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"是否需要安排接送",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"交通工具",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"去程 车次",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"到达日期",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"到达时间",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"返程 车次",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"到达日期",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"到达时间",wcf));
              
              
                
                
                
                
                if(teasession.getParameter("checkeid")!=null && teasession.getParameter("checkeid").length()>0)
                {
                	String tal []  = teasession.getParameterValues("checkeid");
                	
                	for(int i2 =0;i2<tal.length;i2++)
                	{
                		int erid =Integer.parseInt(tal[i2]);
                		Eventregistration erobj = Eventregistration.find(erid);
                		int cc =0;
                	    Profile pobj = Profile.find(erobj.getMember());
    
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getCode()));
                		
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,erobj.getMember()));
                		  
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getFirstName(teasession._nLanguage)));
                		  
                		  
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getMobile()));
                		  
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,Card.find(Integer.parseInt(erobj.getCity())).toString2()+erobj.getAddress()));
                		  
                		  
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,erobj.getAcco()==0?"是":"否"));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,String.valueOf(erobj.getAccoquantity())));
                		  
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,erobj.getCatering()==0?"是":"否"));
                		  
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,erobj.getSpecials()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,erobj.getStay()==0?"是":"否"));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,String.valueOf(erobj.getRoomnumber())));
                		  
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,erobj.ACCOROOM_TYPE[erobj.getAccoroom()]));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,erobj.getAccoother()));
                		  
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,erobj.getShuttle()==0?"是":"否"));
                		  
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,erobj.TRANSPORT_TYPE[erobj.getTransport()]));
                		  
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,erobj.getGotrainnumber()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,erobj.getReachtime()!=null?Entity.sdf.format(erobj.getReachtime()):""));
                		  
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,erobj.getReachtimedate()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,erobj.getReturnrainnumber()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,erobj.getReturntime()!=null?Entity.sdf.format(erobj.getReturntime()):""));
                		  
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,erobj.getReturntimedate()));
                		  
                		 
                		  
                          i++;
                          
                		
                	}
                	
                	
                	
                	
                }else//sql 语句导出
                { 
                	
                	
                	java.util.Enumeration eu = Eventregistration.find(teasession._strCommunity,sql,0,Integer.MAX_VALUE);
                	
                	while(eu.hasMoreElements())
                	{
                		
                	 	int eid = ((Integer)eu.nextElement()).intValue();
                	 	Eventregistration erobj = Eventregistration.find(eid);
                	 	Profile pobj = Profile.find(erobj.getMember());
                   	 
                		int cc =0;
                	   
                		ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getCode()));
                		
              		  ws.addCell(new jxl.write.Label(cc++,i + 1,erobj.getMember()));
              		  
              		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getFirstName(teasession._nLanguage)));
              		  
              		  
              		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getMobile()));
              		  
              		  ws.addCell(new jxl.write.Label(cc++,i + 1,Card.find(Integer.parseInt(erobj.getCity())).toString2()+erobj.getAddress()));
              		  
              		  
              		  ws.addCell(new jxl.write.Label(cc++,i + 1,erobj.getAcco()==0?"是":"否"));
              		  ws.addCell(new jxl.write.Label(cc++,i + 1,String.valueOf(erobj.getAccoquantity())));
              		  
              		  ws.addCell(new jxl.write.Label(cc++,i + 1,erobj.getCatering()==0?"是":"否"));
              		  
              		  ws.addCell(new jxl.write.Label(cc++,i + 1,erobj.getSpecials()));
              		  ws.addCell(new jxl.write.Label(cc++,i + 1,erobj.getStay()==0?"是":"否"));
              		  ws.addCell(new jxl.write.Label(cc++,i + 1,String.valueOf(erobj.getRoomnumber())));
              		  
              		  ws.addCell(new jxl.write.Label(cc++,i + 1,erobj.ACCOROOM_TYPE[erobj.getAccoroom()]));
              		  ws.addCell(new jxl.write.Label(cc++,i + 1,erobj.getAccoother()));
              		  
              		  ws.addCell(new jxl.write.Label(cc++,i + 1,erobj.getShuttle()==0?"是":"否"));
              		  
              		  ws.addCell(new jxl.write.Label(cc++,i + 1,erobj.TRANSPORT_TYPE[erobj.getTransport()]));
              		  
              		  ws.addCell(new jxl.write.Label(cc++,i + 1,erobj.getGotrainnumber()));
              		  ws.addCell(new jxl.write.Label(cc++,i + 1,erobj.getReachtime()!=null?Entity.sdf.format(erobj.getReachtime()):""));
              		  
              		  ws.addCell(new jxl.write.Label(cc++,i + 1,erobj.getReachtimedate()));
              		  ws.addCell(new jxl.write.Label(cc++,i + 1,erobj.getReturnrainnumber()));
              		  ws.addCell(new jxl.write.Label(cc++,i + 1,erobj.getReturntime()!=null?Entity.sdf.format(erobj.getReturntime()):""));
              		  
              		  ws.addCell(new jxl.write.Label(cc++,i + 1,erobj.getReturntimedate()));
            	    	
                		 
                	
                		 


                	    
                        i++;
                		
                	}
                }
                
				
			}else if("Pollresultview".equals(act))
			{
				//导出投票调查

				
				ws.setColumnView(a++, 50); // 设置列的宽度 
				
				ws.setColumnView(a++, 50); // 设置列的宽度 
				ws.setColumnView(a++, 50); // 设置列的宽度 
				ws.setColumnView(a++, 50); // 设置列的宽度 
                ws.addCell(new jxl.write.Label(j++,0,"调查结果统计",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"              ",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"               ",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"               ",wcf)); 
				
				
				Enumeration e=Poll.findByNode(teasession._nNode,teasession._nLanguage,0,200);
				for(int ii=1;e.hasMoreElements();ii++)
				{
				  int pid=((Integer)e.nextElement()).intValue();
				  Poll p=Poll.find(pid);
				  int ptype=p.getType();
				  
				  
	          		int cc =0;
	          	   
	          		ws.addCell(new jxl.write.Label(cc++,i + 1,p.getQuestion()));
	          		
	          		
	          		if(ptype==2||ptype==3)
		          	  {
		          	  
		          	    Iterator it=PollVoteList.find(" AND poll=" + pid + " ORDER BY pollvote",0,2000).iterator();
		          	    while(it.hasNext())
		          	    {
		          	      PollVoteList pvl=(PollVoteList)it.next();
		          	      
		          	      System.out.print(MT.f(PollVote.find(pvl.pollvote).member,"游客") + "：" + MT.f(pvl.answer,"无")+"<br/>");
		          	   
		          	    ws.addCell(new jxl.write.Label(cc++,i + 1,MT.f(PollVote.find(pvl.pollvote).member,"游客") + "：" + MT.f(pvl.answer,"无")));
		          	       
		          	      
		          	    }
		          	    
		          	  }
	          		else
		          	  {
		          	    int sum=DbAdapter.execute("SELECT SUM(sorting) FROM PollChoice WHERE poll=" + pid);
		          	    Enumeration ec=PollChoice.findByPoll(pid,0,200);
		          	    while(ec.hasMoreElements())
		          	    {
		          	      int id=((Integer)ec.nextElement()).intValue();
		          	      PollChoice pc=PollChoice.find(id);
		          	      int hits=pc.getSorting(),perc=hits*100/Math.max(sum,1);  
		          	    
		          
		          		ws.addCell(new jxl.write.Label(cc++,i + 1,pc.getTitle()+"--"+hits+"--"+perc+"%"));
		          	   
		          	   
		          	    
		          	    }  
		          	  }
	          		
	          		
	          		
	          		 
	          		i++;
	          	
			
				}
				
			}else if("WestracClueExcel".equals(act))
			{
				//导出销售线索
				//威斯特俱乐部会员导出
				
				ws.setColumnView(a++, 20); // 设置列的宽度
				ws.setColumnView(a++, 20); // 设置列的宽度
				ws.setColumnView(a++, 20); // 设置列的宽度
				ws.setColumnView(a++, 20); // 设置列的宽度
				ws.setColumnView(a++, 20); // 设置列的宽度
				ws.setColumnView(a++, 20); // 设置列的宽度
				ws.setColumnView(a++, 20); // 设置列的宽度
				ws.setColumnView(a++, 20); // 设置列的宽度
				ws.setColumnView(a++, 20); // 设置列的宽度
				ws.setColumnView(a++, 20); // 设置列的宽度
				ws.setColumnView(a++, 20); // 设置列的宽度
				ws.setColumnView(a++, 20); // 设置列的宽度
				ws.setColumnView(a++, 20); // 设置列的宽度
				ws.setColumnView(a++, 20); // 设置列的宽度
				ws.setColumnView(a++, 20); // 设置列的宽度
				

				    ws.addCell(new jxl.write.Label(j++,0,"所属行业",wcf));
	                ws.addCell(new jxl.write.Label(j++,0,"购买人名称",wcf));
	                ws.addCell(new jxl.write.Label(j++,0,"联系人姓名 ",wcf));
	                ws.addCell(new jxl.write.Label(j++,0,"公司电话 ",wcf));
	                ws.addCell(new jxl.write.Label(j++,0,"移动电话",wcf));
	                ws.addCell(new jxl.write.Label(j++,0,"购买人所在地",wcf));
	                ws.addCell(new jxl.write.Label(j++,0,"预计购买日期",wcf)); 
	                ws.addCell(new jxl.write.Label(j++,0,"提交时间",wcf));
	                ws.addCell(new jxl.write.Label(j++,0,"购买需求简单描述",wcf));
	                ws.addCell(new jxl.write.Label(j++,0,"所属销售员",wcf));
	                ws.addCell(new jxl.write.Label(j++,0,"线索状态",wcf));
	                ws.addCell(new jxl.write.Label(j++,0,"商机状态",wcf));
	                ws.addCell(new jxl.write.Label(j++,0,"负责人",wcf));
	                ws.addCell(new jxl.write.Label(j++,0,"用户类型",wcf));
	                ws.addCell(new jxl.write.Label(j++,0,"用户姓名",wcf));
	                ws.addCell(new jxl.write.Label(j++,0,"用户手机",wcf));
	                
                
                
                
                
                if(teasession.getParameter("checkwcid")!=null && teasession.getParameter("checkwcid").length()>0)
                {
                	String tal []  = teasession.getParameterValues("checkwcid");
                	
                	for(int i2 =0;i2<tal.length;i2++)
                	{
                		int wcid =Integer.parseInt(tal[i2]);
                	   
                		int cc =0;
                	  
                		WestracClue wcobj = WestracClue.find(wcid);
                	   
            	    	String cityname = "";
            	    	if(wcobj.getCity()!=null && wcobj.getCity().length()>0)
            	    	{
            	    		cityname = Card.find(Integer.parseInt(wcobj.getCity())).toString2();
            	    	}
            	    	String membertypename = "非注册用户";
            	    	String belsell ="无";//所属销售员
            	    	if(wcobj.getMember()!=null && wcobj.getMember().length()>0)
            	    	{
            	    		Profile pobj = Profile.find(wcobj.getMember());
            	    		
            	    		if(pobj.getMembertype()==0)
            	    		{
            	    			membertypename = "普通会员";
            	    		}else if(pobj.getMembertype()==1)
            	    		{
            	    			membertypename ="履友";
            	    			belsell = pobj.getBelsell();
            	    		}
            	    	}
                	  
            	    	//导出时候要添加是否导出
            	    	wcobj.setExporttype(1);
            	    	
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,wcobj.INDUSTRYS_TYPE[wcobj.getIndustrys()]));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,wcobj.getClientname()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,wcobj.getContactname()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,wcobj.getPhone()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,wcobj.getClientmobile()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,cityname));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,wcobj.getBuytime()!=null?Entity.sdf.format(wcobj.getBuytime()):""));
                		  
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,Entity.sdf.format(wcobj.getTimes())));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,wcobj.getRemarks()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,belsell));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,wcobj.WCTYPE_TYPE[wcobj.getWctype()]));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,wcobj.WCTYPE_TYPE2[wcobj.getWctype2()]));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,wcobj.getWcmember()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,membertypename));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,wcobj.getWcname()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,wcobj.getMobile()));
                          i++;
                		
                	} 
                }else//sql 语句导出
                { 
                	sql = MT.dec(sql);
                	
                	 java.util.Enumeration e = WestracClue.find(teasession._strCommunity, sql, 0, Integer.MAX_VALUE);
                	while ( e.hasMoreElements()) {
                
                		int wcid = ((Integer)e.nextElement()).intValue();
                		int cc =0; 
                  	  
                		WestracClue wcobj = WestracClue.find(wcid);
                	   
            	    	String cityname = "";
            	    	if(wcobj.getCity()!=null && wcobj.getCity().length()>0)
            	    	{
            	    		cityname = Card.find(Integer.parseInt(wcobj.getCity())).toString2();
            	    	}
            	    	String membertypename = "非注册用户";
            	    	String belsell ="无";//所属销售员
            	    	if(wcobj.getMember()!=null && wcobj.getMember().length()>0)
            	    	{
            	    		Profile pobj = Profile.find(wcobj.getMember());
            	    		
            	    		if(pobj.getMembertype()==0)
            	    		{
            	    			membertypename = "普通会员";
            	    		}else if(pobj.getMembertype()==1)
            	    		{
            	    			membertypename ="履友";
            	    			belsell = pobj.getBelsell();
            	    		}
            	    	}
            	    	wcobj.setExporttype(1);
                	   
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,wcobj.INDUSTRYS_TYPE[wcobj.getIndustrys()]));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,wcobj.getClientname()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,wcobj.getContactname()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,wcobj.getPhone()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,wcobj.getClientmobile()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,cityname));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,wcobj.getBuytime()!=null?Entity.sdf.format(wcobj.getBuytime()):""));
                		  
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,Entity.sdf.format(wcobj.getTimes())));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,wcobj.getRemarks()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,belsell));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,wcobj.WCTYPE_TYPE[wcobj.getWctype()]));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,wcobj.WCTYPE_TYPE2[wcobj.getWctype2()]));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,wcobj.getWcmember()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,membertypename));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,wcobj.getWcname()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,wcobj.getMobile()));
                		 
                	    
                        i++;
                		
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
