package tea.ui.node.talkback;

import java.io.IOException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import tea.entity.node.Node;
import tea.entity.node.Report;
import tea.entity.node.Talkback;
import tea.entity.node.TalkbackReply;
import tea.ui.TeaSession;

public class EditTalkbackReply extends HttpServlet
{

    //Initialize global variables
    public void init() throws ServletException
    {
    }

    //Process the HTTP Get request
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        TeaSession teasession = new TeaSession(request);
        response.setContentType("text/html;charset=UTF-8");
        
        try
        {
            String act = request.getParameter("act");
            String nexturl = teasession.getParameter("nexturl");
            
            int trid = 0;
			if(teasession.getParameter("talkbackreply")!=null && teasession.getParameter("talkbackreply").length()>0)
			{
				trid = Integer.parseInt(request.getParameter("talkbackreply"));
			}

            int talkback = 0;
            if(teasession.getParameter("talkback")!=null && teasession.getParameter("talkback").length()>0)
            {
            	talkback = Integer.parseInt(request.getParameter("talkback"));
            }
           // if ("delete".equals(act))
           // {
                //TalkbackReply obj = TalkbackReply.find(trid);
               // obj.delete();
           // }else 
            if("EditTalkbackReply".equals(act))
            {
        	int t = Integer.parseInt(teasession.getParameter("trid"));
        	TalkbackReply obj = TalkbackReply.find(t);
        	String reply = teasession.getParameter("reply");
        	obj.set(reply); 
        	int hidden = Integer.parseInt(teasession.getParameter("hidden"));
        	obj.setHidden(hidden);
        	
        	obj.set(teasession._rv.toString(),new Date());
        	
        	    java.io.PrintWriter out = response.getWriter();
        			out.print("<script  language='javascript'>alert('操作成功!');window.location.href='" + nexturl + "';</script> ");
        			out.close();
        			return;
        	
        	
            }else 
            if(teasession.getParameter("tkid")!=null && teasession.getParameter("tkid").length()>0)// 说明是后台提交数据
            {
				if (teasession._rv == null)
				{
					response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode + "&nexturl=" + request.getRequestURI() + "?" + request.getQueryString());
					return;
				}
            	String tr_check [] =teasession.getParameterValues("tr_check");
            	if(tr_check!=null)
            	{
            		String next_str = "操作成功";
            		  for(int index = 0;index < tr_check.length;index++)
                      {
                          int t = Integer.parseInt(tr_check[index]);
                          TalkbackReply trobj = TalkbackReply.find(t);
            
                          if("delete".equals(act))
                          {
                        	  trobj.delete();
                             // next_str ="删除操作成功";
                              
                          }else if("audit".equals(act))//审核 显示
                          {
                          	if(trobj.getHidden()==0)
                          	{
                          		// next_str ="审核操作成功";
                          		trobj.setHidden(1);
                          		trobj.set(teasession._rv.toString(),new Date());
                          	}else
                          	{
                          		next_str ="抱歉!您审核的评论回复里面有【已审核或已拒绝】的评论回复.\\n系统只能审核【未审核】的评论回复!";
                          	}
                          	
                          }else if("cancel_audit".equals(act))//还原
                          {
                        	  
                          	if(trobj.getHidden()!=0)
                          	{
                          		// next_str ="还原操作成功";
                          		trobj.setHidden(0);
                          		trobj.set("",null);
                          	}else 
                          	{
                          		next_str ="抱歉!您还原的评论回复里面有【未审核】的评论回复.\\n系统只能还原【已审核或已拒绝】的评论回复!";
                          	}
                          } else if("refusal".equals(act))//拒绝
                          {
                          	if(trobj.getHidden()==2)
                          	{
                          		next_str ="抱歉!您拒绝的评论回复里面有【拒绝】的评论回复.\\n系统只能拒绝【未拒绝】的评论回复!";
                          	}else
                          	{
                          		// next_str ="拒绝操作成功";
                          		trobj.setHidden(2);
                          		trobj.set(teasession._rv.toString(),new Date()); 
                          	}
                          }
                      } 
            		  java.io.PrintWriter out = response.getWriter();
      				out.print("<script  language='javascript'>alert('" + next_str + "');window.location.href='" + nexturl + "';</script> ");
      				out.close();
      				return;
            	}
            	
            	
            }
            
            else
            { 
            	
            	 HttpSession session = request.getSession(true);
            	 Node node = Node.find(Talkback.find(talkback).getNode());
                 boolean flagl = (node.getOptions() & 0x8000) != 0; //ANONYMITY评论
                 
            	String member =session.getId();
              
                String tourist = teasession.getParameter("tourist2");//是否选中游客评论

                
                if(tourist!=null && tourist.length()>0)//选中了直接评论
                {
                	
                }else if(!flagl){//需要登录 评论
                	 
                		 if(teasession._rv == null)
                		 {
                			 response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
                			 return;
                		 }else
                		 {
                			 
                			 member = teasession._rv._strR;
                            
                		 }
                }
            	
                String ft = request.getParameter("formattype");
                String text = request.getParameter("reply");
                
                if (ft == null || ft.length() == 0)
                {
                    text = text.replaceAll("\r\n", "<BR>").replaceAll("  ", " &nbsp;");
                }
                
                text =  Report.getHtml2(text); 
                if (trid == 0) 
                {
                    TalkbackReply.create(talkback, member, text,0,request.getRemoteAddr(),null,null);
                } else
                { 
                    TalkbackReply obj = TalkbackReply.find(trid);
                    obj.set(text);
                }
            } 
            if (nexturl != null&&nexturl.length()>0)
            {
                response.sendRedirect(nexturl);
            } else
            {
                response.sendRedirect("/jsp/talkback/Talkback.jsp?node=" + teasession._nNode + "&talkback=" + talkback);
            }
        } catch (Exception ex)
        {
            ex.printStackTrace();
        }
    }

    //Clean up resources
    public void destroy()
    {
    }
}
