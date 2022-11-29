package tea.ui.admin;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import tea.entity.admin.Flowitem;
import tea.entity.admin.ProjectNotPay;
import tea.entity.netdisk.FileCenter;
import tea.entity.netdisk.FileCenterAttach;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class EditFlowitem extends TeaServlet
{
	// Initialize global variables
	public void init() throws ServletException
	{
	}

	// Process the HTTP Get request
	public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
	{
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		TeaSession teasession = new TeaSession(request);
		if(teasession._rv == null)
		{
			response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
			return;
		}
		HttpSession session = request.getSession();
		String act = teasession.getParameter("act");
		String act2 = teasession.getParameter("act2");
		String nexturl = teasession.getParameter("nexturl");
		String contractnexturl = teasession.getParameter("contractnexturl");
		int flowitem = 0;
		if(teasession.getParameter("flowitem") != null && teasession.getParameter("flowitem").length() > 0)
			flowitem = Integer.parseInt(teasession.getParameter("flowitem"));
		int workproject = 0;
		if(teasession.getParameter("workproject") != null && teasession.getParameter("workproject").length() > 0)
			workproject = Integer.parseInt(teasession.getParameter("workproject"));

		try
		{

			//非项目及人工支出
			if("EditProjectNotPay".equals(act))
			{
                int id=0;
                if(teasession.getParameter("ids")!=null && teasession.getParameter("ids").length()>0)
				{
					id = Integer.parseInt(teasession.getParameter("ids"));
				}
				BigDecimal paymoney=new BigDecimal("0");
				if(teasession.getParameter("paymoney") != null && teasession.getParameter("paymoney").length() > 0)
				{
					paymoney = new java.math.BigDecimal(teasession.getParameter("paymoney"));
				}

                Date paydate=new  Date();
				if(teasession.getParameter("paydate")!=null && teasession.getParameter("paydate").length()>0)
				{
					paydate= ProjectNotPay.sdf.parse(teasession.getParameter("paydate"));
				}

				String payinfo="";
				if(teasession.getParameter("payinfo")!=null && teasession.getParameter("payinfo").length()>0)
				{
					payinfo=teasession.getParameter("payinfo");
				}
                int paytype=0;
				if(teasession.getParameter("paytype")!=null && teasession.getParameter("paytype").length()>0)
				{
					paytype = Integer.parseInt(teasession.getParameter("paytype"));
				}
                String receives="";
				if(teasession.getParameter("receives")!=null && teasession.getParameter("receives").length()>0)
				{
					receives=teasession.getParameter("receives");
				}

                String member="";
                if(teasession.getParameter("member") != null && teasession.getParameter("member").length() > 0)
                {
                    member = teasession.getParameter("member");
                }

                String community=teasession._strCommunity;

				ProjectNotPay.set(id,paymoney,paydate,payinfo,paytype,receives,member,community);
                response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("提交成功！","UTF-8") + "&nexturl=/jsp/admin/flow/ProjectNotPay.jsp");
                return;
			}

			//添加项目
			Flowitem obj = Flowitem.find(flowitem);
			if("EditFlowitem".equals(act2))
			{

				String content = (teasession.getParameter("content"));
				String manager = (teasession.getParameter("manager"));
				String name = teasession.getParameter("name");
				String member = teasession.getParameter("member");
				int itemgenre = 0;
				if(teasession.getParameter("itemgenre") != null && teasession.getParameter("itemgenre").length() > 0)
					itemgenre = Integer.parseInt(teasession.getParameter("itemgenre"));

				java.util.Date ftime = Flowitem.sdf.parse(teasession.getParameter("ftimeYear") + "-" + teasession.getParameter("ftimeMonth") + "-" + teasession.getParameter("ftimeDay"));
				int cost = 0;
				if(teasession.getParameter("cost") != null && teasession.getParameter("cost").length() > 0)
					cost = Integer.parseInt(teasession.getParameter("cost"));
				int overallmoney = 0;
				if(teasession.getParameter("overallmoney") != null && teasession.getParameter("overallmoney").length() > 0)
					overallmoney = Integer.parseInt(teasession.getParameter("overallmoney"));
				String pact = teasession.getParameter("pact");

				BigDecimal vindicate = new BigDecimal("0");
				if(teasession.getParameter("vindicate") != null && teasession.getParameter("vindicate").length() > 0)
				{
					vindicate = new BigDecimal(teasession.getParameter("vindicate"));
				}
				int period = Integer.parseInt(teasession.getParameter("period"));
				java.util.Date nextcosttime = Flowitem.sdf.parse(teasession.getParameter("nextcosttimeYear") + "-" + teasession.getParameter("nextcosttimeMonth") + "-" + teasession.getParameter("nextcosttimeDay"));
				java.util.Date pacttime = Flowitem.sdf.parse(teasession.getParameter("pacttimeYear") + "-" + teasession.getParameter("pacttimeMonth") + "-" + teasession.getParameter("pacttimeDay"));
				java.util.Date lastcosttime = Flowitem.sdf.parse(teasession.getParameter("lastcosttimeYear") + "-" + teasession.getParameter("lastcosttimeMonth") + "-" + teasession.getParameter("lastcosttimeDay"));
				
				//合同附件
				String pactfile = null;
				String pactfilename = null;
				boolean f = false;
				int filecenter = Integer.parseInt(teasession.getParameter("filecenter"));
				if(teasession.getParameter("clear1") != null)
				{
					filecenter = 0;
				} else if(teasession.getParameter("pactfile") != null)
				{
					pactfile = teasession.getParameter("pactfile");
					pactfilename = teasession.getParameter("pactfileName");
					f = true;
				} else
				{
					pactfile = obj.getPactfile();
					pactfilename = obj.getPactfilename();
					f = true;
				}

                // 其它成本:otherexpenses
                java.math.BigDecimal otherexpenses = new java.math.BigDecimal("0");
                if(teasession.getParameter("otherexpenses") != null && teasession.getParameter("otherexpenses").length() > 0)
                {
                    otherexpenses = new java.math.BigDecimal(teasession.getParameter("otherexpenses"));
                }
                // 其它成本说明:otherexplain
                String otherexplain = teasession.getParameter("otherexplain");
                //市场费用:marketcost
                java.math.BigDecimal marketcost = new java.math.BigDecimal("0");
                if(teasession.getParameter("marketcost") != null && teasession.getParameter("marketcost").length() > 0)
                {
                    marketcost = new java.math.BigDecimal(teasession.getParameter("marketcost"));
                }
                //  市场费用说明:marketexplain
                String marketexplain = teasession.getParameter("marketexplain");
                //预计利润:profits
                java.math.BigDecimal profits = new java.math.BigDecimal("0");
                if(teasession.getParameter("profits") != null && teasession.getParameter("profits").length() > 0)
                {
                    profits = new java.math.BigDecimal(teasession.getParameter("profits"));
                }

				if(flowitem > 0)
				{
					int type = obj.getType();
					if(nextcosttime.compareTo(obj.getNextcosttime()) != 0)
					{
						type = 0;
					}

					if(f && pactfile != null) //如果修改客户项目时候 ，附件没有改变
					{
						if(filecenter == obj.getFilecenter()) //合同文档的路径没有改变
						{
							String ex = pactfilename.substring(pactfilename.lastIndexOf(".") + 1).toLowerCase();
							FileCenter fceobj = FileCenter.find(obj.getFileid());
							fceobj.set(name + "的合同",pact,true,fceobj.getTime(),"",null,"");
							FileCenterAttach.delete(obj.getFileid()); //关于上次的附近全部删除
							FileCenterAttach.create(obj.getFileid(),member,pactfilename,ex,pactfile); //在添加一个附件
						} else if(filecenter != 0) ////改变了合同文档的  文件夹
						{
							FileCenter fceobj = FileCenter.find(obj.getFileid());
							fceobj.delete(); //先删除上次的文档
							FileCenterAttach.delete(obj.getFileid());
							//添加这次的文档路径
							String ex = pactfilename.substring(pactfilename.lastIndexOf(".") + 1).toLowerCase();
							int fileid = FileCenter.create(teasession._strCommunity,filecenter,true,member,true,name + "的合同",pact,true,new java.util.Date(),"",null,"");
							FileCenterAttach.create(fileid,member,pactfilename,ex,pactfile);
							obj.setFileid(fileid);
						}
					} else
					{
						FileCenter fceobj = FileCenter.find(obj.getFileid());
						fceobj.delete();
						FileCenterAttach.delete(obj.getFileid());
						obj.setFileid(0);
					}
					obj.set(manager,workproject,member,obj.getCreator(),ftime,teasession._nLanguage,name,content,itemgenre,cost,overallmoney,pact,
							vindicate,nextcosttime,period,type,pacttime,pactfile,pactfilename,filecenter,
							otherexpenses,otherexplain,marketcost,marketexplain,profits,lastcosttime);
					Flowitem.setEatype2(flowitem);
				} else
				{
					int fileid = 0;
					if(pactfile != null && filecenter > 0) //如果有附近才能添加到文件中心里面
					{
						String ex = pactfilename.substring(pactfilename.lastIndexOf(".") + 1).toLowerCase();
						fileid = FileCenter.create(teasession._strCommunity,filecenter,true,member,true,name + "的合同",pact,true,new java.util.Date(),"",null,"");
						FileCenterAttach.create(fileid,member,pactfilename,ex,pactfile);
					}
                    obj.create(teasession._strCommunity,workproject,manager,member,teasession._rv.toString(),
                               ftime,teasession._nLanguage,name,content,itemgenre,cost,overallmoney,pact,
                               vindicate,nextcosttime,period,0,pacttime,pactfile,pactfilename,filecenter,fileid,
                               otherexpenses,otherexplain,marketcost,marketexplain,profits,lastcosttime);
				}

			}else if("delete".equals(act2))
			{
				obj.delete();
			}

			if("edit".equals(teasession.getParameter("act")))
			{
				response.sendRedirect(nexturl);
				return;
			}
			response.sendRedirect(nexturl + "&workproject=" + workproject + "&nexturl=" + contractnexturl);
			return;

		} catch(Exception ex)
		{
			ex.printStackTrace();
		}
	}

	// Clean up resources
	public void destroy()
	{
	}
}
