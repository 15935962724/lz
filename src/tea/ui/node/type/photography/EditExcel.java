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



            WritableFont wf = new WritableFont(WritableFont.TIMES, 10,WritableFont.BOLD, false, UnderlineStyle.NO_UNDERLINE,jxl.format.Colour.BLACK); // ???????????? ?????? ????????? ?????? ?????? ??????
            WritableCellFormat wcf = new WritableCellFormat(wf); // ???????????????
            
            wcf.setAlignment(jxl.format.Alignment.LEFT); // ??????????????????
           
           // ws.getSettings().setPrintGridLines(true);//?????????????????????
            

			int i = 0,j=0,a=0,b=0;
			if("TalkbackList".equals(act))//???????????? 
			{

				    ws.setColumnView(0, 20); // ??????????????????
				    ws.setColumnView(1, 20); // ??????????????????
				    ws.setColumnView(2, 20); // ??????????????????
				    ws.setColumnView(3, 20); // ??????????????????
				    ws.setColumnView(4, 20); // ??????????????????
				    ws.setColumnView(5, 20); // ??????????????????
				    ws.setColumnView(6, 20); // ??????????????????
				    ws.setColumnView(7, 20); // ??????????????????
				    ws.setColumnView(8, 20); // ??????????????????

				    
               // ws.addCell(new jxl.write.Label(j++,0,"??????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"?????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"??????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"??????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));
                
                //????????????
        
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
                			member="??????";
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
                }else//sql ????????????
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
                			member="??????";
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
                
              
                
                

			}else if("TalkbackReply".equals(act))//????????????
			{

				ws.setColumnView(0, 20); // ??????????????????
				ws.setColumnView(1, 20); // ??????????????????
				ws.setColumnView(2, 20); // ??????????????????
				ws.setColumnView(3, 20); // ??????????????????
				ws.setColumnView(4, 20); // ??????????????????
				ws.setColumnView(5, 20); // ??????????????????


                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"???????????? ",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"???????????? ",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"??????",wcf));
                
                //????????????
        
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
                			member="??????";
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
                }else//sql ????????????
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
                			member="??????";
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
				ws.setColumnView(0, 20); // ??????????????????
				ws.setColumnView(1, 20); // ??????????????????
				ws.setColumnView(2, 20); // ??????????????????
				ws.setColumnView(3, 20); // ??????????????????
				ws.setColumnView(4, 20); // ??????????????????
				ws.setColumnView(5, 20); // ??????????????????
				ws.setColumnView(6, 20); // ??????????????????
				ws.setColumnView(7, 20); // ??????????????????
				ws.setColumnView(8, 20); // ??????????????????
				ws.setColumnView(9, 20); // ??????????????????
		

                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"?????? ",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"???????????? ",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"??????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"??????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));
                
                if("votenumber".equals(teasession.getParameter("voteact")))
                { 
                	ws.addCell(new jxl.write.Label(j++,0,"??????",wcf));
                }else
                {
                	ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));
                }
                
                
                
                
                //????????????
        
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
                }else//sql ????????????
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
			}else if("MemberList".equals(act))//????????????????????????
			{

				ws.setColumnView(0, 20); // ??????????????????
				ws.setColumnView(1, 20); // ??????????????????
				ws.setColumnView(2, 20); // ??????????????????
				ws.setColumnView(3, 20); // ??????????????????
				ws.setColumnView(4, 20); // ??????????????????
				ws.setColumnView(5, 20); // ??????????????????
				ws.setColumnView(6, 20); // ??????????????????

 
		

                ws.addCell(new jxl.write.Label(j++,0,"??????ID",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"?????? ",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"???????????? ",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"??????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"??????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));

                //????????????
        
                if(teasession.getParameter("memberorder")!=null && teasession.getParameter("memberorder").length()>0)
                {
                	String tal []  = teasession.getParameterValues("memberorder");
                	
                	for(int i2 =0;i2<tal.length;i2++)
                	{
                		String memberorder =tal[i2];
                	    MemberOrder  moobj = MemberOrder.find(memberorder);
                	    Profile pobj = Profile.find(moobj.getMember());
                	    String s ="???";
                	    if(!pobj.isSex())
                	    {
                	    	s = "???";
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
                }else//sql ????????????
                { 
                	
                	Enumeration e =MemberOrder.findMP(teasession._strCommunity,sql.toString(),0,Integer.MAX_VALUE); 
                	while ( e.hasMoreElements()) {
                		String memberorder =((String)e.nextElement());
                	    MemberOrder  moobj = MemberOrder.find(memberorder);
                	    Profile pobj = Profile.find(moobj.getMember());
                	    
                	    String s ="???";
                	    if(!pobj.isSex())
                	    {
                	    	s = "???";
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
			}else if("ClssnMember".equals(act))//?????????????????????
			{

				ws.setColumnView(0, 20); // ??????????????????
				ws.setColumnView(1, 20); // ??????????????????
				ws.setColumnView(2, 20); // ??????????????????
				ws.setColumnView(3, 20); // ??????????????????
				ws.setColumnView(4, 20); // ??????????????????
				ws.setColumnView(5, 20); // ??????????????????
				ws.setColumnView(6, 20); // ??????????????????
				ws.setColumnView(7, 20); // ??????????????????
				ws.setColumnView(8, 20); // ??????????????????
				ws.setColumnView(9, 20); // ??????????????????
				ws.setColumnView(10, 20); // ??????????????????
				ws.setColumnView(11, 20); // ??????????????????
				ws.setColumnView(12, 20); // ??????????????????
				ws.setColumnView(13, 20); // ??????????????????
				ws.setColumnView(14, 20); // ??????????????????
				
				ws.setColumnView(15, 20); // ??????????????????
				
				ws.setColumnView(16, 20); // ??????????????????
				ws.setColumnView(17, 20); // ??????????????????
				ws.setColumnView(18, 20); // ??????????????????
				ws.setColumnView(19, 20); // ??????????????????
				ws.setColumnView(20, 20); // ??????????????????
				ws.setColumnView(21, 20); // ??????????????????

                ws.addCell(new jxl.write.Label(j++,0,"??????ID",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"???????????? ",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"???????????? ",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"?????? ",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"??????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"???????????? ",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"??????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"??????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"??????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));
                
                ws.addCell(new jxl.write.Label(j++,0,"???????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));
                

                //????????????
        
                if(teasession.getParameter("memberorder")!=null && teasession.getParameter("memberorder").length()>0)
                {
                	String tal []  = teasession.getParameterValues("memberorder");
                	
                	for(int i2 =0;i2<tal.length;i2++)
                	{
                		String memberorder =tal[i2];
                	    MemberOrder  moobj = MemberOrder.find(memberorder);
                	    Profile pobj = Profile.find(moobj.getMember());
                	    String s ="???";
                	    if(!pobj.isSex())
                	    {
                	    	s = "???";
                	    }
                	    String v ="?????????";
                	    if(Profile.findValid(moobj.getMember())==1)
                  		{
                  			v="?????????";
                  		}
                	    //????????????
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
                	    
                	    //????????????
                	    String vt = "";
                	    if(moobj.getVerifgtime()!=null){
                	    	vt = Entity.sdf2.format(moobj.getVerifgtime());
                	    }
                	    //???????????????
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
                }else//sql ????????????
                { 
                	
                	sql = MT.dec(sql);
                	Enumeration e =MemberOrder.findMP(teasession._strCommunity,sql,0,Integer.MAX_VALUE); 
          
                	while ( e.hasMoreElements()) {
                		String memberorder =((String)e.nextElement()); 
                	    MemberOrder  moobj = MemberOrder.find(memberorder);
                	    Profile pobj = Profile.find(moobj.getMember());
                	    
                	    String s ="???";
                	    if(!pobj.isSex())
                	    {
                	    	s = "???";
                	    }
                	    String v ="?????????";
                	    if(Profile.findValid(moobj.getMember())==1)
                  		{
                  			v="?????????";
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
                	    
                	    //????????????
                	    String vt = "";
                	    if(moobj.getVerifgtime()!=null){
                	    	vt = Entity.sdf2.format(moobj.getVerifgtime());
                	    }
                	    //???????????????
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
			}else if("WomenMessageBoardManage".equals(act))//????????? ????????????
			{
				ws.setColumnView(0, 20); // ??????????????????
				ws.setColumnView(1, 20); // ??????????????????
				ws.setColumnView(2, 20); // ??????????????????
				ws.setColumnView(3, 20); // ??????????????????
				ws.setColumnView(4, 20); // ??????????????????
				ws.setColumnView(5, 20); // ??????????????????
			
				

                ws.addCell(new jxl.write.Label(j++,0,"?????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"??????/?????? ",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"E-Mail",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"???????????? ",wcf));
                

                //????????????
        
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
                
				
			}else if("WomenMessageBoardManage2".equals(act))//????????? ????????????
			{
				ws.setColumnView(0, 20); // ??????????????????
				ws.setColumnView(1, 20); // ??????????????????
				ws.setColumnView(2, 20); // ??????????????????
				ws.setColumnView(3, 20); // ??????????????????
				ws.setColumnView(4, 20); // ??????????????????
			
				

                ws.addCell(new jxl.write.Label(j++,0,"?????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"?????? ",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"??????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"??????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));
                

                //????????????
        
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
                
				
			}else if("Contributions".equals(act))//????????? ???????????? ??????????????????
			{
				ws.setColumnView(0, 20); // ??????????????????
				ws.setColumnView(1, 20); // ??????????????????
				ws.setColumnView(2, 20); // ??????????????????
				
				ws.setColumnView(3, 20); // ??????????????????
				ws.setColumnView(4, 20); // ??????????????????
				ws.setColumnView(5, 20); // ??????????????????
				
				ws.setColumnView(6, 20); // ??????????????????
				ws.setColumnView(7, 20); // ??????????????????
				ws.setColumnView(8, 20); // ??????????????????
				ws.setColumnView(9, 20); // ??????????????????
				ws.setColumnView(10, 20); // ??????????????????
				ws.setColumnView(11, 20); // ??????????????????
				ws.setColumnView(12, 20); // ??????????????????
				ws.setColumnView(13, 20); // ??????????????????
				ws.setColumnView(14, 20); // ??????????????????
				ws.setColumnView(15, 20); // ??????????????????
				ws.setColumnView(16, 20); // ??????????????????
				ws.setColumnView(17, 20); // ??????????????????
				ws.setColumnView(18, 20); // ??????????????????
				ws.setColumnView(19, 20); // ??????????????????
				ws.setColumnView(20, 20); // ??????????????????
				ws.setColumnView(21, 20); // ??????????????????
				ws.setColumnView(22, 20); // ??????????????????
				ws.setColumnView(23, 20); // ??????????????????
				ws.setColumnView(24, 20); // ??????????????????
				ws.setColumnView(25, 20); // ??????????????????
				ws.setColumnView(26, 20); // ??????????????????
				ws.setColumnView(27, 20); // ??????????????????
				
 
                ws.addCell(new jxl.write.Label(j++,0,"?????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"??????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"???????????????",wcf));
                
                ws.addCell(new jxl.write.Label(j++,0,"???????????????/?????? ",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"?????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"?????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"?????? ",wcf));
                
                ws.addCell(new jxl.write.Label(j++,0,"?????????????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"??????????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));
                
                ws.addCell(new jxl.write.Label(j++,0,"??????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"??????????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"??????????????????",wcf));
                
                
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"????????????-???-???",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"????????????-???",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));
                
                
                
              
                
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));
                
                
                
                
                
                
                //????????????
                
                if(teasession.getParameter("cidorder")!=null && teasession.getParameter("cidorder").length()>0)
                {
                	String cb []  = teasession.getParameterValues("cidorder");
                	
                	for(int i2 =0;i2<cb.length;i2++)
                	{
                		 String cid = cb[i2];
                         Contributions cobj = Contributions.find(cid);
                		int jj =0;
                		String is = "?????????";
                		if(cobj.getIsinvoice()==2){
                			is="???";
                			}else if(cobj.getIsinvoice()==1){
                				is = "???";
                			}
                		
	                		 String dname= "";
	               		  if(cobj.getDonationmethods()!=4)
	               		  {
	               			  dname=Contributions.DONATION_METHODS[cobj.getDonationmethods()];
	               		  }else{
	               			  dname="??????/"+cobj.getDmname();
	               		  }
	               		  String cname= "";
	               		  if(cobj.getCurrency()!=1)
	               		  {
	               			  cname = Contributions.CURRENCY_TYPE[cobj.getCurrency()];
	               		  }else
	               		  {
	               			  cname= "??????/"+cobj.getCurrencyname();
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
                    	String is = "?????????";
                		if(cobj.getIsinvoice()==2){
                			is="???";
                			}else if(cobj.getIsinvoice()==1){
                				is = "???";
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
                			  dname="??????/"+cobj.getDmname();
                		  }
                		  ws.addCell(new jxl.write.Label(jj++,i + 1,dname));
                		   
                		  
                		  ws.addCell(new jxl.write.Label(jj++,i + 1,String.valueOf(cobj.getPaymoney())));
                		  String cname= "";
                		  if(cobj.getCurrency()!=1)
                		  {
                			  cname = Contributions.CURRENCY_TYPE[cobj.getCurrency()];
                		  }else
                		  {
                			  cname= "??????/"+cobj.getCurrencyname(); 
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
                
			}else if("Contributions2".equals(act))//????????? ???????????? ??????????????????
			{
				ws.setColumnView(0, 20); // ??????????????????
				ws.setColumnView(1, 20); // ??????????????????
				ws.setColumnView(2, 20); // ??????????????????
				
				ws.setColumnView(3, 20); // ??????????????????
				ws.setColumnView(4, 20); // ??????????????????
				ws.setColumnView(5, 20); // ??????????????????
				
				ws.setColumnView(6, 20); // ??????????????????
				ws.setColumnView(7, 20); // ??????????????????
				ws.setColumnView(8, 20); // ??????????????????
				ws.setColumnView(9, 20); // ??????????????????
			
				
 
                ws.addCell(new jxl.write.Label(j++,0,"?????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"??????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"???????????????/?????? ",wcf));
               
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"????????????-???-???",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"????????????-???",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));
             
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));

                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));
                
                
                
                
                
                
                //????????????
                
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
			
			else if("WomenMember".equals(act))//?????????????????????
			{
 
				ws.setColumnView(0, 20); // ??????????????????
				ws.setColumnView(1, 20); // ??????????????????
				ws.setColumnView(2, 20); // ??????????????????
				ws.setColumnView(3, 20); // ??????????????????
				ws.setColumnView(4, 20); // ??????????????????
				ws.setColumnView(5, 20); // ??????????????????
				ws.setColumnView(6, 20); // ??????????????????
				ws.setColumnView(7, 20); // ??????????????????
				ws.setColumnView(8, 20); // ??????????????????
				ws.setColumnView(9, 20); // ??????????????????
				ws.setColumnView(10, 20); // ??????????????????
				

                ws.addCell(new jxl.write.Label(j++,0,"?????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"???????????? ",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"?????? ",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"?????? ",wcf));
      
                ws.addCell(new jxl.write.Label(j++,0,"?????????????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"??????????????????????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"??????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"??????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"??????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"??????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));
    
      	

                //????????????
        
                if(teasession.getParameter("memberorder")!=null && teasession.getParameter("memberorder").length()>0)
                {
                	String tal []  = teasession.getParameterValues("memberorder");
                	
                	for(int i2 =0;i2<tal.length;i2++)
                	{
                		String memberorder =tal[i2];
                	    MemberOrder  moobj = MemberOrder.find(memberorder);
                	    Profile pobj = Profile.find(moobj.getMember());
                	    String s ="???";
                	    if(!pobj.isSex())
                	    {
                	    	s = "???";
                	    }
                	   
                	  
                	   //?????????????????????
                	    String istr = "???";
                	    if(moobj.getNewsletter()==0){
                	    	istr = "???";
                	    }
                	    //??????????????????????????????
                	    String abs = "???";
                	    if(moobj.getAbstracts()==0){
                	    	abs = "???";
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
                }else//sql ????????????
                { 
                	
                	Enumeration e =MemberOrder.findMP(teasession._strCommunity,sql.toString(),0,Integer.MAX_VALUE); 
          
                	while ( e.hasMoreElements()) {
                		String memberorder =((String)e.nextElement());
                	    MemberOrder  moobj = MemberOrder.find(memberorder);
                	    Profile pobj = Profile.find(moobj.getMember());
                	    String s ="???";
                	    if(!pobj.isSex())
                	    {
                	    	s = "???";
                	    }

                 	   //?????????????????????
                 	    String istr = "???";
                 	    if(moobj.getNewsletter()==0){
                 	    	istr = "???";
                 	    }
                 	    //??????????????????????????????
                 	    String abs = "???";
                 	    if(moobj.getAbstracts()==0){
                 	    	abs = "???";
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
				//??????????????????????????????
				ws.setColumnView(a++, 20); // ??????????????????
				ws.setColumnView(a++, 20); // ??????????????????
				ws.setColumnView(a++, 20); // ??????????????????
				ws.setColumnView(a++, 20); // ??????????????????
				ws.setColumnView(a++, 20); // ??????????????????
				ws.setColumnView(a++, 20); // ??????????????????
				ws.setColumnView(a++, 20); // ??????????????????
				ws.setColumnView(a++, 20); // ??????????????????
				ws.setColumnView(a++, 20); // ??????????????????
				ws.setColumnView(a++, 20); // ??????????????????
				ws.setColumnView(a++, 20); // ??????????????????
				ws.setColumnView(a++, 20); // ??????????????????
				ws.setColumnView(a++, 20); // ?????????????????? 
				ws.setColumnView(a++, 20); // ??????????????????
				ws.setColumnView(a++, 20); // ??????????????????
				ws.setColumnView(a++, 20); // ??????????????????
				ws.setColumnView(a++, 20); // ??????????????????
				ws.setColumnView(a++, 20); // ??????????????????
				ws.setColumnView(a++, 20); // ??????????????????
				ws.setColumnView(a++, 20); // ??????????????????
				ws.setColumnView(a++, 20); // ??????????????????
				ws.setColumnView(a++, 20); // ??????????????????
				ws.setColumnView(a++, 20); // ??????????????????
				ws.setColumnView(a++, 20); // ??????????????????
				ws.setColumnView(a++, 20); // ??????????????????
				ws.setColumnView(a++, 20); // ??????????????????
				ws.setColumnView(a++, 20); // ??????????????????
				ws.setColumnView(a++, 20); // ??????????????????
				ws.setColumnView(a++, 20); // ??????????????????
				ws.setColumnView(a++, 20); // ??????????????????
				ws.setColumnView(a++, 20); // ??????????????????

                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"E-mail ",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"????????? ",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"?????? ",wcf));
      
                ws.addCell(new jxl.write.Label(j++,0,"??????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"??????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"???????????????",wcf));
                
                ws.addCell(new jxl.write.Label(j++,0,"??????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"??????",wcf));
                
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"???????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"???????????????",wcf));
                
                
                
                ws.addCell(new jxl.write.Label(j++,0,"??????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"QQ",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"?????????????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"??????????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));
                
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));
                
                ws.addCell(new jxl.write.Label(j++,0,"???????????????(??????)",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"???????????????(??????)",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"???????????????(??????)",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"???????????????(??????)",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"???????????????(??????)",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"???????????????(??????)",wcf));
                
                
                ws.addCell(new jxl.write.Label(j++,0,"????????????(??????)",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"????????????(??????)",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"????????????(?????????)",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"????????????(????????????)",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"??????",wcf));
              
                
                
                
                
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
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.isSex()?"???":"???"));
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
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getSfshanggang()==0?"???":"???"));
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
                }else//sql ????????????
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
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.isSex()?"???":"???"));
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
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getSfshanggang()==0?"???":"???"));
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
				//????????????????????? ????????????
				
				
				ws.setColumnView(a++, 20); // ??????????????????
				ws.setColumnView(a++, 20); // ??????????????????
				ws.setColumnView(a++, 20); // ??????????????????
				ws.setColumnView(a++, 20); // ??????????????????
				ws.setColumnView(a++, 20); // ??????????????????
				ws.setColumnView(a++, 20); // ??????????????????
				ws.setColumnView(a++, 20); // ??????????????????
				ws.setColumnView(a++, 20); // ??????????????????
				ws.setColumnView(a++, 20); // ??????????????????
            
                
                ws.addCell(new jxl.write.Label(j++,0,"????????? ",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"?????? ",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"??????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"??????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"??????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"E-mail ",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"??????",wcf));
               
              
                
                
                
                
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
	          		      ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.isSex()?"???":"???"));
	          		      ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getBirth()!=null?Entity.sdf.format(pobj.getBirth()):""));
	          		      ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getMobile()));
	            		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getEmail()));
	            		  ws.addCell(new jxl.write.Label(cc++,i + 1,Card.find(pobj.getProvince(teasession._nLanguage)).toString2()+pobj.getAddress(teasession._nLanguage)));
	            		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getTelephone(teasession._nLanguage)));
	            		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getZip(teasession._nLanguage)));
                
                          i++;
                		
                	}
                }else//sql ????????????
                { 
                	
                	
                	 java.util.Enumeration e = Profile.find(MT.dec(sql.toString()),0,Integer.MAX_VALUE);
          
                	while ( e.hasMoreElements()) {
                
                		String member =((String)e.nextElement());
                   	 
                		int cc =0;
                	    Profile pobj = Profile.find(member);

	        	    	  ws.addCell(new jxl.write.Label(cc++,i + 1,member));
	        	    	  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.getFirstName(teasession._nLanguage)));
	          		      ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.isSex()?"???":"???"));
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
				// ?????????  ?????????????????????
				ws.setColumnView(a++, 20); // ??????????????????
				ws.setColumnView(a++, 20); // ??????????????????
				ws.setColumnView(a++, 20); // ??????????????????
				ws.setColumnView(a++, 20); // ??????????????????
				ws.setColumnView(a++, 20); // ??????????????????
				ws.setColumnView(a++, 20); // ??????????????????
				ws.setColumnView(a++, 20); // ??????????????????
				ws.setColumnView(a++, 20); // ??????????????????
				ws.setColumnView(a++, 20); // ??????????????????
				ws.setColumnView(a++, 20); // ??????????????????
				ws.setColumnView(a++, 20); // ??????????????????
				ws.setColumnView(a++, 20); // ??????????????????
				ws.setColumnView(a++, 20); // ??????????????????
				ws.setColumnView(a++, 20); // ??????????????????
				ws.setColumnView(a++, 20); // ??????????????????
				ws.setColumnView(a++, 20); // ??????????????????
				ws.setColumnView(a++, 20); // ??????????????????
				ws.setColumnView(a++, 20); // ??????????????????
				ws.setColumnView(a++, 20); // ??????????????????
				ws.setColumnView(a++, 20); // ??????????????????
				ws.setColumnView(a++, 20); // ??????????????????
				ws.setColumnView(a++, 20); // ?????????????????? 
				ws.setColumnView(a++, 20); // ?????????????????? 
				
				ws.setColumnView(a++, 20); // ?????????????????? 
				ws.setColumnView(a++, 20); // ?????????????????? 
				
				ws.setColumnView(a++, 20); // ?????????????????? 
				ws.setColumnView(a++, 20); // ?????????????????? 
				ws.setColumnView(a++, 20); // ?????????????????? 
				ws.setColumnView(a++, 20); // ?????????????????? 
				ws.setColumnView(a++, 20); // ?????????????????? 
				ws.setColumnView(a++, 20); // ?????????????????? 
				ws.setColumnView(a++, 20); // ?????????????????? 
				ws.setColumnView(a++, 20); // ?????????????????? 
				ws.setColumnView(a++, 20); // ?????????????????? 

                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"E-mail ",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"????????? ",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"?????? ",wcf));
      
                ws.addCell(new jxl.write.Label(j++,0,"??????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"??????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"???????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"???????????????",wcf));
                
                
                
                ws.addCell(new jxl.write.Label(j++,0,"??????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"QQ",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"?????????????????????",wcf));
                
                ws.addCell(new jxl.write.Label(j++,0,"??????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"??????or????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"?????????(?????????????????????????????????)",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"??????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"?????????????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"?????? ???????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"?????????????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"?????????????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"?????????????????????",wcf));
                
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"??????logo?????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"??????????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"?????????????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));
                ws.addCell(new jxl.write.Label(j++,0,"????????????",wcf));
                
                
                
                
              
                
                
                
                
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
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.isSex()?"???":"???"));
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
                }else//sql ????????????
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
                		  ws.addCell(new jxl.write.Label(cc++,i + 1,pobj.isSex()?"???":"???"));
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
