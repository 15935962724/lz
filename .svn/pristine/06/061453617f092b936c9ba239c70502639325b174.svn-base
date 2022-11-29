package tea.ui.admin.flow;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.ui.*;
import tea.db.*;
import tea.entity.admin.*;
import tea.entity.*;
import tea.entity.node.*;
import tea.entity.site.*;
import java.sql.SQLException;
import net.mietian.convert.*;
import tea.entity.util.*;

public class EditFlowdynamicvalue extends TeaServlet
{

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html; charset=utf-8");
        String act = request.getParameter("act");
        ServletContext application = getServletContext();
        TeaSession teasession = new TeaSession(request);
        try
        {
            if("exclusive".equals(act)) //去掉独占记录//////
            {
                int flowbusiness = Integer.parseInt(request.getParameter("flowbusiness"));
                Flowbusiness fb = Flowbusiness.find(flowbusiness);
                fb.setExclusive(null);
                return;
            }
            if(teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            if("down".equals(act))
            {
                response.setContentType("application/octet-stream");
                response.setHeader("Content-Disposition","attachment; filename=" + new String("红头+附件.zip".getBytes("GBK"),"ISO-8859-1"));
                int flowbusiness = Integer.parseInt(request.getParameter("flowbusiness"));
                String[] dt = request.getParameter("dynamictype").split("/");
                //附件
                ArrayList al = DynamicValue.find( -flowbusiness,teasession._nLanguage,Integer.parseInt(dt[2])).findMulti("");
                File[] fs = new File[al.size() + 1];
                for(int i = 0;i < al.size();i++)
                {
                    DynamicValue.Multi dvm = (DynamicValue.Multi) al.get(i);
                    fs[i + 1] = new File(application.getRealPath(dvm.getValue()));
                }
                //
                Flowbusiness fb = Flowbusiness.find(flowbusiness);
                //DynamicValue av = DynamicValue.find( -flowbusiness,teasession._nLanguage,Integer.parseInt(dt[1]));
                //av.getValue()
                fs[0] = new File(application.getRealPath(fb.getTape2()));
                //
                Zip z = new Zip(response.getOutputStream());
                z.rename.put(fs[0],"红头文件.doc");
                z.zip(fs);
                return;
            }
        } catch(Exception ex)
        {
            ex.printStackTrace();
        }
        PrintWriter out = response.getWriter();
        try
        {
            String nu = teasession.getParameter("nexturl");
            teasession.getSession().setAttribute("isshowtag","0");
            String member = teasession._rv._strV;
            if("ajax_opinion".equals(act)) //办理意见   EditFlowDispatch.jsp
            {
                int flowbusiness = Integer.parseInt(request.getParameter("flowbusiness"));
                String dt = request.getParameter("dynamictype");
                String dts[] = dt.split("/");
                for(int i = 1;i < dts.length;i++)
                {
                    String ids[] = dts[i].split(",");
                    DynamicValue dv[] = new DynamicValue[ids.length];
                    for(int j = 0;j < ids.length;j++)
                    {
                        int dtid = Integer.parseInt(ids[j]);
                        dv[j] = DynamicValue.find( -flowbusiness,teasession._nLanguage,dtid);
                        ids[j] = MT.f(dv[j].getValue());
                        //刷新"基本信息"中的签名
                        if(ids[j].startsWith("/res/") && "sign".equals(DynamicType.find(dtid).getType()))
                        {
                            out.println("var tmp=$('td" + dtid + "');if(tmp)tmp.innerHTML=\"<img src='" + ids[j] + "' oncontextmenu='return false' />\";");
                        }
                    }
                    //
                    Enumeration e = dv[0].findMulti("",0,Integer.MAX_VALUE);
                    if(e.hasMoreElements())
                    {
                        while(e.hasMoreElements())
                        {
                            DynamicValue.Multi m = (DynamicValue.Multi) e.nextElement();
                            ids[0] = m.getValue();
                            String dvm = m.getMember();
                            Enumeration e1 = dv[1].findMulti(" AND member=" + DbAdapter.cite(dvm),0,1);
                            if(e1.hasMoreElements())
                            {
                                ids[1] = ((DynamicValue.Multi) e1.nextElement()).getValue();
                            }
                            Enumeration e2 = dv[2].findMulti(" AND member=" + DbAdapter.cite(dvm),0,1);
                            if(e2.hasMoreElements())
                            {
                                ids[2] = ((DynamicValue.Multi) e2.nextElement()).getValue();
                            }
                            out.println(js_opinion(ids));
                        }
                        continue;
                    }
                    out.println(js_opinion(ids));
                }
                return;
            } else if("ajax_csign".equals(act)) //办理意见->会签意见  EditFlowDispatch.jsp
            {
                int flowbusiness = Integer.parseInt(request.getParameter("flowbusiness"));
                Enumeration dce = DynamicCsign.find( -flowbusiness,0);
                if(!dce.hasMoreElements())
                {
                    out.print("    var tr=document.createElement('TR'); ");
                    out.print("    var td=document.createElement('TD'); ");
                    out.print("    td.innerHTML=\"" + "没有意见" + "\"; ");
                    out.print("    tr.appendChild(td); ");
                } while(dce.hasMoreElements())
                {
                    DynamicCsign dc = (DynamicCsign) dce.nextElement();
                    String v0 = dc.getContent();
                    String v1 = MT.f(dc.getSign());
                    int dcc = dc.getComment();
                    //
                    out.print("    var tr=document.createElement('TR'); ");
                    out.print("    var td=document.createElement('TD'); ");
                    out.print("    td.innerHTML=\"" + dc.getStartTimeToString() + "\"; ");
                    out.print("    tr.appendChild(td); ");
                    //会签人员
                    out.print("    td=document.createElement('TD'); ");
                    out.print("    td.innerHTML=\"" + dc.member + "\"; ");
                    out.print("    tr.appendChild(td); ");
                    //意见
                    out.print("    td=document.createElement('TD'); ");
                    out.print("    td.innerHTML=\"" + MT.f(dcc == 2 ? v0 : DynamicCsign.COMMENT_TYPE[dcc],"无").replaceAll("\r\n","<br/>") + "\"; ");
                    out.print("    tr.appendChild(td); ");
                    //签名
                    out.print("    td=document.createElement('TD'); ");
                    if(v1.length() > 0)
                    {
                        String str = v1.startsWith("/res/") ? "<img src='" + v1 + "' oncontextmenu='return false'>" : v1;
                        if(member.equals(dc.member))
                            str += "<input type='hidden' name='dynamictype" + dc.dynamictype + "_2' value='" + v1 + "' />";
                        out.print("    td.innerHTML=\"" + str + "\"; ");
                    }
                    out.print("    tr.appendChild(td); ");
                    out.print("    td=document.createElement('TD'); ");
                    out.print("    td.innerHTML=\"" + dc.getEndTimeToString() + "\"; ");
                    out.print("    tr.appendChild(td); ");
                    out.print("    document.getElementById('" + act + "').appendChild(tr);");
                }
                return;
            } else if("ajax_key".equals(act)) //提取关键字
            {
                String dt = request.getParameter("dynamictype");
                String str = request.getParameter("str");
                str = str.replaceAll("关于|第|期|中国|公司","");
                str = Phrase.findKey(str);
                out.print("document.all('dynamictype" + dt + "').value=\"" + str.replace(' ','　') + "\";");
                return;
            } else if("delete".equals(act)) //撤消： 第一步，删除
            {
                int flowbusiness = Integer.parseInt(request.getParameter("flowbusiness"));
                Flowbusiness fb = Flowbusiness.find(flowbusiness);
                fb.delete();
                response.sendRedirect(request.getParameter("nexturl"));
                return;
            } else if("reading".equals(act)) //阅毕
            {
                int flowview = Integer.parseInt(request.getParameter("flowview"));
                Flowview.find(flowview).setState(2);
                response.sendRedirect(nu);
                return;
            }
            //start
            int prev = Integer.parseInt(teasession.getParameter("prev"));
            int flow = Integer.parseInt(teasession.getParameter("flow"));
            int flowbusiness = 0;
            String tmp = teasession.getParameter("flowbusiness");
            if(tmp != null && tmp.length() > 0)
            {
                flowbusiness = Integer.parseInt(tmp);
            }
            Flow f = Flow.find(flow);
            Dynamic d = Dynamic.find(f.getDynamic());
            if(flowbusiness < 1)
            {
                int flowitem = 0;
                try
                {
                    flowitem = Integer.parseInt(teasession.getParameter("flowitem"));
                } catch(NumberFormatException ex1)
                {
                }
                Date time = new Date();
                int adminunitorg = 0; //Integer.parseInt(teasession.getParameter("adminunitorg"));
                if(teasession.getParameter("adminunitorg") != null && teasession.getParameter("adminunitorg").length() > 0)
                {
                    adminunitorg = Integer.parseInt(teasession.getParameter("adminunitorg"));
                }
                flowbusiness = Flowbusiness.create(teasession._strCommunity,flowitem,flow,prev,time,adminunitorg,member,f.getName(teasession._nLanguage) + ":" + Flowbusiness.sdf2.format(time));
            }
            Flowbusiness fb = Flowbusiness.find(flowbusiness);
            Flowprocess fp = Flowprocess.find(flow,fb.getStep());
            //如果事务绑订了输入框///////////////////////////
            StringBuffer sbn = new StringBuffer();
            String dtfb[] = d.getDtfb().split("/");
            for(int i = 1;i < dtfb.length;i++)
            {
                DynamicType dt = DynamicType.find(Integer.parseInt(dtfb[i]));
                if(!dt.isExists())
                    continue;
                String name = teasession.getParameter("dynamictype" + dtfb[i]);
                if(name == null) //非可编辑
                    name = DynamicValue.find( -flowbusiness,teasession._nLanguage,Integer.parseInt(dtfb[i])).getValue();
                if(name == null || name.length() < 1)
                    continue;
                int dv = dt.getDefaultvalue();
                if(dv == 5 || dv == 6 || dv == 10) //如果是节点号
                {
                    try
                    {
                        name = Node.find(Integer.parseInt(name)).getSubject(teasession._nLanguage);
                    } catch(Exception ex)
                    {}
                }
                sbn.append(name).append(" ");
            }
            if(dtfb.length > 1) //更改事物名称////
                fb.setName(sbn.toString());

            //更改编辑状态///////
            Flowview fv = Flowview.find(flowbusiness,fp.getFlowprocess(),member);
            if(fv.isExists())
            {
                fv.setState(1);
            }
            //绑定的是那个节点/////
            int bindnode = 0;
            tmp = teasession.getParameter("binding"); //绑定的是那个DT
            if(tmp != null)
            {
                int dt = Integer.parseInt(tmp);
                tmp = teasession.getParameter("dynamictype" + dt);
                if(tmp == null) //有可能当前步骤,节点并非可编辑
                {
                    DynamicValue dv_b = DynamicValue.find( -flowbusiness,teasession._nLanguage,dt);
                    tmp = dv_b.getValue();
                }
                try
                {
                    bindnode = Integer.parseInt(tmp);
                } catch(Exception ex2)
                {
                }
            }
            //会签
            tmp = teasession.getParameter("csign");
            if(tmp != null)
            {
                Date starttime = new Date(),endtime = new Date();
                String time = teasession.getParameter("csignstarttime" + tmp);
                if(time.length() > 0)
                {
                    starttime = DynamicCsign.sdf.parse(time);
                }
                int comment = Integer.parseInt(teasession.getParameter("csigncomment" + tmp));
                String sign = teasession.getParameter("csignsign" + tmp);
                time = teasession.getParameter("csignendtime" + tmp);
                if(time.length() > 0)
                {
                    endtime = DynamicCsign.sdf.parse(time);
                }
                String content = teasession.getParameter("csigncontent" + tmp);
                DynamicCsign dc = DynamicCsign.find( -flowbusiness,Integer.parseInt(tmp),member);
                dc.set(starttime,null,comment,content,sign,endtime);
            }
            //自由流程
            if(f.getType() == 1)
            {
                Enumeration e = DynamicType.findByDynamic(f.getDynamic());
                while(e.hasMoreElements())
                {
                    int id = ((Integer) e.nextElement()).intValue();
                    DynamicValue dv = DynamicValue.find( -flowbusiness,teasession._nLanguage,id);
                    update(teasession,dv,id,bindnode);
                }
                // 由于是"自由流程",没有步骤,所以在提交数据之后创建,这样,在"流程图"中就可以出现了.
                if(!fp.isExists())
                {
                    Flowprocess.create(fb.getFlow(),fb.getStep(),teasession._rv.toString(),"/","/",false,false,false,teasession._nLanguage,"< No Subject >");
                }
            } else // 如果是固定流程or可控流程
            {
                int flowprocess = fp.getFlowprocess();
                String dtw = fp.getDTWrite();
                if(f.getType() == 2) //可控流程//
                {
                    if(flowprocess == f.getMainProcess() && fb.isRunMain()) //如果当前是主控步骤 && 走过主控步骤
                    {
                        int flowview = Flowview.findLast(flowbusiness,flowprocess);
                        Flowprocess fp2 = Flowprocess.find(flow,Flowprocess.find(Flowview.find(flowview).getFlowprocess()).getStep());
                        dtw = fp2.getMainDTWrite();
                    }
                }
                String ids[] = dtw.split("/");
                for(int i = 1;i < ids.length;i++)
                {
                    if("down".equals(ids[i]))
                        continue;
                    int id = Integer.parseInt(ids[i]);
                    DynamicValue dv = DynamicValue.find( -flowbusiness,teasession._nLanguage,id);
                    update(teasession,dv,id,bindnode);
                }
            }

            if(teasession.getParameter("reading") != null) //阅闭
            {
                boolean isStart = "true".equals(teasession.getParameter("start")); //启动子公司收文流程
                if(isStart)
                {
                    Date time = new Date();
                    int corg = AdminUnitOrg.find(teasession._strCommunity,fb.getCreator()); //创建者公司
                    //flow:2 收文
                    int newfb = Flowbusiness.create(teasession._strCommunity,0,2,flowbusiness,time,corg,member,f.getName(teasession._nLanguage) + ":" + Flowbusiness.sdf2.format(time));
                    //收文的Word文件
                    DynamicValue.find( -newfb,teasession._nLanguage,53).set(fb.tape2);
                    //发文的附件
                    Enumeration e = DynamicValue.find( -flowbusiness,teasession._nLanguage,37).findMulti("",0,1000);
                    DynamicValue dv54 = DynamicValue.find( -newfb,teasession._nLanguage,54);
                    while(e.hasMoreElements())
                    {
                        DynamicValue.Multi m = (DynamicValue.Multi) e.nextElement();
                        dv54.setMulti(0,member,m.getValue());
                    }
                }
            }
            if(teasession.getParameter("save") != null)
            {
                out.print("<script>alert('保存成功!!!'); location.replace('/jsp/admin/flow/EditFlowdynamicvalue.jsp?community=" + teasession._strCommunity + "&flow=" + flow + "&flowbusiness=" + flowbusiness + "&nexturl=" + java.net.URLEncoder.encode(nu,"UTF-8") + "');</script>");
                //response.sendRedirect(nu);
                return;
            }
            if("ss".equals(teasession.getParameter("param")))
            {
                teasession.getSession().setAttribute("isshowtag","1");
                out.print("<script>location.replace('/jsp/admin/flow/EditFlowdynamicvalue.jsp?community=" + teasession._strCommunity + "&flow=" + flow + "&flowbusiness=" + flowbusiness + "&nexturl=" + java.net.URLEncoder.encode(nu,"UTF-8") + "');</script>");

                return;
            }

            //SetFlowbusinessCSign.jsp:指定会签
            response.sendRedirect("/jsp/admin/flow/" + (fp.isCsign() ? "SetFlowbusinessCSign.jsp" : "EditFlowbusinessNext.jsp") + "?community=" + teasession._strCommunity + "&flowbusiness=" + flowbusiness + "&nexturl=" + java.net.URLEncoder.encode(nu,"UTF-8"));
        } catch(Exception ex)
        {
            ex.printStackTrace();
            throw new ServletException(ex.getMessage());
        } finally
        {
            out.close();
        }
    }

    private void update(TeaSession teasession,DynamicValue dv,int id,int bindnode) throws SQLException,IOException
    {
        DynamicType dt = DynamicType.find(id);
        int defv = dt.getDefaultvalue();
        String type = dt.getType();
        String v = null;
        if("folder".equals(type))
        {
            return;
        }
        String arr[] = teasession.getParameterValues("dynamictype" + id);
        if(arr == null)
        {
            //System.out.println(id);
            return;
        }
        if("file".equals(type) || "img".equals(type))
        {
            if(dt.isMulti())
            {
                String del = teasession.getParameter("dynamictype_del" + id);
                if(del == null) //如果为空,则删除所有
                {
                    del = "/50/49/48/47/46/45/44/43/42/41/40/39/38/37/36/35/34/33/32/31/30/29/28/27/26/25/24/23/22/21/20/19/18/17/16/15/14/13/12/11/10/9/8/7/6/5/4/3/2/1/";
                }
                String dels[] = del.split("/");
                for(int i = 1;i < dels.length;i++)
                {
                    dv.delMulti(Integer.parseInt(dels[i]));
                }
                if(arr != null)
                {
                    for(int i = 0;i < arr.length;i++)
                    {
                        dv.setMulti(0,teasession._rv._strV,arr[i]);
                    }
                }
            } else
            {
                if(arr != null)
                {
                    v = arr[0];
                } else if(teasession.getParameter("dynamictype_checkbox" + id) == null)
                {
                    v = dv.getValue();
                }
            }
        } else
        {
            for(int i = 0;i < arr.length;i++)
            {
                v = arr[i];
                if(dt.getFather() > 0)
                {
                    dv.setMulti(dt.isSeparate() ? -1 : i + 1,teasession._rv._strV,arr[i]);
                }
                if(bindnode > 0 && (defv == 8 || defv == 9)) //更改被绑定的值
                {
                    DynamicValue dv_b = DynamicValue.find(bindnode,teasession._nLanguage,dt.getBinding());
                    try
                    {
                        int vc = Integer.parseInt(v); //绑定的值
                        String tmp = dv.getValue();
                        if(tmp != null && tmp.length() > 0) //计算:和上次的差异
                        {
                            vc = vc - Integer.parseInt(tmp);
                        }
                        int vb = Integer.parseInt(dv_b.getValue()); //被绑定的值
                        switch(defv)
                        {
                        case 8: //+
                            vb = vb + vc;
                            break;
                        case 9: //-
                            vb = vb - vc;
                            break;
                        }
                        dv_b.set(String.valueOf(vb));
                    } catch(NumberFormatException ex2)
                    {
                    }
                }
            }
        }
        dv.set(v);
    }

    public static String js_opinion(String ids[])
    {
        for(int i = 0;i < ids.length;i++)
        {
            if(ids[i] == null)
                ids[i] = "";
        }
        if(ids[0].length() == 0 && ids[1].length() == 0 && ids[2].length() == 0)
            return "";
        StringBuffer js = new StringBuffer();
        js.append("    var tr=document.createElement('TR'); ");
        js.append("    var td=document.createElement('TD'); ");
        js.append("    td.innerHTML=\"" + ids[0].replaceAll("<","&lt;").replaceAll("\r\n","<br/>") + "\"; ");
        js.append("    tr.appendChild(td); ");
        js.append("    td=document.createElement('TD'); ");
        if(ids[1].length() > 1)
            js.append("    td.innerHTML=\"" + (ids[1].startsWith("/res/") ? "<img src='" + ids[1] + "' oncontextmenu='return false'>" : ids[1]) + "\"; ");
        js.append("    tr.appendChild(td); ");
        js.append("    td=document.createElement('TD'); ");
        js.append("    td.innerHTML=\"" + ids[2] + "\"; ");
        js.append("    tr.appendChild(td); ");
        js.append("    document.getElementById('ajax_opinion').appendChild(tr);");
        return js.toString();
    }

}
