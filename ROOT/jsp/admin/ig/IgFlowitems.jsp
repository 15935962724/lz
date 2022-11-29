<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="java.math.*" %>
<%@ page import="tea.entity.member.*" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.*" %>
<%@ page import="tea.entity.node.*" %>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="javax.mail.Folder" %>
<%@page import="tea.entity.*"%>
<%@ page import="tea.ui.*" %>
<% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
//待办工作//////////////////////////////////////////

Resource r=new Resource();

int showcount=Integer.parseInt(request.getParameter("showcount"));
int igd=Integer.parseInt(request.getParameter("menuid"));

String sn=request.getServerName()+":"+request.getServerPort();
String jsessionid=request.getParameter("jsessionid");
if(jsessionid!=null)
{
  jsessionid="&jsessionid="+jsessionid;
}else
{
  jsessionid="";
}


out.print("<div id=modboxmenu><a href=javascript:f_flowitem(false)  >待办工作</a> <a href=javascript:f_flowitem(true) >创建工作</a></div>");
out.print("<DIV id=flowitems1 >");

StringBuffer sql=new StringBuffer();
sql.append(" AND step>0 AND flowbusiness IN ( SELECT fm.flowbusiness FROM FlowbusinessMember fm WHERE fm.state=0 AND ( fm.transactor=").append(DbAdapter.cite(teasession._rv.toString())).append(" OR fm.consign=").append(DbAdapter.cite(teasession._rv.toString())).append(") )");

java.util.Enumeration enumer=Flowbusiness.findByCommunity(teasession._strCommunity,sql.toString());
if(!enumer.hasMoreElements())
{
  out.print("您暂无待办工作");
}else
{
  StringBuffer sb=new StringBuffer();//存储已接收的html

  for(int j=0;j<showcount&&enumer.hasMoreElements();j++)
  {
    int flowbusiness=((Integer)enumer.nextElement()).intValue();
    Flowbusiness obj=Flowbusiness.find(flowbusiness);
    Flow flow_obj=Flow.find(obj.getFlow());
    Flowprocess flowprocess_obj=Flowprocess.find(obj.getFlow(),obj.getStep());

    StringBuffer sb2=new StringBuffer();

    sb2.append("<div id=ftl_"+igd+"_"+j+" class=uftl><a href='javascript:void(0)' id='ft_"+igd+"_"+j+"' class='fmaxbox' onclick='_IG_FR_toggle("+igd+","+j+")'></a>");
    sb2.append("  <a target=_blank href=/jsp/admin/flow/Flowbusiness3.jsp?community="+teasession._strCommunity+" >");

    StringBuffer subject=new StringBuffer("第"+obj.getStep()+"步");
    //固定流程才显示，步骤名
    if(flow_obj.getType()==0)
    subject.append(":").append(flowprocess_obj.getName(teasession._nLanguage));

    Flowview fv_obj=Flowview.findLast(flowbusiness,obj.getStep());
    if(fv_obj.isExists())
    {
      sb2.append(subject);//已接收
    }else
    {
      sb2.append("<b>").append(subject).append("</b><img src=/tea/image/public/new.gif>");//未接收
    }
    sb2.append("</a> ");

    //上一步提交者和提交时间
    Flowview fv_obj2=fv_obj;
    if(obj.getStep()>1)
    {
      fv_obj2=Flowview.findLast(flowbusiness,obj.getStep()-1);
    }
    if(fv_obj2.isExists())//异常处理:当Flowview和Flowbusiness必须同步时
    {
      Profile p=Profile.find(fv_obj2.getTransactor());
      sb2.append(fv_obj2.getTimeToString()+"<BR>");

      sb2.append("  <div id=fb_"+igd+"_"+j+" class='fpad fb' style='display:none'>");
      sb2.append("上步提交者:"+fv_obj2.getTransactor()+" ( "+p.getName(teasession._nLanguage)+" )<br>");
      sb2.append("上步提交时间:"+fv_obj2.getTimeToString());
      sb2.append("  </div>");
    }
    sb2.append("</div>");
    if(fv_obj.isExists())//已接收,先把'未接收'的输出完之后，再输出'已接收'
    {
      sb.append(sb2.toString());
    }else//未接收
    {
      out.print(sb2.toString());
    }
  }
  out.print(sb.toString());
}

out.print("</DIV>");


out.print("<DIV id=flowitems2 style=display:none >");

enumer=Flow.find(teasession._strCommunity,"");
if(!enumer.hasMoreElements())
{
  out.print("请先创建流程.");
}else
for(int index=0;enumer.hasMoreElements();index++)
{
  int id=((Integer)enumer.nextElement()).intValue();
  Flow obj=Flow.find(id);
  Flowprocess fp=Flowprocess.find(id,1);
  if(fp.isExists())
  {
    out.println("<input type=button value=\""+fp.getName(teasession._nLanguage)+"\" onclick=\"window.open('/jsp/admin/flow/EditFlowdynamicvalue.jsp?community="+teasession._strCommunity+"&flow="+id+"&dynamic="+obj.getDynamic()+"&flowbusiness=0&nexturl='+encodeURIComponent(document.location),'_self');\" ><br>");
  }else//没有第一步
  {
    out.println("<input type=button disabled value=\""+obj.getName(teasession._nLanguage)+"\" >");
  }
}
out.print("</DIV>");

%>
<script>
function f_flowitem(bool)
{
  var fi1=document.getElementById('flowitems1');
  var fi2=document.getElementById('flowitems2');
  if(bool)
  {
    fi1.style.display='none';
    fi2.style.display='';
  }else
  {
    fi1.style.display='';
    fi2.style.display='none';
  }
}
</script>
