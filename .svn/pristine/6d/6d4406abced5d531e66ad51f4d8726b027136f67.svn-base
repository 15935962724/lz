package tea.ui.node.type.photography;


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
import tea.entity.node.Talkback;
import tea.entity.node.TalkbackReply;
import tea.entity.photography.Photography;
import tea.entity.util.Card;
import tea.entity.women.Contributions;
import tea.resource.Common;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;



public class EditExcel extends TeaServlet
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
            

			int i = 0,j=0,a=0,b=0;
			if("TalkbackList".equals(act))//导出评论 
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

				    
               // ws.addCell(new jxl.write.Label(j++,0,"主题",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"作品名",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"请求人员",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"请求时间",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"处理人员",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"处理时间",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"状态",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"回复",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"评论内容",wcf));
                
                //选中导出
        
                if(teasession.getParameter("talkback")!=null && teasession.getParameter("talkback").length()>0)
                {
                	String tal []  = teasession.getParameterValues("talkback");
                	
                	for(int i2 =0;i2<tal.length;i2++)
                	{
                		int tkid = Integer.parseInt(tal[i2]);
                		
                		Talkback obj = Talkback.find(tkid);
                		int nodeid = obj.getNode();
                		String member = obj.getCreator().toString();
                		tea.entity.member.Profile pobj = tea.entity.member.Profile.find(member);
            	    	String pname = pobj.getLastName(teasession._nLanguage)+pobj.getFirstName(teasession._nLanguage);
            	    	if(pname!=null)
            	    	{
            	    		member = pname;
            	    	}
            	    	
                		if(member!=null && member.length()==32)
                		{
                			member="游客";
                		}
                		String t = "";
                		if(obj.getAudittime()!=null)
                		{
                			t = obj.sdf2.format(obj.getAudittime());
                		}
                		  //ws.addCell(new jxl.write.Label(0,i + 1,obj.getSubject(teasession._nLanguage)));
                          ws.addCell(new jxl.write.Label(0,i + 1,Node.find(nodeid).getSubject(teasession._nLanguage)));
                          ws.addCell(new jxl.write.Label(1,i + 1,member));
                          ws.addCell(new jxl.write.Label(2,i + 1,obj.sdf2.format(obj.getTime()))); 
                          ws.addCell(new jxl.write.Label(3,i + 1,obj.getAuditmember()));
                          ws.addCell(new jxl.write.Label(4,i + 1,t));
                          ws.addCell(new jxl.write.Label(5,i + 1,obj.HIDDEN_TYPE[obj.getHidden()]));
                          ws.addCell(new jxl.write.Label(6,i + 1,String.valueOf(TalkbackReply.countByTalkback(tkid))));
                          ws.addCell(new jxl.write.Label(7,i + 1,obj.getContent(teasession._nLanguage)));
                           
                          i++;
                		
                	}
                }else//sql 语句导出
                {
                	Enumeration e = Talkback.find(sql.toString(), 0, Integer.MAX_VALUE);
                	while ( e.hasMoreElements()) {
                		
                		int tkid = ((Integer) e.nextElement()).intValue();
                		
                		Talkback obj = Talkback.find(tkid);
                		int nodeid = obj.getNode();
                		String t = "";
                		if(obj.getAudittime()!=null)
                		{
                			t = obj.sdf2.format(obj.getAudittime());
                		}
                		String member = obj.getCreator().toString();
                		tea.entity.member.Profile pobj = tea.entity.member.Profile.find(member);
            	    	String pname = pobj.getLastName(teasession._nLanguage)+pobj.getFirstName(teasession._nLanguage);
            	    	if(pname!=null)
            	    	{
            	    		member = pname;
            	    	}
            	    	
                		if(member!=null && member.length()==32)
                		{
                			member="游客";
                		}
                		 // ws.addCell(new jxl.write.Label(0,i + 1,obj.getSubject(teasession._nLanguage)));
                          ws.addCell(new jxl.write.Label(0,i + 1,Node.find(nodeid).getSubject(teasession._nLanguage)));
                          ws.addCell(new jxl.write.Label(1,i + 1,member));
                          ws.addCell(new jxl.write.Label(2,i + 1,obj.sdf2.format(obj.getTime())));
                          ws.addCell(new jxl.write.Label(3,i + 1,obj.getAuditmember()));
                          ws.addCell(new jxl.write.Label(4,i + 1,t));
                          ws.addCell(new jxl.write.Label(5,i + 1,obj.HIDDEN_TYPE[obj.getHidden()]));
                          ws.addCell(new jxl.write.Label(6,i + 1,String.valueOf(TalkbackReply.countByTalkback(tkid))));
                          ws.addCell(new jxl.write.Label(7,i + 1,obj.getContent(teasession._nLanguage)));
                           
                          i++;
                		
                	}
                }
                
              
                
                

			}else if("TalkbackReply".equals(act))//导出回复
			{

				ws.setColumnView(0, 20); // 设置列的宽度
				ws.setColumnView(1, 20); // 设置列的宽度
				ws.setColumnView(2, 20); // 设置列的宽度
				ws.setColumnView(3, 20); // 设置列的宽度
				ws.setColumnView(4, 20); // 设置列的宽度
				ws.setColumnView(5, 20); // 设置列的宽度


                ws.addCell(new jxl.write.Label(j++,0,"回复内容",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"回复人员 ",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"回复时间 ",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"处理人员",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"处理时间",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"状态",wcf));
                
                //选中导出
        
                if(teasession.getParameter("tr_check")!=null && teasession.getParameter("tr_check").length()>0)
                {
                	String tal []  = teasession.getParameterValues("tr_check");
                	
                	for(int i2 =0;i2<tal.length;i2++)
                	{
                		int tkid = Integer.parseInt(tal[i]);
                		
                		TalkbackReply obj = TalkbackReply.find(tkid);
    
                		String member = obj.getMember();
                		tea.entity.member.Profile pobj = tea.entity.member.Profile.find(member);
            	    	String pname = pobj.getLastName(teasession._nLanguage)+pobj.getFirstName(teasession._nLanguage);
            	    	if(pname!=null)
            	    	{
            	    		member = pname;
            	    	}
            	    	
                		if(member!=null && member.length()==32)
                		{
                			member="游客";
                		}
                		String t = "";
                		if(obj.getAudittime()!=null)
                		{
                			t = obj.sdf2.format(obj.getAudittime());
                		}
                		  ws.addCell(new jxl.write.Label(0,i + 1,obj.getText()));
                          ws.addCell(new jxl.write.Label(1,i + 1,member));
                          ws.addCell(new jxl.write.Label(2,i + 1,obj.sdf2.format(obj.getTime()))); 
                          ws.addCell(new jxl.write.Label(3,i + 1,obj.getAuditmember()));
                          ws.addCell(new jxl.write.Label(4,i + 1,t));
                          ws.addCell(new jxl.write.Label(5,i + 1,obj.HIDDEN_TYPE[obj.getHidden()]));
     
                           
                          i++;
                		
                	}
                }else//sql 语句导出
                { 
                	Enumeration e = TalkbackReply.find(sql.toString(), 0, Integer.MAX_VALUE);
                	while ( e.hasMoreElements()) {
                		
                		int tkid = ((Integer) e.nextElement()).intValue();
                		
                		TalkbackReply obj = TalkbackReply.find(tkid);
                		String member = obj.getMember();
                		tea.entity.member.Profile pobj = tea.entity.member.Profile.find(member);
            	    	String pname = pobj.getLastName(teasession._nLanguage)+pobj.getFirstName(teasession._nLanguage);
            	    	if(pname!=null)
            	    	{
            	    		member = pname;
            	    	}
            	    	
                		if(member!=null && member.length()==32)
                		{
                			member="游客";
                		}
                		String t = "";
                		if(obj.getAudittime()!=null)
                		{
                			t = obj.sdf2.format(obj.getAudittime());
                		}
                		  ws.addCell(new jxl.write.Label(0,i + 1,obj.getText()));
                          ws.addCell(new jxl.write.Label(1,i + 1,member));
                          ws.addCell(new jxl.write.Label(2,i + 1,obj.sdf2.format(obj.getTime()))); 
                          ws.addCell(new jxl.write.Label(3,i + 1,obj.getAuditmember()));
                          ws.addCell(new jxl.write.Label(4,i + 1,t));
                          ws.addCell(new jxl.write.Label(5,i + 1,obj.HIDDEN_TYPE[obj.getHidden()]));
                           
                          i++;
                		
                	}
                }
			}else if("Photography".equals(act))
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
		

                ws.addCell(new jxl.write.Label(j++,0,"作品名称",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"作者 ",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"相机品牌 ",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"分类",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"描述",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"上传作品",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"上传时间",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"处理人员",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"处理时间",wcf));
                
                if("votenumber".equals(teasession.getParameter("voteact")))
                { 
                	ws.addCell(new jxl.write.Label(j++,0,"票数",wcf));
                }else
                {
                	ws.addCell(new jxl.write.Label(j++,0,"审核状态",wcf));
                }
                
                
                
                
                //选中导出
        
                if(teasession.getParameter("nid")!=null && teasession.getParameter("nid").length()>0)
                {
                	String tal []  = teasession.getParameterValues("nid");
                	
                	for(int i2 =0;i2<tal.length;i2++)
                	{
                		int nid = Integer.parseInt(tal[i]);
                		Node nobj = Node.find(nid);
                	    Photography pobj = Photography.find(nid);
    
                		
                		String t = "";
                		
                		if(pobj.getAudittime(teasession._nLanguage)!=null)
                		{
                			t = pobj.sdf2.format(pobj.getAudittime(teasession._nLanguage));
                		}
                		
                		
                		String cname = pobj.getCamerabrand(teasession._nLanguage);
                		if(pobj.getCamerabrandtype()!=13)
                		{
                			cname = pobj.CAMERABRAND_TYPE[pobj.getCamerabrandtype()]; 
                		}
                		  ws.addCell(new jxl.write.Label(0,i + 1,nobj.getSubject(teasession._nLanguage)));
                          ws.addCell(new jxl.write.Label(1,i + 1,pobj.getByname(teasession._nLanguage)));
                          ws.addCell(new jxl.write.Label(2,i + 1,cname)); 
                          ws.addCell(new jxl.write.Label(3,i + 1,Node.find(pobj.getCategories()).getSubject(teasession._nLanguage)));
                          ws.addCell(new jxl.write.Label(4,i + 1,nobj.getText(teasession._nLanguage)));
                          ws.addCell(new jxl.write.Label(5,i + 1,pobj.getPicpath(teasession._nLanguage)));
                         
                          ws.addCell(new jxl.write.Label(6,i + 1,nobj.sdf2.format(nobj.getTime())));
                          ws.addCell(new jxl.write.Label(7,i + 1,pobj.getAuditmember(teasession._nLanguage)));
                          ws.addCell(new jxl.write.Label(8,i + 1,t));
                          if("votenumber".equals(teasession.getParameter("voteact")))
                          {
                        	  ws.addCell(new jxl.write.Label(9,i + 1,String.valueOf(pobj.getVotenumber())));
                          }else
                          {
                        	  ws.addCell(new jxl.write.Label(9,i + 1,pobj.AUDIT_TYPE[nobj.getAudit()]));
                          }
                          i++;
                		
                	}
                }else//sql 语句导出
                { 
                	String o = teasession.getParameter("o");    
                	Enumeration e =Node.findPhotography_np(teasession._strCommunity,o,sql.toString(),0,Integer.MAX_VALUE); 
                	while ( e.hasMoreElements()) {
                		
                		int nid = ((Integer) e.nextElement()).intValue();
                		Node nobj = Node.find(nid);
                	    Photography pobj = Photography.find(nid);
                	    String t = "";
                		
                		if(pobj.getAudittime(teasession._nLanguage)!=null)
                		{
                			t = pobj.sdf2.format(pobj.getAudittime(teasession._nLanguage));
                		}
                		String cname = pobj.getCamerabrand(teasession._nLanguage);
                		if(pobj.getCamerabrandtype()!=13)
                		{
                			cname = pobj.CAMERABRAND_TYPE[pobj.getCamerabrandtype()]; 
                		}
                		 ws.addCell(new jxl.write.Label(0,i + 1,nobj.getSubject(teasession._nLanguage)));
                         ws.addCell(new jxl.write.Label(1,i + 1,pobj.getByname(teasession._nLanguage)));
                         ws.addCell(new jxl.write.Label(2,i + 1,cname));  
                         ws.addCell(new jxl.write.Label(3,i + 1,Node.find(pobj.getCategories()).getSubject(teasession._nLanguage)));
                         ws.addCell(new jxl.write.Label(4,i + 1,nobj.getText(teasession._nLanguage)));
                         ws.addCell(new jxl.write.Label(5,i + 1,pobj.getPicpath(teasession._nLanguage)));
                     
                         ws.addCell(new jxl.write.Label(6,i + 1,nobj.sdf2.format(nobj.getTime())));
                         ws.addCell(new jxl.write.Label(7,i + 1,pobj.getAuditmember(teasession._nLanguage)));
                         ws.addCell(new jxl.write.Label(8,i + 1,t));
                         if("votenumber".equals(teasession.getParameter("voteact")))
                         {
                       	  ws.addCell(new jxl.write.Label(9,i + 1,String.valueOf(pobj.getVotenumber())));
                         }else
                         {
                       	  ws.addCell(new jxl.write.Label(9,i + 1,pobj.AUDIT_TYPE[nobj.getAudit()]));
                         }
                           
                          i++;
                		
                	}
                }
			}else if("MemberList".equals(act))//摄影会员导出字段
			{

				ws.setColumnView(0, 20); // 设置列的宽度
				ws.setColumnView(1, 20); // 设置列的宽度
				ws.setColumnView(2, 20); // 设置列的宽度
				ws.setColumnView(3, 20); // 设置列的宽度
				ws.setColumnView(4, 20); // 设置列的宽度
				ws.setColumnView(5, 20); // 设置列的宽度
				ws.setColumnView(6, 20); // 设置列的宽度

 
		

                ws.addCell(new jxl.write.Label(j++,0,"会员ID",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"昵称 ",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"联系电话 ",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"性别",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"国籍",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"审核状态",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"审核时间",wcf));

                //选中导出
        
                if(teasession.getParameter("memberorder")!=null && teasession.getParameter("memberorder").length()>0)
                {
                	String tal []  = teasession.getParameterValues("memberorder");
                	
                	for(int i2 =0;i2<tal.length;i2++)
                	{
                		String memberorder =tal[i2];
                	    MemberOrder  moobj = MemberOrder.find(memberorder);
                	    Profile pobj = Profile.find(moobj.getMember());
                	    String s ="女";
                	    if(!pobj.isSex())
                	    {
                	    	s = "男";
                	    }
    
                		  ws.addCell(new jxl.write.Label(0,i + 1,moobj.getMember()));
                          ws.addCell(new jxl.write.Label(1,i + 1,pobj.getLastName(teasession._nLanguage)+pobj.getFirstName(teasession._nLanguage)));
                          ws.addCell(new jxl.write.Label(2,i + 1,pobj.getTelephone(teasession._nLanguage))); 
                          ws.addCell(new jxl.write.Label(3,i + 1,s));
                          ws.addCell(new jxl.write.Label(4,i + 1,new tea.htmlx.CountrySelection(teasession._nLanguage,pobj.getCountry(teasession._nLanguage)).toString()));
                          ws.addCell(new jxl.write.Label(5,i + 1,Photography.AUDIT_TYPE[moobj.getVerifg()]));
                         
                          ws.addCell(new jxl.write.Label(6,i + 1,Entity.sdf2.format(moobj.getTimes())));
                          i++;
                		
                	}
                }else//sql 语句导出
                { 
                	
                	Enumeration e =MemberOrder.findMP(teasession._strCommunity,sql.toString(),0,Integer.MAX_VALUE); 
                	while ( e.hasMoreElements()) {
                		String memberorder =((String)e.nextElement());
                	    MemberOrder  moobj = MemberOrder.find(memberorder);
                	    Profile pobj = Profile.find(moobj.getMember());
                	    
                	    String s ="女";
                	    if(!pobj.isSex())
                	    {
                	    	s = "男";
                	    }
    
                		  ws.addCell(new jxl.write.Label(0,i + 1,moobj.getMember()));
                          ws.addCell(new jxl.write.Label(1,i + 1,pobj.getLastName(teasession._nLanguage)+pobj.getFirstName(teasession._nLanguage)));
                          ws.addCell(new jxl.write.Label(2,i + 1,pobj.getTelephone(teasession._nLanguage))); 
                          ws.addCell(new jxl.write.Label(3,i + 1,s));
                          ws.addCell(new jxl.write.Label(4,i + 1,new tea.htmlx.CountrySelection(teasession._nLanguage,pobj.getCountry(teasession._nLanguage)).toString()));
                          ws.addCell(new jxl.write.Label(5,i + 1,Photography.AUDIT_TYPE[moobj.getVerifg()]));
                         
                          ws.addCell(new jxl.write.Label(6,i + 1,Entity.sdf2.format(moobj.getTimes())));
                          i++; 
                		
                	}
                }
			}else if("ClssnMember".equals(act))//劳动报会员导出
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
				ws.setColumnView(11, 20); // 设置列的宽度
				ws.setColumnView(12, 20); // 设置列的宽度
				ws.setColumnView(13, 20); // 设置列的宽度
				ws.setColumnView(14, 20); // 设置列的宽度
				
				ws.setColumnView(15, 20); // 设置列的宽度
				
				ws.setColumnView(16, 20); // 设置列的宽度
				ws.setColumnView(17, 20); // 设置列的宽度
				ws.setColumnView(18, 20); // 设置列的宽度
				ws.setColumnView(19, 20); // 设置列的宽度
				ws.setColumnView(20, 20); // 设置列的宽度
				ws.setColumnView(21, 20); // 设置列的宽度

                ws.addCell(new jxl.write.Label(j++,0,"会员ID",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"邮箱地址 ",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"手机号码 ",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"姓名 ",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"性别",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"出生日期 ",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"通信地址",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"邮政编码",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"省份",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"单位",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"职务",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"联系电话",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"邮箱验证",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"审核状态",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"审核时间",wcf));
                
                ws.addCell(new jxl.write.Label(j++,0,"阅读有效期",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"兑换积分",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"汇款金额",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"发票备注",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"邮寄状态",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"注册时间",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"汇款方式",wcf));
                

                //选中导出
        
                if(teasession.getParameter("memberorder")!=null && teasession.getParameter("memberorder").length()>0)
                {
                	String tal []  = teasession.getParameterValues("memberorder");
                	
                	for(int i2 =0;i2<tal.length;i2++)
                	{
                		String memberorder =tal[i2];
                	    MemberOrder  moobj = MemberOrder.find(memberorder);
                	    Profile pobj = Profile.find(moobj.getMember());
                	    String s ="女";
                	    if(!pobj.isSex())
                	    {
                	    	s = "男";
                	    }
                	    String v ="未通过";
                	    if(Profile.findValid(moobj.getMember())==1)
                  		{
                  			v="已通过";
                  		}
                	    //出生日期
                	    String d ="";
                	    if(pobj.getBirth()!=null)
                	    {
                	    	d = Entity.sdf.format(pobj.getBirth());
                	    }
                	    String cname="";
                	    if(pobj.getCity(teasession._nLanguage)!=null && pobj.getCity(teasession._nLanguage).length()>0)
                	    {
                	    	tea.entity.util.Card cobj = tea.entity.util.Card.find(Integer.parseInt(pobj.getCity(teasession._nLanguage)));
                	    	cname = cobj.toString();
                	    } 
                	    
                	    //审核时间
                	    String vt = "";
                	    if(moobj.getVerifgtime()!=null){
                	    	vt = Entity.sdf2.format(moobj.getVerifgtime());
                	    }
                	    //阅读有效期
                	    String bt = "";
                	    if(moobj.getBecometime()!=null){
                	    	bt = Entity.sdf2.format(moobj.getBecometime());
                	    }
                		  ws.addCell(new jxl.write.Label(0,i + 1,moobj.getMember()));
                		  ws.addCell(new jxl.write.Label(1,i + 1,pobj.getEmail()));
                		  ws.addCell(new jxl.write.Label(2,i + 1,pobj.getMobile()));
                		  ws.addCell(new jxl.write.Label(3,i + 1,pobj.getFirstName(teasession._nLanguage)));
                		  ws.addCell(new jxl.write.Label(4,i + 1,s));
                		  ws.addCell(new jxl.write.Label(5,i + 1,d));
                		  ws.addCell(new jxl.write.Label(6,i + 1,pobj.getAddress(teasession._nLanguage)));
                		  ws.addCell(new jxl.write.Label(7,i + 1,pobj.getZip(teasession._nLanguage)));
                		  
                		  ws.addCell(new jxl.write.Label(8,i + 1,cname));
                		  
                	
                		  ws.addCell(new jxl.write.Label(9,i + 1,pobj.getOrganization(teasession._nLanguage)));
                		  ws.addCell(new jxl.write.Label(10,i + 1,pobj.getTitle(teasession._nLanguage)));
                		  ws.addCell(new jxl.write.Label(11,i + 1,pobj.getTelephone(teasession._nLanguage)));
                		  ws.addCell(new jxl.write.Label(12,i + 1,v));
                	      ws.addCell(new jxl.write.Label(13,i + 1,Photography.AUDIT_TYPE[moobj.getVerifg()]));
                          ws.addCell(new jxl.write.Label(14,i + 1,vt));
                          
                          ws.addCell(new jxl.write.Label(15,i + 1,bt));
                          ws.addCell(new jxl.write.Label(16,i + 1,String.valueOf(moobj.getPeriod())));
                          ws.addCell(new jxl.write.Label(17,i + 1,String.valueOf(moobj.getRemittance())));
                          ws.addCell(new jxl.write.Label(18,i + 1,moobj.getInvoiceremarks())); 
                          ws.addCell(new jxl.write.Label(19,i + 1,moobj.INVOICE_TYPE[moobj.getInvoicetype()]));
                          
                          ws.addCell(new jxl.write.Label(20,i + 1,Entity.sdf2.format(moobj.getTimes())));
                          ws.addCell(new jxl.write.Label(21,i + 1,MemberOrder.REM_TYPE[moobj.getRemtype()]));
                          
                          i++;
                		
                	}
                }else//sql 语句导出
                { 
                	
                	sql = MT.dec(sql);
                	Enumeration e =MemberOrder.findMP(teasession._strCommunity,sql,0,Integer.MAX_VALUE); 
          
                	while ( e.hasMoreElements()) {
                		String memberorder =((String)e.nextElement()); 
                	    MemberOrder  moobj = MemberOrder.find(memberorder);
                	    Profile pobj = Profile.find(moobj.getMember());
                	    
                	    String s ="女";
                	    if(!pobj.isSex())
                	    {
                	    	s = "男";
                	    }
                	    String v ="未通过";
                	    if(Profile.findValid(moobj.getMember())==1)
                  		{
                  			v="已通过";
                  		}
                	    String d ="";
                	    if(pobj.getBirth()!=null)
                	    {
                	    	d = Entity.sdf.format(pobj.getBirth());
                	    }
                	    String cname="";
                	    if(pobj.getCity(teasession._nLanguage)!=null && pobj.getCity(teasession._nLanguage).length()>0)
                	    {
                	    	tea.entity.util.Card cobj = tea.entity.util.Card.find(Integer.parseInt(pobj.getCity(teasession._nLanguage)));
                	    	cname = cobj.toString();
                	    } 
                	    
                	    //审核时间
                	    String vt = "";
                	    if(moobj.getVerifgtime()!=null){
                	    	vt = Entity.sdf2.format(moobj.getVerifgtime());
                	    }
                	    //阅读有效期
                	    String bt = "";
                	    if(moobj.getBecometime()!=null){
                	    	bt = Entity.sdf2.format(moobj.getBecometime());
                	    }
                		  ws.addCell(new jxl.write.Label(0,i + 1,moobj.getMember()));
                		  ws.addCell(new jxl.write.Label(1,i + 1,pobj.getEmail()));
                		  ws.addCell(new jxl.write.Label(2,i + 1,pobj.getMobile()));
                		  ws.addCell(new jxl.write.Label(3,i + 1,pobj.getFirstName(teasession._nLanguage)));
                		  ws.addCell(new jxl.write.Label(4,i + 1,s));
                		  ws.addCell(new jxl.write.Label(5,i + 1,d));
                		  ws.addCell(new jxl.write.Label(6,i + 1,pobj.getAddress(teasession._nLanguage)));
                		  ws.addCell(new jxl.write.Label(7,i + 1,pobj.getZip(teasession._nLanguage)));
                		  
                		  ws.addCell(new jxl.write.Label(8,i + 1,cname));
                		  
                	
                		  ws.addCell(new jxl.write.Label(9,i + 1,pobj.getOrganization(teasession._nLanguage)));
                		  ws.addCell(new jxl.write.Label(10,i + 1,pobj.getTitle(teasession._nLanguage)));
                		  ws.addCell(new jxl.write.Label(11,i + 1,pobj.getTelephone(teasession._nLanguage)));
                		  ws.addCell(new jxl.write.Label(12,i + 1,v));
                	      ws.addCell(new jxl.write.Label(13,i + 1,Photography.AUDIT_TYPE[moobj.getVerifg()]));
                	      ws.addCell(new jxl.write.Label(14,i + 1,vt));
                          
                          ws.addCell(new jxl.write.Label(15,i + 1,bt));
                          ws.addCell(new jxl.write.Label(16,i + 1,String.valueOf(moobj.getPeriod())));
                          ws.addCell(new jxl.write.Label(17,i + 1,String.valueOf(moobj.getRemittance())));
                          ws.addCell(new jxl.write.Label(18,i + 1,moobj.getInvoiceremarks())); 
                          ws.addCell(new jxl.write.Label(19,i + 1,moobj.INVOICE_TYPE[moobj.getInvoicetype()]));
                          
                          ws.addCell(new jxl.write.Label(20,i + 1,Entity.sdf2.format(moobj.getTimes())));
                          ws.addCell(new jxl.write.Label(21,i + 1,MemberOrder.REM_TYPE[moobj.getRemtype()]));
                        i++;
                		
                	}
                }
			}else if("WomenMessageBoardManage".equals(act))//英文网 留言导出
			{
				ws.setColumnView(0, 20); // 设置列的宽度
				ws.setColumnView(1, 20); // 设置列的宽度
				ws.setColumnView(2, 20); // 设置列的宽度
				ws.setColumnView(3, 20); // 设置列的宽度
				ws.setColumnView(4, 20); // 设置列的宽度
				ws.setColumnView(5, 20); // 设置列的宽度
			
				

                ws.addCell(new jxl.write.Label(j++,0,"留言人",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"国家/地区 ",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"E-Mail",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"回复次数",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"发表时间",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"留言内容 ",wcf));
                

                //选中导出
        
                if(teasession.getParameter("cb")!=null && teasession.getParameter("cb").length()>0)
                {
                	String cb []  = teasession.getParameterValues("cb");
                	
                	for(int i2 =0;i2<cb.length;i2++)
                	{
                		 int id =Integer.parseInt(cb[i2]);
                		 Node n=Node.find(id);
                		  MessageBoard obj = MessageBoard.find(id,teasession._nLanguage);
                		  int reply_count=MessageBoardReply.count(id,teasession._nLanguage);
                		  ws.addCell(new jxl.write.Label(0,i + 1,obj.getName()));
                		  ws.addCell(new jxl.write.Label(1,i + 1,n.getSubject(teasession._nLanguage)));
                		  ws.addCell(new jxl.write.Label(2,i + 1,obj.getEmail()));
                		  ws.addCell(new jxl.write.Label(3,i + 1,String.valueOf(reply_count)));
                		  ws.addCell(new jxl.write.Label(4,i + 1,n.getTimeToString()));
                		  ws.addCell(new jxl.write.Label(5,i + 1,n.getText(teasession._nLanguage)));
                          i++;
                		
                	}
                }else
                {
                	Enumeration e=Node.find(sql.toString(),0,Integer.MAX_VALUE);
                	while(e.hasMoreElements())
                	{
                		int id = ((Integer)e.nextElement()).intValue();
                		Node n = Node.find(id);
	               		  MessageBoard obj = MessageBoard.find(id,teasession._nLanguage);
	            		  int reply_count=MessageBoardReply.count(id,teasession._nLanguage);
	            		  ws.addCell(new jxl.write.Label(0,i + 1,obj.getName()));
	            		  ws.addCell(new jxl.write.Label(1,i + 1,n.getSubject(teasession._nLanguage)));
	            		  ws.addCell(new jxl.write.Label(2,i + 1,obj.getEmail()));
	            		  ws.addCell(new jxl.write.Label(3,i + 1,String.valueOf(reply_count)));
	            		  ws.addCell(new jxl.write.Label(4,i + 1,n.getTimeToString()));
	            		  ws.addCell(new jxl.write.Label(5,i + 1,n.getText(teasession._nLanguage)));
                      i++;
                		
                	}
                }
                
				
			}else if("WomenMessageBoardManage2".equals(act))//英文网 留言导出
			{
				ws.setColumnView(0, 20); // 设置列的宽度
				ws.setColumnView(1, 20); // 设置列的宽度
				ws.setColumnView(2, 20); // 设置列的宽度
				ws.setColumnView(3, 20); // 设置列的宽度
				ws.setColumnView(4, 20); // 设置列的宽度
			
				

                ws.addCell(new jxl.write.Label(j++,0,"留言人",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"单位 ",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"职务",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"内容",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"留言时间",wcf));
                

                //选中导出
        
                if(teasession.getParameter("cb")!=null && teasession.getParameter("cb").length()>0)
                {
                	String cb []  = teasession.getParameterValues("cb");
                	
                	for(int i2 =0;i2<cb.length;i2++)
                	{
                		 int id =Integer.parseInt(cb[i2]);
                		 Node n=Node.find(id);
                		  MessageBoard obj = MessageBoard.find(id,teasession._nLanguage);
//                		  int reply_count=MessageBoardReply.count(id,teasession._nLanguage);
                		  ws.addCell(new jxl.write.Label(0,i + 1,n.getSubject(teasession._nLanguage)));
                		  ws.addCell(new jxl.write.Label(1,i + 1,obj.getName()));
                		  ws.addCell(new jxl.write.Label(2,i + 1,n.getDescription(teasession._nLanguage)));
                		  ws.addCell(new jxl.write.Label(3,i + 1,n.getText(teasession._nLanguage)));
                		  ws.addCell(new jxl.write.Label(4,i + 1,Node.sdf2.format(n.getTime())));
                          i++;
                		
                	}
                }else
                {
                	sql=MT.dec(sql);
                	Enumeration e=Node.find(sql.toString(),0,Integer.MAX_VALUE);
                	while(e.hasMoreElements())
                	{
                		int id = ((Integer)e.nextElement()).intValue();
                		Node n = Node.find(id);
	               		  MessageBoard obj = MessageBoard.find(id,teasession._nLanguage);
//	            		  int reply_count=MessageBoardReply.count(id,teasession._nLanguage);
                		  ws.addCell(new jxl.write.Label(0,i + 1,n.getSubject(teasession._nLanguage)));
                		  ws.addCell(new jxl.write.Label(1,i + 1,obj.getName()));
                		  ws.addCell(new jxl.write.Label(2,i + 1,n.getDescription(teasession._nLanguage)));
                		  ws.addCell(new jxl.write.Label(3,i + 1,n.getText(teasession._nLanguage)));
                		  ws.addCell(new jxl.write.Label(4,i + 1,Node.sdf2.format(n.getTime())));
                          i++;
                		
                	}
                }
                
				
			}else if("Contributions".equals(act))//英文网 母亲水窖 捐款订单导出
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
				ws.setColumnView(11, 20); // 设置列的宽度
				ws.setColumnView(12, 20); // 设置列的宽度
				ws.setColumnView(13, 20); // 设置列的宽度
				ws.setColumnView(14, 20); // 设置列的宽度
				ws.setColumnView(15, 20); // 设置列的宽度
				ws.setColumnView(16, 20); // 设置列的宽度
				ws.setColumnView(17, 20); // 设置列的宽度
				ws.setColumnView(18, 20); // 设置列的宽度
				ws.setColumnView(19, 20); // 设置列的宽度
				ws.setColumnView(20, 20); // 设置列的宽度
				ws.setColumnView(21, 20); // 设置列的宽度
				ws.setColumnView(22, 20); // 设置列的宽度
				ws.setColumnView(23, 20); // 设置列的宽度
				ws.setColumnView(24, 20); // 设置列的宽度
				ws.setColumnView(25, 20); // 设置列的宽度
				ws.setColumnView(26, 20); // 设置列的宽度
				ws.setColumnView(27, 20); // 设置列的宽度
				
 
                ws.addCell(new jxl.write.Label(j++,0,"捐赠号",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"类型",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"是否要发票",wcf));
                
                ws.addCell(new jxl.write.Label(j++,0,"支付宝姓名/名称 ",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"手机号",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"发票抬头",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"收件人",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"邮寄地址",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"邮编 ",wcf));
                
                ws.addCell(new jxl.write.Label(j++,0,"汇款单登记日期",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"财务登记日期",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"捐赠方式",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"捐赠金额",wcf));
                
                ws.addCell(new jxl.write.Label(j++,0,"币种",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"捐赠要求",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"指定地点",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"捐赠收据编号",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"收据开具日期",wcf));
                
                
                ws.addCell(new jxl.write.Label(j++,0,"是否邮寄",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"是否退信",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"落实时间",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"落实地点-省-县",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"落实地点-村",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"回馈情况",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"图片名称",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"图片路径",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"备注信息",wcf));
                
                
                
              
                
                ws.addCell(new jxl.write.Label(j++,0,"捐款数额",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"下单时间",wcf));
                
                
                
                
                
                
                //选中导出
                
                if(teasession.getParameter("cidorder")!=null && teasession.getParameter("cidorder").length()>0)
                {
                	String cb []  = teasession.getParameterValues("cidorder");
                	
                	for(int i2 =0;i2<cb.length;i2++)
                	{
                		 String cid = cb[i2];
                         Contributions cobj = Contributions.find(cid);
                		int jj =0;
                		String is = "未设置";
                		if(cobj.getIsinvoice()==2){
                			is="是";
                			}else if(cobj.getIsinvoice()==1){
                				is = "否";
                			}
                		
	                		 String dname= "";
	               		  if(cobj.getDonationmethods()!=4)
	               		  {
	               			  dname=Contributions.DONATION_METHODS[cobj.getDonationmethods()];
	               		  }else{
	               			  dname="其他/"+cobj.getDmname();
	               		  }
	               		  String cname= "";
	               		  if(cobj.getCurrency()!=1)
	               		  {
	               			  cname = Contributions.CURRENCY_TYPE[cobj.getCurrency()];
	               		  }else
	               		  {
	               			  cname= "其他/"+cobj.getCurrencyname();
	               		  }
	               		  
	               		  String paytimes = null;
	               		  String financetime = null;
	               		  String receipttime = null;
	               		  
	               		  if(cobj.getPaytimes()!=null)
	               		  {
	               			paytimes =Entity.sdf2.format(cobj.getPaytimes());
	               		  }
	               		  if(cobj.getFinancetime()!=null){
	               			financetime = Entity.sdf2.format(cobj.getFinancetime());
	               		  }
	               		  if(cobj.getReceipttime()!=null){
	               			receipttime = Entity.sdf2.format(cobj.getReceipttime());
	               		  }
                		
                		  ws.addCell(new jxl.write.Label(jj++,i + 1,cid));
                		  ws.addCell(new jxl.write.Label(jj++,i + 1,Contributions.CID_TYPE[cobj.getCidtype()]));
                		  ws.addCell(new jxl.write.Label(jj++,i + 1,is));
                		  ws.addCell(new jxl.write.Label(jj++,i + 1,cobj.getName()));
                		  ws.addCell(new jxl.write.Label(jj++,i + 1,cobj.getMobile()));
                		  ws.addCell(new jxl.write.Label(jj++,i + 1,cobj.getInvoice()));
                		  ws.addCell(new jxl.write.Label(jj++,i + 1,cobj.getRecipientname()));
                		  ws.addCell(new jxl.write.Label(jj++,i + 1,cobj.getAddress()));
                		  ws.addCell(new jxl.write.Label(jj++,i + 1,cobj.getZip()));
                		  
                		  ws.addCell(new jxl.write.Label(jj++,i + 1,paytimes));
                		  ws.addCell(new jxl.write.Label(jj++,i + 1,financetime));
                		 
                		  ws.addCell(new jxl.write.Label(jj++,i + 1,dname));
                		   
                		  
                		  ws.addCell(new jxl.write.Label(jj++,i + 1,String.valueOf(cobj.getPaymoney())));
                		  
                		  String implementationtimes = null;
                		  if(cobj.getImplementationtimes()!=null){
                			  implementationtimes =   Entity.sdf.format(cobj.getImplementationtimes());
                		  }
                		 
                		  ws.addCell(new jxl.write.Label(jj++,i + 1,cname));
                		  ws.addCell(new jxl.write.Label(jj++,i + 1,cobj.getNULL(cobj.getDonation_requested())));
                		  ws.addCell(new jxl.write.Label(jj++,i + 1,cobj.getNULL(cobj.getDesignated_place())));
                		  ws.addCell(new jxl.write.Label(jj++,i + 1,cobj.getNULL(cobj.getReceiptno())));
                		  ws.addCell(new jxl.write.Label(jj++,i + 1,receipttime));
                		  
                		  ws.addCell(new jxl.write.Label(jj++,i + 1,Contributions.WHETHERTHEMAIL_TYPE[cobj.getWhetherthe_mail()]));
                		  ws.addCell(new jxl.write.Label(jj++,i + 1,Contributions.WHETHERTHEMAIL_TYPE[cobj.getBounce()]));
                		  ws.addCell(new jxl.write.Label(jj++,i + 1,implementationtimes));
                		  ws.addCell(new jxl.write.Label(jj++,i + 1,cobj.getNULL(cobj.getImp_ddress_city())));
                		  ws.addCell(new jxl.write.Label(jj++,i + 1,cobj.getNULL(cobj.getImp_ddress_village())));
                		  ws.addCell(new jxl.write.Label(jj++,i + 1,cobj.getNULL(cobj.getFeedback())));
                		  ws.addCell(new jxl.write.Label(jj++,i + 1,cobj.getNULL(cobj.getImgname())));
                		  ws.addCell(new jxl.write.Label(jj++,i + 1,cobj.getNULL(cobj.getImgpath())));
                		  ws.addCell(new jxl.write.Label(jj++,i + 1,cobj.getNULL(cobj.getRemarks())));
                		  
                		  ws.addCell(new jxl.write.Label(jj++,i + 1,String.valueOf(cobj.getPaymoney())));
                		  ws.addCell(new jxl.write.Label(jj++,i + 1,cobj.sdf2.format(cobj.getTimes())));
                		   
                          i++;
                		
                	}
                }else
                {
                	Enumeration e=Contributions.find(teasession._strCommunity, sql.toString(), 0, Integer.MAX_VALUE);
                	while(e.hasMoreElements())
                	{ 
                		String cid = ((String)e.nextElement());
                        Contributions cobj = Contributions.find(cid);
               		
                        int jj =0;
                    	String is = "未设置";
                		if(cobj.getIsinvoice()==2){
                			is="是";
                			}else if(cobj.getIsinvoice()==1){
                				is = "否";
                			}
                		
                		 String paytimes = null;
	               		  String financetime = null;
	               		  String receipttime = null;
	               		  
	               		  if(cobj.getPaytimes()!=null)
	               		  {
	               			paytimes =Entity.sdf2.format(cobj.getPaytimes());
	               		  }
	               		  if(cobj.getFinancetime()!=null){
	               			financetime = Entity.sdf2.format(cobj.getFinancetime());
	               		  }
	               		  if(cobj.getReceipttime()!=null){
	               			receipttime = Entity.sdf2.format(cobj.getReceipttime());
	               		  }
                		  ws.addCell(new jxl.write.Label(jj++,i + 1,cid));
                		  ws.addCell(new jxl.write.Label(jj++,i + 1,Contributions.CID_TYPE[cobj.getCidtype()]));
                		  ws.addCell(new jxl.write.Label(jj++,i + 1,is));
                		  ws.addCell(new jxl.write.Label(jj++,i + 1,cobj.getName()));
                		  ws.addCell(new jxl.write.Label(jj++,i + 1,cobj.getMobile()));
                		  ws.addCell(new jxl.write.Label(jj++,i + 1,cobj.getInvoice()));
                		  ws.addCell(new jxl.write.Label(jj++,i + 1,cobj.getRecipientname()));
                		  ws.addCell(new jxl.write.Label(jj++,i + 1,cobj.getAddress()));
                		  ws.addCell(new jxl.write.Label(jj++,i + 1,cobj.getZip()));
                		  
                		  ws.addCell(new jxl.write.Label(jj++,i + 1,paytimes));
                		  ws.addCell(new jxl.write.Label(jj++,i + 1,financetime));
                		  String dname= "";
                		  if(cobj.getDonationmethods()!=4)
                		  {
                			  dname=Contributions.DONATION_METHODS[cobj.getDonationmethods()];
                		  }else{
                			  dname="其他/"+cobj.getDmname();
                		  }
                		  ws.addCell(new jxl.write.Label(jj++,i + 1,dname));
                		   
                		  
                		  ws.addCell(new jxl.write.Label(jj++,i + 1,String.valueOf(cobj.getPaymoney())));
                		  String cname= "";
                		  if(cobj.getCurrency()!=1)
                		  {
                			  cname = Contributions.CURRENCY_TYPE[cobj.getCurrency()];
                		  }else
                		  {
                			  cname= "其他/"+cobj.getCurrencyname(); 
                		  }
                		  ws.addCell(new jxl.write.Label(jj++,i + 1,cname));
                		  ws.addCell(new jxl.write.Label(jj++,i + 1,cobj.getNULL(cobj.getDonation_requested())));
                		  ws.addCell(new jxl.write.Label(jj++,i + 1,cobj.getNULL(cobj.getDesignated_place())));
                		  ws.addCell(new jxl.write.Label(jj++,i + 1,cobj.getNULL(cobj.getReceiptno())));
                		  ws.addCell(new jxl.write.Label(jj++,i + 1,receipttime));
                		  
                		  ws.addCell(new jxl.write.Label(jj++,i + 1,Contributions.WHETHERTHEMAIL_TYPE[cobj.getWhetherthe_mail()]));
                		  ws.addCell(new jxl.write.Label(jj++,i + 1,Contributions.WHETHERTHEMAIL_TYPE[cobj.getBounce()]));
                		  ws.addCell(new jxl.write.Label(jj++,i + 1,cobj.getNULL(cobj.getImplementationtimes())));
                		  ws.addCell(new jxl.write.Label(jj++,i + 1,cobj.getNULL(cobj.getImp_ddress_city())));
                		  ws.addCell(new jxl.write.Label(jj++,i + 1,cobj.getNULL(cobj.getImp_ddress_village())));
                		  ws.addCell(new jxl.write.Label(jj++,i + 1,cobj.getNULL(cobj.getFeedback())));
                		  ws.addCell(new jxl.write.Label(jj++,i + 1,cobj.getNULL(cobj.getImgname()))); 
                		  ws.addCell(new jxl.write.Label(jj++,i + 1,cobj.getNULL(cobj.getImgpath())));
                		  ws.addCell(new jxl.write.Label(jj++,i + 1,cobj.getNULL(cobj.getRemarks())));
                		  
                		  ws.addCell(new jxl.write.Label(jj++,i + 1,String.valueOf(cobj.getPaymoney())));
                		  ws.addCell(new jxl.write.Label(jj++,i + 1,cobj.sdf2.format(cobj.getTimes())));
              		  
                         i++;
               		
                		 
                	}
                }
                
			}else if("Contributions2".equals(act))//英文网 母亲水窖 捐款订单导出
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
			
				
 
                ws.addCell(new jxl.write.Label(j++,0,"捐赠号",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"类型",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"支付宝姓名/名称 ",wcf));
               
                ws.addCell(new jxl.write.Label(j++,0,"落实时间",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"落实地点-省-县",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"落实地点-村",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"回馈情况",wcf));
             
                ws.addCell(new jxl.write.Label(j++,0,"备注信息",wcf));

                ws.addCell(new jxl.write.Label(j++,0,"捐款数额",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"下单时间",wcf));
                
                
                
                
                
                
                //选中导出
                
                if(teasession.getParameter("cidorder")!=null && teasession.getParameter("cidorder").length()>0)
                {
                	String cb []  = teasession.getParameterValues("cidorder");
                	
                	for(int i2 =0;i2<cb.length;i2++)
                	{
                		 String cid = cb[i2];
                         Contributions cobj = Contributions.find(cid);
                		int jj =0;
                		
	               		  
                		  String implementationtimes = null;
                		  if(cobj.getImplementationtimes()!=null){
                			  implementationtimes =   Entity.sdf.format(cobj.getImplementationtimes());
                		  }
                		 
	               		  
	               		
                		  ws.addCell(new jxl.write.Label(jj++,i + 1,cid));
                		  ws.addCell(new jxl.write.Label(jj++,i + 1,Contributions.CID_TYPE[cobj.getCidtype()]));
                		
                		  ws.addCell(new jxl.write.Label(jj++,i + 1,cobj.getName()));
                		  
                		 
                		
                		  
                		  ws.addCell(new jxl.write.Label(jj++,i + 1,implementationtimes));
                		  ws.addCell(new jxl.write.Label(jj++,i + 1,cobj.getNULL(cobj.getImp_ddress_city())));
                		  ws.addCell(new jxl.write.Label(jj++,i + 1,cobj.getNULL(cobj.getImp_ddress_village())));
                		  ws.addCell(new jxl.write.Label(jj++,i + 1,cobj.getNULL(cobj.getFeedback())));
                		 
                		  ws.addCell(new jxl.write.Label(jj++,i + 1,cobj.getNULL(cobj.getRemarks())));
                		  
                		  ws.addCell(new jxl.write.Label(jj++,i + 1,String.valueOf(cobj.getPaymoney())));
                		  ws.addCell(new jxl.write.Label(jj++,i + 1,cobj.sdf2.format(cobj.getTimes())));
                		   
                          i++;
                		
                	}
                }else
                {
                	Enumeration e=Contributions.find(teasession._strCommunity, sql.toString(), 0, Integer.MAX_VALUE);
                	while(e.hasMoreElements())
                	{ 
                		String cid = ((String)e.nextElement());
                        Contributions cobj = Contributions.find(cid);
               		
                        int jj =0;
                    	

                        String implementationtimes = null;
              		  if(cobj.getImplementationtimes()!=null){
              			  implementationtimes =   Entity.sdf.format(cobj.getImplementationtimes());
              		  }
              		 
              		  ws.addCell(new jxl.write.Label(jj++,i + 1,cid));
              		  ws.addCell(new jxl.write.Label(jj++,i + 1,Contributions.CID_TYPE[cobj.getCidtype()]));
              		
              		  ws.addCell(new jxl.write.Label(jj++,i + 1,cobj.getName()));
              		  
              		 
              		
              		  
              		  ws.addCell(new jxl.write.Label(jj++,i + 1,implementationtimes));
              		  ws.addCell(new jxl.write.Label(jj++,i + 1,cobj.getNULL(cobj.getImp_ddress_city())));
              		  ws.addCell(new jxl.write.Label(jj++,i + 1,cobj.getNULL(cobj.getImp_ddress_village())));
              		  ws.addCell(new jxl.write.Label(jj++,i + 1,cobj.getNULL(cobj.getFeedback())));
              		 
              		  ws.addCell(new jxl.write.Label(jj++,i + 1,cobj.getNULL(cobj.getRemarks())));
              		  
              		  ws.addCell(new jxl.write.Label(jj++,i + 1,String.valueOf(cobj.getPaymoney())));
              		  ws.addCell(new jxl.write.Label(jj++,i + 1,cobj.sdf2.format(cobj.getTimes())));
              		  
                         i++;
               		
                		 
                	}
                }
                
			}
			
			else if("WomenMember".equals(act))//英文网会员导出
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
				

                ws.addCell(new jxl.write.Label(j++,0,"用户名",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"会员昵称 ",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"性别 ",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"年龄 ",wcf));
      
                ws.addCell(new jxl.write.Label(j++,0,"是否订阅电子报",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"是否订阅学术论文摘要",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"地区",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"国家",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"行业",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"工作",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"网站信息",wcf));
    
      	

                //选中导出
        
                if(teasession.getParameter("memberorder")!=null && teasession.getParameter("memberorder").length()>0)
                {
                	String tal []  = teasession.getParameterValues("memberorder");
                	
                	for(int i2 =0;i2<tal.length;i2++)
                	{
                		String memberorder =tal[i2];
                	    MemberOrder  moobj = MemberOrder.find(memberorder);
                	    Profile pobj = Profile.find(moobj.getMember());
                	    String s ="女";
                	    if(!pobj.isSex())
                	    {
                	    	s = "男";
                	    }
                	   
                	  
                	   //是否订阅电子报
                	    String istr = "是";
                	    if(moobj.getNewsletter()==0){
                	    	istr = "否";
                	    }
                	    //是否订阅学术论文摘要
                	    String abs = "是";
                	    if(moobj.getAbstracts()==0){
                	    	abs = "否";
                	    }
                	    String country= r.getString(0,"Country." + pobj.getCountry(teasession._nLanguage));
                	    
                	    StringBuffer wostr = new StringBuffer("/");
                	    if(pobj.getWoid()!=null && pobj.getWoid().length()>0){
	                	    for(int iw=1;iw<pobj.getWoid().split("/").length;iw++)
	                	    {
	                	    	String w = pobj.getWoid().split("/")[iw];
	                	    	WomenOptions wobj = WomenOptions.find(Integer.parseInt(w));
	                	    	wostr.append(wobj.getWoname()).append("/");
	                	    }
                	    }
                		  ws.addCell(new jxl.write.Label(0,i + 1,moobj.getMember()));
                		  ws.addCell(new jxl.write.Label(1,i + 1,pobj.getFirstName(teasession._nLanguage)));
                		  ws.addCell(new jxl.write.Label(2,i + 1,s)); 
                		  ws.addCell(new jxl.write.Label(3,i + 1,Common.AGE_TYPE[pobj.getAgent()]));
                		  ws.addCell(new jxl.write.Label(4,i + 1,istr));
                		  ws.addCell(new jxl.write.Label(5,i + 1,abs));
                		  
                		  ws.addCell(new jxl.write.Label(6,i + 1,pobj.getCity(teasession._nLanguage)));
                		  
                		  ws.addCell(new jxl.write.Label(7,i + 1,country));
                		  
                		  ws.addCell(new jxl.write.Label(8,i + 1,Profile.INDUSTRY[pobj.getIndustry()]));
                		  ws.addCell(new jxl.write.Label(9,i + 1,Profile.INDUSTRY[pobj.getJob()]));
                		  
                		  ws.addCell(new jxl.write.Label(10,i + 1,wostr.toString()));
                		  
                	
                		 
                		  
                          i++;
                		
                	}
                }else//sql 语句导出
                { 
                	
                	Enumeration e =MemberOrder.findMP(teasession._strCommunity,sql.toString(),0,Integer.MAX_VALUE); 
          
                	while ( e.hasMoreElements()) {
                		String memberorder =((String)e.nextElement());
                	    MemberOrder  moobj = MemberOrder.find(memberorder);
                	    Profile pobj = Profile.find(moobj.getMember());
                	    String s ="女";
                	    if(!pobj.isSex())
                	    {
                	    	s = "男";
                	    }

                 	   //是否订阅电子报
                 	    String istr = "是";
                 	    if(moobj.getNewsletter()==0){
                 	    	istr = "否";
                 	    }
                 	    //是否订阅学术论文摘要
                 	    String abs = "是";
                 	    if(moobj.getAbstracts()==0){
                 	    	abs = "否";
                 	    }
                 	    String country= r.getString(0,"Country." + pobj.getCountry(teasession._nLanguage));
                 	    
                 	   StringBuffer wostr = new StringBuffer("/");
               	    if(pobj.getWoid()!=null && pobj.getWoid().length()>0){
	                	    for(int iw=1;iw<pobj.getWoid().split("/").length;iw++)
	                	    {
	                	    	String w = pobj.getWoid().split("/")[iw];
	                	    	WomenOptions wobj = WomenOptions.find(Integer.parseInt(w));
	                	    	wostr.append(wobj.getWoname()).append("/");
	                	    }
               	    }
                 	   
                 		  ws.addCell(new jxl.write.Label(0,i + 1,moobj.getMember()));
                 		  ws.addCell(new jxl.write.Label(1,i + 1,pobj.getFirstName(teasession._nLanguage)));
                 		  ws.addCell(new jxl.write.Label(2,i + 1,s)); 
                 		  ws.addCell(new jxl.write.Label(3,i + 1,Common.AGE_TYPE[pobj.getAgent()]));
                 		  ws.addCell(new jxl.write.Label(4,i + 1,istr));
                 		  ws.addCell(new jxl.write.Label(5,i + 1,abs));
                 		  
                 		  ws.addCell(new jxl.write.Label(6,i + 1,pobj.getCity(teasession._nLanguage)));
                 		  
                 		  ws.addCell(new jxl.write.Label(7,i + 1,country));
                 		  
                 		  ws.addCell(new jxl.write.Label(8,i + 1,Profile.INDUSTRY[pobj.getIndustry()]));
                 		  ws.addCell(new jxl.write.Label(9,i + 1,Profile.INDUSTRY[pobj.getJob()]));
                 		  
                 		  ws.addCell(new jxl.write.Label(10,i + 1,wostr.toString()));
                 		  
                 	
                        i++;
                		
                	}
                }
			}else if("WestracMember".equals(act))
			{
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
                ws.addCell(new jxl.write.Label(j++,0,"E-mail ",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"用户名 ",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"姓名 ",wcf));
      
                ws.addCell(new jxl.write.Label(j++,0,"性别",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"身份证号",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"手机",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"现工作地",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"核实后身份",wcf));
                
                ws.addCell(new jxl.write.Label(j++,0,"民族",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"学历",wcf));
                
                ws.addCell(new jxl.write.Label(j++,0,"固定电话",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"家庭所在地",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"现通讯地址",wcf));
                
                
                
                ws.addCell(new jxl.write.Label(j++,0,"邮编",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"QQ",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"推荐人会员编号",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"是否有上岗证",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"发证机关",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"操作年限",wcf));
                
                ws.addCell(new jxl.write.Label(j++,0,"身份类型",wcf));
                
                ws.addCell(new jxl.write.Label(j++,0,"现操作机型(品牌)",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"现操作机型(型号)",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"现操作机型(其他)",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"曾操作机型(品牌)",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"曾操作机型(型号)",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"曾操作机型(其他)",wcf));
                
                
                ws.addCell(new jxl.write.Label(j++,0,"机主相关(姓名)",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"机主相关(型号)",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"机主相关(序列号)",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"机主相关(联系方式)",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"爱好",wcf));
              
                
                
                
                
                if(teasession.getParameter("memberorder")!=null && teasession.getParameter("memberorder").length()>0)
                {
                	String tal []  = teasession.getParameterValues("memberorder");
                	
                	for(int i2 =0;i2<tal.length;i2++)
                	{
                		String member =tal[i2];
                	   
                		int cc =0;
                	    Profile pobj = Profile.find(member);
                	   
                	
            	    	
            	    	String ad = "";
            	    	
            	    	if(pobj.getZzhkszd(teasession._nLanguage)!=null && pobj.getZzhkszd(teasession._nLanguage).length()>0){
            	    		ad = Card.find(Integer.parseInt(pobj.getZzhkszd(teasession._nLanguage))).toString2()+pobj.getPAddress(teasession._nLanguage);
            	    	}
            	    	String ad2 = "";
            	    	
            	    	if(pobj.getState(teasession._nLanguage)!=null && pobj.getState(teasession._nLanguage).length()>0){
            	    		ad2 = Card.find(Integer.parseInt(pobj.getState(teasession._nLanguage))).toString2()+pobj.getOrganization(teasession._nLanguage);
            	    	}
            	    	
            	    	int d = 0;
            	    	if(pobj.getDegree(teasession._nLanguage)!=null&&pobj.getDegree(teasession._nLanguage).length()>0)
            	    	{
            	    		d =  Integer.parseInt(pobj.getDegree(teasession._nLanguage));
            	    	}
                	  
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getCode()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getEmail()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,member));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getFirstName(teasession._nLanguage)));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.isSex()?"女":"男"));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getCard()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getMobile()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,Card.find(pobj.getProvince(teasession._nLanguage)).toString2()+pobj.getAddress(teasession._nLanguage)));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,Profile.VERIFY_TYPE[pobj.getVerifytype()]));
                		  
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getZzracky()));
                		  
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,Profile.DEGREE_TYPE[d]));
                		  
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getTelephone(teasession._nLanguage)));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,ad));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,ad2));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getZip(teasession._nLanguage)));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getMsnID()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getTjmember()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getSfshanggang()==0?"是":"否"));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getFazhengjiguan()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getCaozuonianxian()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.WST_TYPE[pobj.getWstType()]));
                		  
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,WomenOptions.find(pobj.getXpinpai()).getWoname()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,WomenOptions.find(pobj.getXxinghao()).getWoname()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getXqita()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,WomenOptions.find(pobj.getCpinpai()).getWoname()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,WomenOptions.find(pobj.getCxinghao()).getWoname()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getCqita()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getJzname()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getJzxinghao()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getJzxuliehao()));
                		  
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getJzlianxi()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getAihao()));
                		 
                	
                		 
                		  
                          i++;
                		
                	}
                }else//sql 语句导出
                { 
                	
                	
                	 java.util.Enumeration e = Profile.find(MT.dec(sql.toString()),0,Integer.MAX_VALUE);
          
                	while ( e.hasMoreElements()) {
                
                		String member =((String)e.nextElement());
                   	 
                		int cc =0;
                	    Profile pobj = Profile.find(member);
                	   
                	
            	    	
            	    	String ad = "";
            	    	
            	    	if(pobj.getZzhkszd(teasession._nLanguage)!=null && pobj.getZzhkszd(teasession._nLanguage).length()>0){
            	    		ad = Card.find(Integer.parseInt(pobj.getZzhkszd(teasession._nLanguage))).toString2()+pobj.getPAddress(teasession._nLanguage);
            	    	}
            	    	String ad2 = "";
            	    	
            	    	if(pobj.getState(teasession._nLanguage)!=null && pobj.getState(teasession._nLanguage).length()>0){
            	    		ad2 = Card.find(Integer.parseInt(pobj.getState(teasession._nLanguage))).toString2()+pobj.getOrganization(teasession._nLanguage);
            	    	}
            	    	
            	    	
            	    	int d = 0;
            	    	if(pobj.getDegree(teasession._nLanguage)!=null&&pobj.getDegree(teasession._nLanguage).length()>0)
            	    	{
            	    		d =  Integer.parseInt(pobj.getDegree(teasession._nLanguage));
            	    	}
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getCode()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getEmail()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,member));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getFirstName(teasession._nLanguage)));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.isSex()?"女":"男"));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getCard()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getMobile()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,Card.find(pobj.getProvince(teasession._nLanguage)).toString2()+pobj.getAddress(teasession._nLanguage)));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,Profile.VERIFY_TYPE[pobj.getVerifytype()]));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getZzracky()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,Profile.DEGREE_TYPE[d]));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getTelephone(teasession._nLanguage)));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,ad));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,ad2));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getZip(teasession._nLanguage)));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getMsnID()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getTjmember()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getSfshanggang()==0?"是":"否"));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getFazhengjiguan()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getCaozuonianxian()));
                		  
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.WST_TYPE[pobj.getWstType()]));
                		  
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,WomenOptions.find(pobj.getXpinpai()).getWoname()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,WomenOptions.find(pobj.getXxinghao()).getWoname()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getXqita()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,WomenOptions.find(pobj.getCpinpai()).getWoname()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,WomenOptions.find(pobj.getCxinghao()).getWoname()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getCqita()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getJzname()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getJzxinghao()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getJzxuliehao()));
                		  
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getJzlianxi()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getAihao()));
                		 
                	
                		 


                	    
                        i++;
                		 
                	}
                }
                
				
			}else if("ednMember".equals(act))
			{
				//系统前台的公用 用户管理
				
				
				ws.setColumnView(a++, 20); // 设置列的宽度
				ws.setColumnView(a++, 20); // 设置列的宽度
				ws.setColumnView(a++, 20); // 设置列的宽度
				ws.setColumnView(a++, 20); // 设置列的宽度
				ws.setColumnView(a++, 20); // 设置列的宽度
				ws.setColumnView(a++, 20); // 设置列的宽度
				ws.setColumnView(a++, 20); // 设置列的宽度
				ws.setColumnView(a++, 20); // 设置列的宽度
				ws.setColumnView(a++, 20); // 设置列的宽度
            
                
                ws.addCell(new jxl.write.Label(j++,0,"用户名 ",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"姓名 ",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"性别",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"生日",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"手机",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"E-mail ",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"现工作地",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"固定电话",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"邮编",wcf));
               
              
                
                
                
                
                if(teasession.getParameter("memberorder")!=null && teasession.getParameter("memberorder").length()>0)
                {
                	String tal []  = teasession.getParameterValues("memberorder");
                	
                	for(int i2 =0;i2<tal.length;i2++)
                	{
                		String member =tal[i2];
                	   
                		int cc =0;
                	    Profile pobj = Profile.find(member);
                	
	        	    	  ws.addCell(new jxl.write.Label(cc++,i + 1,member));
	        	    	  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getFirstName(teasession._nLanguage)));
	          		      ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.isSex()?"女":"男"));
	          		      ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getBirth()!=null?Entity.sdf.format(pobj.getBirth()):""));
	          		      ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getMobile()));
	            		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getEmail()));
	            		  ws.addCell(new jxl.write.Label(cc++,i + 1,Card.find(pobj.getProvince(teasession._nLanguage)).toString2()+pobj.getAddress(teasession._nLanguage)));
	            		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getTelephone(teasession._nLanguage)));
	            		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getZip(teasession._nLanguage)));
                
                          i++;
                		
                	}
                }else//sql 语句导出
                { 
                	
                	
                	 java.util.Enumeration e = Profile.find(MT.dec(sql.toString()),0,Integer.MAX_VALUE);
          
                	while ( e.hasMoreElements()) {
                
                		String member =((String)e.nextElement());
                   	 
                		int cc =0;
                	    Profile pobj = Profile.find(member);

	        	    	  ws.addCell(new jxl.write.Label(cc++,i + 1,member));
	        	    	  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getFirstName(teasession._nLanguage)));
	          		      ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.isSex()?"女":"男"));
	          		      ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getBirth()!=null?Entity.sdf.format(pobj.getBirth()):""));
	          		      ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getMobile()));
	            		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getEmail()));
	            		  ws.addCell(new jxl.write.Label(cc++,i + 1,Card.find(pobj.getProvince(teasession._nLanguage)).toString2()+pobj.getAddress(teasession._nLanguage)));
	            		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getTelephone(teasession._nLanguage)));
	            		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getZip(teasession._nLanguage)));
                        i++;
                		 
                	}
                }
                
				
				
			}
			
			else if("GolfMember".equals(act))
			{
				// 高尔夫  俱乐部会员导出
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
                ws.addCell(new jxl.write.Label(j++,0,"E-mail ",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"用户名 ",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"姓名 ",wcf));
      
                ws.addCell(new jxl.write.Label(j++,0,"性别",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"身份证号",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"手机",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"现工作地",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"固定电话",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"家庭所在地",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"现通讯地址",wcf));
                
                
                
                ws.addCell(new jxl.write.Label(j++,0,"邮编",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"QQ",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"推荐人会员编号",wcf));
                
                ws.addCell(new jxl.write.Label(j++,0,"身高",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"打球年龄",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"差点or平均成绩",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"喜欢的(木，球道，铁木，铁，推)",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"手尺",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"手碗到地面距离",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"用手 右手，左手",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"挥杆节奏",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"现使用球具品牌",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"现使用球具型号",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"现使用球具其他",wcf));
                
                ws.addCell(new jxl.write.Label(j++,0,"企业名称",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"企业logo或图片",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"企业网站",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"企业联系方式",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"企业地址",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"企业服务或产品",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"企业微博",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"个人微博",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"企业介绍",wcf));
                
                
                
                
              
                
                
                
                
                if(teasession.getParameter("memberorder")!=null && teasession.getParameter("memberorder").length()>0)
                {
                	String tal []  = teasession.getParameterValues("memberorder");
                	
                	for(int i2 =0;i2<tal.length;i2++)
                	{
                		String member =tal[i2];
                	   
                		int cc =0;
                	    Profile pobj = Profile.find(member);
                	   
                	
            	    	
            	    	String ad = "";
            	    	
            	    	if(pobj.getZzhkszd(teasession._nLanguage)!=null && pobj.getZzhkszd(teasession._nLanguage).length()>0){
            	    		ad = Card.find(Integer.parseInt(pobj.getZzhkszd(teasession._nLanguage))).toString2()+pobj.getPAddress(teasession._nLanguage);
            	    	}
            	    	String ad2 = "";
            	    	
            	    	if(pobj.getState(teasession._nLanguage)!=null && pobj.getState(teasession._nLanguage).length()>0){
            	    		ad2 = Card.find(Integer.parseInt(pobj.getState(teasession._nLanguage))).toString2()+pobj.getOrganization(teasession._nLanguage);
            	    	}
            	    	
            	    	
                	  
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getCode()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getEmail()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,member));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getFirstName(teasession._nLanguage)));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.isSex()?"女":"男"));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getCard()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getMobile()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,Card.find(pobj.getProvince(teasession._nLanguage)).toString2()+pobj.getAddress(teasession._nLanguage)));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getTelephone(teasession._nLanguage)));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,ad));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,ad2));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getZip(teasession._nLanguage)));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getMsnID()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getTjmember()));
                		  
                		  
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getMemberheight()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getBallage()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getAlmostscore()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getLikeitems()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getHandfoot()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getGdistance()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getYhand()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getSwingrhythm()));
                		  
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,WomenOptions.find(pobj.getXpinpai()).getWoname()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,WomenOptions.find(pobj.getXxinghao()).getWoname()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getXqita()));
                		  
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getEntername()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getEnterpic()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getEnterwebsite()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getEntercontact()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getEnteraddress()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getEnterproduct()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getEnterweibo()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getPersonalweibo()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getEntertext()));
                	 
                		 
                		  
                          i++;
                		
                	}
                }else//sql 语句导出
                { 
                	
                	
                	 java.util.Enumeration e = Profile.find(MT.dec(sql.toString()),0,Integer.MAX_VALUE);
          
                	while ( e.hasMoreElements()) {
                
                		String member =((String)e.nextElement());
                   	 
                		int cc =0;
                	    Profile pobj = Profile.find(member);
                	   
                	
            	    	
            	    	String ad = "";
            	    	
            	    	if(pobj.getZzhkszd(teasession._nLanguage)!=null && pobj.getZzhkszd(teasession._nLanguage).length()>0){
            	    		ad = Card.find(Integer.parseInt(pobj.getZzhkszd(teasession._nLanguage))).toString2()+pobj.getPAddress(teasession._nLanguage);
            	    	}
            	    	String ad2 = "";
            	    	
            	    	if(pobj.getState(teasession._nLanguage)!=null && pobj.getState(teasession._nLanguage).length()>0){
            	    		ad2 = Card.find(Integer.parseInt(pobj.getState(teasession._nLanguage))).toString2()+pobj.getOrganization(teasession._nLanguage);
            	    	}
            	    	
            	    	
                	  
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getCode()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getEmail()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,member));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getFirstName(teasession._nLanguage)));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.isSex()?"女":"男"));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getCard()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getMobile()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,Card.find(pobj.getProvince(teasession._nLanguage)).toString2()+pobj.getAddress(teasession._nLanguage)));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getTelephone(teasession._nLanguage)));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,ad));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,ad2));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getZip(teasession._nLanguage)));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getMsnID()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getTjmember()));
                		  
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getMemberheight()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getBallage()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getAlmostscore()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getLikeitems()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getHandfoot()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getGdistance()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getYhand()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getSwingrhythm()));
                		  
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,WomenOptions.find(pobj.getXpinpai()).getWoname()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,WomenOptions.find(pobj.getXxinghao()).getWoname()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getXqita()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getEntername()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getEnterpic()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getEnterwebsite()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getEntercontact()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getEnteraddress()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getEnterproduct()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getEnterweibo()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getPersonalweibo()));
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getEntertext()));
                		  
 
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
