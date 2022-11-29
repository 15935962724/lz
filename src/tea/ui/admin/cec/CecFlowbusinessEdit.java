package tea.ui.admin.cec;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.ui.*;
import tea.db.*;
import tea.entity.admin.*;
import tea.entity.node.*;
import tea.entity.site.*;
import java.sql.SQLException;
import tea.resource.*;
import tea.entity.*;
import tea.entity.util.*;
import tea.entity.member.*;

public class CecFlowbusinessEdit extends TeaServlet
{

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html; charset=utf-8");
        Http h = new Http(request);
        PrintWriter out = response.getWriter();
        try
        {
            String act = h.get("act");
            if("exclusive".equals(act)) //去掉独占记录//////
            {
                int flowbusiness = (h.getInt("flowbusiness"));
                Flowbusiness fb = Flowbusiness.find(flowbusiness);
                fb.setExclusive(null);
                return;
            }
            ///////////////
            TeaSession teasession = new TeaSession(request);
            if(teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            teasession.getSession().setAttribute("isshowtag","0");

            //start
            h.username = teasession._rv._strV;
            String nu = h.get("nexturl");
            int prev = (h.getInt("prev"));
            int flow = (h.getInt("flow"));
            int flowbusiness = 0;
            String tmp = h.get("flowbusiness");
            if(tmp != null && tmp.length() > 0)
            {
                flowbusiness = Integer.parseInt(tmp);
            }
            Flow f = Flow.find(flow);
            Dynamic d = Dynamic.find(f.getDynamic());
            Flowbusiness fb = Flowbusiness.find(flowbusiness);
            //创建事务
            if(!Flowview.find(flowbusiness,"").hasMoreElements())
            {
                Flowview.create(flowbusiness,Flowprocess.find(flow,1).getFlowprocess(),h.username,new String[]
                                {h.username},1,0);
                fb.setAdminUnitOrg(h.getInt("adminunitorg"));
                fb.setStep(1);
            }
            Flowprocess fp = Flowprocess.find(flow,fb.getStep());
            //发文的头, 同一个表单，多个头信息
            int head = h.getInt("head");
            if(head > 0)
                fb.setHead(head);
            //如果事务绑订了输入框///////////////////////////
            StringBuffer sbn = new StringBuffer();
            String dtfb[] = d.getDtfb().split("/");
            for(int i = 1;i < dtfb.length;i++)
            {
                DynamicType dt = DynamicType.find(Integer.parseInt(dtfb[i]));
                if(!dt.isExists())
                    continue;
                String name = h.get("dynamictype" + dtfb[i]);
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
            switch(d.getDynamic()) //更改正文
            {
            case 1031: //签报
                fb.setTape1(DynamicValue.find( -flowbusiness,teasession._nLanguage,85).getValue());
                break;
            case 1032: //发文稿纸
                fb.setTape1(DynamicValue.find( -flowbusiness,teasession._nLanguage,107).getValue());
                break;
            }
            //更改编辑状态///////
            Flowview fv = Flowview.find(flowbusiness,fp.getFlowprocess(),h.username);
            if(fv.isExists())
            {
                fv.setState(1);
            }
            //绑定的是那个节点/////
            int bindnode = 0;
            tmp = h.get("binding"); //绑定的是那个DT
            if(tmp != null)
            {
                int dt = Integer.parseInt(tmp);
                tmp = h.get("dynamictype" + dt);
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
            tmp = h.get("csign");
            if(tmp != null)
            {
                Date starttime = new Date(),endtime = new Date();
                String time = h.get("csignstarttime" + tmp);
                if(time.length() > 0)
                {
                    starttime = DynamicCsign.sdf.parse(time);
                }
                int comment = (h.getInt("csigncomment" + tmp));
                String sign = h.get("csignsign" + tmp);
                time = h.get("csignendtime" + tmp);
                if(time.length() > 0)
                {
                    endtime = DynamicCsign.sdf.parse(time);
                }
                String content = h.get("csigncontent" + tmp);
                DynamicCsign dc = DynamicCsign.find( -flowbusiness,Integer.parseInt(tmp),h.username);
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
                    update(h,teasession,dv,id,bindnode);
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
                    if("down".equals(ids[i]) || "print".equals(ids[i]))
                        continue;
                    int id = Integer.parseInt(ids[i]);
                    DynamicValue dv = DynamicValue.find( -flowbusiness,teasession._nLanguage,id);
                    update(h,teasession,dv,id,bindnode);
                }
                if(h.getBool("off")) //截断分支
                {
                    fv.setState(3);
                    if(fb.next(h.username))
                        fb.send("cec");
                    response.sendRedirect(nu);
                    return;
                }
            }
            /*
                     if(h.get("reading") != null) //阅闭
                     {
                         boolean isStart = "true".equals(h.get("start")); //启动子公司收文流程
                         if((fb.getFlow() == 7 || fb.getFlow() == 12 || fb.getFlow() == 14) && !Flowbusiness.findByCommunity(teasession._strCommunity," AND prev=" + flowbusiness).hasMoreElements()) //7、新能源公司下属分子公司上行文发文流程
                         {
                             Date time = new Date();
                             int corg = AdminUnitOrg.find(teasession._strCommunity,fb.getCreator()); //创建者公司
                             //FLOW: 10、新能源公司收文处理流程
                             int newfb = Flowbusiness.create(teasession._strCommunity,0,10,flowbusiness,time,corg,member,fb.name);
                             //收文的Word文件
                             //DynamicValue.find( -newfb,teasession._nLanguage,583).set(fb.getTape2());
                             //发文的附件
                             Enumeration e = DynamicValue.find( -flowbusiness,teasession._nLanguage,85).findMulti("",0,1000);
                             DynamicValue dv54 = DynamicValue.find( -newfb,teasession._nLanguage,583);
                             dv54.setMulti(0,member,fb.getTape2());
                             while(e.hasMoreElements())
                             {
                                 DynamicValue.Multi m = (DynamicValue.Multi) e.nextElement();
                                 dv54.setMulti(0,member,m.getValue());
                             }
                         } else if(fb.getFlow() == 5 && !Flowbusiness.findByCommunity(teasession._strCommunity," AND prev=" + flowbusiness).hasMoreElements()) //5、新能源公司下行文发文流程
                         {
                             Date time = new Date();
                             int corg = AdminUnitOrg.find(teasession._strCommunity,fb.getCreator()); //创建者公司
                             //FLOW: 10、新能源公司收文处理流程
                             int newfb = Flowbusiness.create(teasession._strCommunity,0,10,flowbusiness,time,corg,member,fb.name);
                             //收文的Word文件
                             //DynamicValue.find( -newfb,teasession._nLanguage,583).set(fb.getTape2());
                             //发文的附件
                             Enumeration e = DynamicValue.find( -flowbusiness,teasession._nLanguage,85).findMulti("",0,1000);
                             DynamicValue dv54 = DynamicValue.find( -newfb,teasession._nLanguage,583);
                             dv54.setMulti(0,member,fb.getTape2());
                             while(e.hasMoreElements())
                             {
                                 DynamicValue.Multi m = (DynamicValue.Multi) e.nextElement();
                                 dv54.setMulti(0,member,m.getValue());
                             }
                         }
                     }
             */
            if(h.get("save") != null)
            {
                out.print("<script>alert('保存成功!!!'); location.replace('/jsp/admin/cec/FlowbusinessEdit.jsp?community=" + teasession._strCommunity + "&flow=" + flow + "&flowbusiness=" + flowbusiness + "&nexturl=" + java.net.URLEncoder.encode(nu,"UTF-8") + "');</script>");
                //response.sendRedirect(nu);
                return;
            }
            if("ss".equals(h.get("param")))
            {
                teasession.getSession().setAttribute("isshowtag","1");
                out.print("<script>location.replace('/jsp/admin/cec/FlowbusinessEdit.jsp?community=" + teasession._strCommunity + "&flow=" + flow + "&flowbusiness=" + flowbusiness + "&nexturl=" + java.net.URLEncoder.encode(nu,"UTF-8") + "');</script>");

                return;
            }

            //SetFlowbusinessCSign.jsp:指定会签
            response.sendRedirect("/jsp/admin/cec/" + (fp.isCsign() ? "SetFlowbusinessCSign.jsp" : "EditFlowbusinessNext.jsp") + "?community=" + teasession._strCommunity + "&flowbusiness=" + flowbusiness + "&nexturl=" + java.net.URLEncoder.encode(nu,"UTF-8"));
        } catch(Exception ex)
        {
            ex.printStackTrace();
            response.sendError(500,ex.toString());
        } finally
        {
            out.close();
        }
    }

    private void update(Http h,TeaSession teasession,DynamicValue dv,int id,int bindnode) throws SQLException,IOException
    {
        DynamicType dt = DynamicType.find(id);
        int defv = dt.getDefaultvalue();
        String type = dt.getType();
        String v = null;
        if("folder".equals(type))
        {
            return;
        }
        if("csign".equals(type) && h.getBool("off")) //截断分支
        {
            ProfileBBS pb = ProfileBBS.find(teasession._strCommunity,h.username);
            String isign = MT.f(pb.getISign(teasession._nLanguage),h.username);
            DynamicCsign dc = DynamicCsign.find(dv.getNode(),id,h.username);
            dc.set(dc.getStartTime(),null,2,"阅毕",isign,new Date());
            return;
        }
        String arr[] = h.getValues("dynamictype" + id);
        if(arr == null)
        {
            //System.out.println(id);
            return;
        }
        if("file".equals(type) || "img".equals(type))
        {
            if(dt.isMulti())
            {
                String del = h.get("dynamictype_del" + id);
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
                } else if(h.get("dynamictype_checkbox" + id) == null)
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
            {
                ids[i] = "";
            }
        }
        if(ids[0].length() == 0 && ids[1].length() == 0 && ids[2].length() == 0)
        {
            return "";
        }
        StringBuffer js = new StringBuffer();
        js.append("    var tr=document.createElement('TR'); ");
        js.append("    var td=document.createElement('TD'); ");
        js.append("    td.innerHTML=\"" + ids[0].replaceAll("<","&lt;").replaceAll("\r\n","<br/>") + "\"; ");
        js.append("    tr.appendChild(td); ");
        js.append("    td=document.createElement('TD'); ");
        if(ids[1].length() > 1)
        {
            ids[1] = "<img src='" + ids[1] + "' oncontextmenu='return false' height='30'>";
            js.append("    td.innerHTML=\"" + ids[1] + "\"; ");
        }
        js.append("    tr.appendChild(td); ");
        js.append("    td=document.createElement('TD'); ");
        js.append("    td.innerHTML=\"" + ids[2] + "\"; ");
        js.append("    tr.appendChild(td); ");
        js.append("    document.getElementById('ajax_opinion').appendChild(tr);");
        return js.toString();
    }

}
