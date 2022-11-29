<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.*"  %>
<%@ page  import="tea.entity.admin.*" %>
<%@ page  import="tea.htmlx.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="tea.entity.member.*" %>
<%@ page import="tea.entity.admin.*" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}


int flowitem = 0;
if(teasession.getParameter("flowitem")!=null && teasession.getParameter("flowitem").length()>0)
{
  flowitem = Integer.parseInt(teasession.getParameter("flowitem"));
}

int alid = 0;
if(teasession.getParameter("alid")!=null && teasession.getParameter("alid").length()>0)
{
  alid = Integer.parseInt(teasession.getParameter("alid"));
}

Flowitem fobj = Flowitem.find(flowitem);
Already alobj = Already.find(alid);
String act = teasession.getParameter("act");
if("EditAlready".equals(act))
{

  java.math.BigDecimal amount = null;
  if(teasession.getParameter("amount")!=null && teasession.getParameter("amount").length()>0)
  {
    amount = new java.math.BigDecimal(teasession.getParameter("amount"));
  }
   java.util.Date timemoney  = Flowitem.sdf.parse(request.getParameter("timemoneyYear") + "-" + request.getParameter("timemoneyMonth") + "-" + request.getParameter("timemoneyDay"));
  String project = teasession.getParameter("project");
  int way = Integer.parseInt(teasession.getParameter("way"));
  String membera = teasession.getParameter("membera");
  String memberb = teasession.getParameter("memberb");
  int atype=0;
  if(teasession.getParameter("atype")!=null && teasession.getParameter("atype").length()>0)
  {
    atype =Integer.parseInt(teasession.getParameter("atype"));
  }
  int invoice = Integer.parseInt(teasession.getParameter("invoice"));
  if(alid>0)
  {
     alobj.set(flowitem,fobj.getWorkproject(),amount,timemoney,project,way,membera,memberb,invoice,teasession._rv.toString(),atype);
  }else
  {
    Already.create(flowitem,fobj.getWorkproject(),amount,timemoney,project,way,membera,memberb,invoice,teasession._rv.toString(),teasession._strCommunity,atype);
  }
  out.print("<script>alert('项目收款记录添加成功！'); window.returnValue=1;window.close();</script>");
  return;
}
else if("delete".equals(act))
{
  alobj.delete();
  out.print("<script>alert('项目收款记录删除！'); window.returnValue=1;window.close();</script>");
  return;
}

java.util.Date timemoney =null;
java.math.BigDecimal amount =null;
String project = null,membera=null,memberb=null;
int way = 0,invoice=0,atype=0;

if(alid>0)
{
  timemoney=alobj.getTimemoney();
  amount=alobj.getAmount();
  project=alobj.getProject();
  membera=alobj.getMembera();
  memberb=alobj.getMemberb();
  way = alobj.getWay();
  invoice=alobj.getInvoice();
  atype=alobj.getAtype();
}
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>
<script type="">
window.name='tar';
function f_submit()
{
  if(form1.amount.value=='')
  {
    alert("请填写收支金额！");
    form1.amount.focus();
    return false;
  }
  if(form1.project.value=='')
  {
    alert("请填写收支说明！");
    form1.project.focus();
    return false;
  }
}
</script>

<h1>项目收款记录</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>
   <form name=form1 method="POST" action="?"  target="tar" onsubmit="return f_submit();">
   <input type="hidden" name="act" value="EditAlready"/>
   <input type="hidden" name="flowitem" value="<%=flowitem%>"/>
      <input type="hidden" name="alid" value="<%=alid%>"/>
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
       <tr>
         <td>收支类型：</td>
         <td><select name="atype">
         <%
         for(int i = 0;i<Already.ALREADYTYPE.length;i++)
         {
           out.print("<option  value= "+i);
           if(atype==i)
           {
             out.print(" selected=selected");
           }
           out.print(">\r"+Already.ALREADYTYPE[i]+"\r</option>");
         }
         %>
         </select>
         </td>
       </tr>
       <tr>
         <td>收支金额：</td>
         <td><input type="text" name="amount" value="<%if(amount!=null)out.print(amount);%>" mask="float"></td>
       </tr>
        <tr>
         <td>收款日期：</td>
         <td><%=new tea.htmlx.TimeSelection("timemoney", timemoney)%></td>
       </tr>
       <tr>
         <td>收支说明：</td>
         <td><input type="text" name="project" value="<%if(project!=null)out.print(project);%>"></td>
       </tr>
        <tr>
         <td>收款方式：</td>
         <td>
         <%
           for(int i = 0;i<Already.WAY_TYPE.length;i++)
           {
             out.print("<input type=radio name=way value= "+i);
             if(way==i)
             {
               out.print(" checked=checked");
             }
             out.print(">\r"+Already.WAY_TYPE[i]+"\r");
           }
         %>

         </td>
       </tr>
       <tr>
         <td>甲方经办人：</td>
         <td>
           <select name="membera">
             <option value="">-------------</option>
             <%
             java.util.Enumeration  ea = Worklinkman.find(teasession._strCommunity," AND workproject ="+fobj.getWorkproject(),0,Integer.MAX_VALUE);
             while(ea.hasMoreElements())
             {
               String wlmember=((String)ea.nextElement());
               Worklinkman obj=Worklinkman.find(teasession._strCommunity,wlmember);
               tea.entity.member.Profile profile=tea.entity.member.Profile.find(wlmember);
               out.print("<option value="+wlmember);
               if(wlmember.equals(membera))
               {
                 out.print(" SELECTED ");
               }
               out.print(">"+profile.getLastName(teasession._nLanguage)+profile.getFirstName(teasession._nLanguage));
               out.print("</script>");
             }
             %>
           </select>
         </td>
       </tr>
          <tr>
         <td>乙方经办人：</td>
         <td>
           <select name="memberb">
             <option value="">-------------</option>
            <%
                StringBuffer sp = new StringBuffer("/");
                for(int i =1;i<fobj.getManager().split("/").length;i++)
                {

                  if(fobj.getMember().indexOf(fobj.getManager().split("/")[i])==-1)
                  {
                    sp.append(fobj.getManager().split("/")[i]).append("/");
                  }
                }
                sp.append(fobj.getMember());

                for(int j =1;j<sp.toString().split("/").length;j++)
                {

                  if(sp.toString().split("/")[j]!=null&&sp.toString().split("/")[j].length()>0)
                  {System.out.println(sp.toString().split("/")[j]);
                  tea.entity.member.Profile profile2=tea.entity.member.Profile.find(sp.toString().split("/")[j]);
//                     tea.entity.member.Profile profile2=tea.entity.member.Profile.find(sp.toString().split("/")[j]);
                   out.print("<option value="+sp.toString().split("/")[j]);
                   if(sp.toString().split("/")[j].equals(alobj.getMemberb()))
                   {
                     out.print(" SELECTED ");
                    }
                    out.print(">"+profile2.getLastName(teasession._nLanguage)+profile2.getFirstName(teasession._nLanguage));
                    out.print("</option>");
                  }
                }
            %>
           </select>
         </td>
       </tr>
        <tr>
         <td>发票情况：</td>
         <td><input type="radio"  name="invoice" value="0" <%if(invoice==0)out.print("checked=checked");%>>&nbsp;未开&nbsp;<input type="radio" name="invoice" value="1"  <%if(invoice==1)out.print("checked=checked");%>>&nbsp;已开</td>
       </tr>
     </table>

<br>
<input type="submit" value="提交" >&nbsp;
<input type="button" value="关闭"  onClick="javascript:window.close();">

</form>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>



