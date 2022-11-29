<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%@page import="tea.service.*" %><%@page import="tea.entity.netdisk.*" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.entity.*" %><%@ page import="tea.entity.site.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.resource.Resource" %><%@ page import="tea.entity.admin.*" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");response.setHeader("Cache-Control", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=teasession.getParameter("community");
String nexturl=teasession.getParameter("nexturl");

String member=teasession._rv._strV;

int flowbusiness=Integer.parseInt(request.getParameter("flowbusiness"));
Flowbusiness fb=Flowbusiness.find(flowbusiness);
int flow=fb.getFlow();//Integer.parseInt(request.getParameter("flow"));
Flow f=Flow.find(fb.getFlow());

Http http=new Http(request,response);

if("POST".equals(request.getMethod()))
{
  String act=request.getParameter("act");
  Dynamic d=Dynamic.find(f.getDynamic());
  String dsubject=f.getName(teasession._nLanguage);
  if("stop".equals(act))//项目终止
  {
    int nextflow=Integer.parseInt(request.getParameter("nextflow"));
    fb.stop(nextflow);
  }else//转下一步骤
  {
    String members[]=request.getParameterValues("members");
    String tmp=request.getParameter("tunit");
    if(tmp!=null)//部门转用户
    {
      String enabled=request.getParameter("enabled");
      String arr[]=tmp.split("/");
      List al=members==null?new ArrayList():Arrays.asList(members);
      for(int i=1;i<arr.length;i++)
      {
        String sql=" AND (unit="+arr[i]+" OR classes LIKE "+DbAdapter.cite("%/"+arr[i]+"/%")+")";
        if(enabled!=null)sql+=" AND "+DbAdapter.cite(enabled)+" LIKE '%/'+member+'/%'";
        Enumeration e=AdminUsrRole.find(teasession._strCommunity,sql,0,Integer.MAX_VALUE);
        while(e.hasMoreElements())
        {
          tmp=(String)e.nextElement();
          if(al.indexOf(tmp)==-1)al.add(tmp);
        }
      }
      members=new String[al.size()];
      al.toArray(members);
    }
    if(members.length<1)
    {
      response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("没有待办人员!!!","UTF-8"));
      return;
    }
    if(!Profile.isExisted(members[0]))//只判断第一个:因为自由流程是填写的会员ID///
    {
      response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode(members[0]+"会员不存在了.","UTF-8"));
      return;
    }
    String subject="您有《"+fb.name+"》工作需要办理！";//"工作流提醒:您有新的工作需要办理！";
    String url="/jsp/admin/cec/FlowbusinessEdit.jsp?community="+teasession._strCommunity+"&flowbusiness="+flowbusiness+"&flow="+flow+"&nexturl="+java.net.URLEncoder.encode(nexturl,"UTF-8");
    //
    tmp=request.getParameter("flowprocess");
    if(tmp!=null)//强制流程跳转//
    {
      //打印份数
      String _prints=request.getParameter("prints");
      int prints=(_prints==null||_prints.length()<1)?0:Integer.parseInt(_prints);
      if(d.getDynamic()==1032&&_prints!=null&&_prints.length()>0)//中国电子
      {
        DynamicValue.find(-flowbusiness, teasession._nLanguage, 100).set(_prints);
      }
      //
      fb.next(member,members,Integer.parseInt(tmp),prints);
      Flowprocess fp=Flowprocess.find(flow,fb.getStep());

      //发送消息/////
      StringBuffer sb=new StringBuffer();
//      sb.append("事务名: ").append(fb.getName(teasession._nLanguage));
//      sb.append("<br>提交人: ").append(teasession._rv);
//      sb.append("<br>待办步骤: 第").append(fb.getStep()).append("步");
//      if(f.getType()!=1)//如果不是自由流程
//      {
//        sb.append("<br>步骤名: "+fp.getName(teasession._nLanguage));
//      }
      sb.append("<a href='"+url+"' target='m' onclick='opener=null;window.close();'>点这里进行办理</a>");
      String content=sb.toString();
      int wen=content.lastIndexOf("/jsp/");
      //发送邮件和短信/////
      StringBuffer mes=new StringBuffer("/");
      StringBuffer mos=new StringBuffer();
      boolean isMessage=request.getParameter("message")!=null;
      boolean isMail=request.getParameter("mail")!=null;
      String sms=request.getParameter("sms");
      for(int i=0;i<members.length;i++)
      {
        Profile p=Profile.find(members[i]);
        mes.append(members[i]).append("/");
        mos.append(p.getMobile()).append(",");
        if(isMail)
        {
          Email.create(teasession._strCommunity,null,p.getEmail(),subject,content.substring(0,wen)+"/servlet/Login?community="+teasession._strCommunity+"&LoginType=3&LoginId="+java.net.URLEncoder.encode(members[i]+"/"+Long.toString(p.getTime().getTime(),36),"UTF-8")+"&nexturl="+content.substring(wen));
        }
      }
      if(sms!=null)
      {
        SMSMessage.create(teasession._strCommunity,member,mos.toString(),teasession._nLanguage,sms);
      }
      if(isMessage)
      {
        Message.create(teasession._strCommunity,5,member,mes.toString(),"/","/",0,url,teasession._nLanguage,subject,content);
      }
    }else
    {
      tmp=teasession.getParameter("step");
      if(fb.next(member,members,tmp==null?0:Integer.parseInt(tmp)))
        fb.send("cec");
    }
    fb.setReason(null);//清空"不符合上报要求填写的回退原因"
  }
  if("true".equals(teasession.getParameter("start")))
  {
    int newfb=0;
    if(flow == 7 || flow == 12 || flow == 14) //7、新能源公司下属分子公司上行文发文流程
    {
      Date time = new Date();
      int corg = AdminUnitOrg.find(teasession._strCommunity,fb.getCreator()); //创建者公司
      //FLOW: 10、新能源公司收文处理流程
      newfb = Flowbusiness.create(teasession._strCommunity,0,10,flowbusiness,time,corg,member,fb.name);
      //84、文件标题
      DynamicValue.find(-newfb,teasession._nLanguage,117).set(fb.name);
      //发文的附件
      DynamicValue dv54 = DynamicValue.find( -newfb,teasession._nLanguage,583);
      dv54.setMulti(0,member,fb.getTape2());
      Enumeration e = DynamicValue.find( -flowbusiness,teasession._nLanguage,85).findMulti("",0,1000);
      while(e.hasMoreElements())
      {
        DynamicValue.Multi m = (DynamicValue.Multi) e.nextElement();
        dv54.setMulti(0,member,m.getValue());
      }
    } else if(flow == 1) //1、发文流程
    {
      Date time = new Date();
      int corg = AdminUnitOrg.find(teasession._strCommunity,fb.getCreator()); //创建者公司
      //FLOW: 2、收文处理流程
      newfb = Flowbusiness.create(teasession._strCommunity,0,2,flowbusiness,time,corg,member,fb.name);
      //84、文件标题
      DynamicValue.find(-newfb,teasession._nLanguage,112).set(fb.name);
      //发文的附件///////////
      DynamicValue dv54 = DynamicValue.find(-newfb,teasession._nLanguage,120);
      dv54.setMulti(0,member,fb.getTape2());
      //随文发附件
      String v101=DynamicValue.find(-flowbusiness,teasession._nLanguage,101).getValue();
      if(v101!=null&&v101.length()>0)
         dv54.setMulti(0,member,v101);
      //参阅附件
      Enumeration e = DynamicValue.find( -flowbusiness,teasession._nLanguage,103).findMulti("",0,1000);
      while(e.hasMoreElements())
      {
        DynamicValue.Multi m = (DynamicValue.Multi) e.nextElement();
        dv54.setMulti(0,member,m.getValue());
      }
    }
    if(newfb>0)nexturl="/jsp/admin/cec/FlowbusinessEdit.jsp?flow="+2+"&flowbusiness="+newfb+"&nexturl="+Http.enc(nexturl);
  }
  out.print("<script>alert('提交成功!!!'); location.replace('"+nexturl+"');</script>");
  return;
}

int filecenter=f.getFilecenter();
if(fb.getFileCenter()>0)//如果事务已归过档,就改为0,无需再次归档.
{
  filecenter=0;
}

Flowprocess fp=Flowprocess.find(flow,fb.getStep());

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script type="">
function f_submit(act,args)
{
  if(!confirm("确认结束流程?"))return false;
//  if(act=='stop')
//  {
//    //var flag=window.showModalDialog('/jsp/admin/flow/EditFlowbusinessNext_Stop.jsp?community='+form1.community.value+'&filecenter='+form1.filecenter.value+'&info='+encodeURI(args?'确认结束流程,启动新流程?':'确认结束流程?')+'&t='+new Date().getTime(),self,'help:0;resizable:1;dialogWidth:300px;dialogHeight:210px;');
//    var flag=window.showModalDialog('/jsp/admin/flow/SetFlowbusinessFC.jsp?community='+form1.community.value+'&flowbusiness='+form1.flowbusiness.value+'&info='+encodeURI(args?'确认结束流程,启动新流程?':'确认结束流程?')+'&t='+new Date().getTime(),self,'help:0;status:0;resizable:1;dialogWidth:600px;dialogHeight:420px;');
//    if(!flag)
//    return;
//    if(args)//启动新流程
//    {
//      form1.nextflow.value=args;
//    }
//  }
  form1.act.value=act;
  form1.submit();
}
</script>
</head>
<body>
<h1>转交下一步骤</h1>
<div id="head6"><img height="6" src="about:blank" alt=""></div>
<br>

<%=fb.getFlowviewToHtml(teasession._nLanguage)%>

<form name="form1" action="?" method="POST" onsubmit="return f_conv();">
<input type="hidden" name="flowbusiness" value="<%=flowbusiness%>">
<input type="hidden" name="community" value="<%=community%>">
<input type="hidden" name="nexturl" value="<%=nexturl%>">
<input type="hidden" name="flow" value="<%=flow%>">
<input type="hidden" name="nextflow" value="0">
<input type="hidden" name="filecenter" value="<%=filecenter%>">
<input type="hidden" name="act">
<input type="hidden" name="start">
<%
if(f.getType()==1)//如果是自由流程////////////////
{
%>
  <table border=0 cellpadding=0 cellspacing=0 id=tablecenter>
    <tr>
      <td>请指定下一步骤的经办人:</td>
      <td><input type=text name=members></td>
    </tr>
  </table>
  <input type="submit" name="submits" value="提交"/>
  <%=fb.getStopbuttonToHtml(teasession._nLanguage)%>
  <input type="button" value="返回" onclick="window.history.back(-1);"/>
<%
}else
{
  //可控流程:如果还没有走到主控步骤,和固定流程一样.
  String maintransactor=fb.getMainTransactor();
  String mainconsign=fb.getMainConsign();

  if(f.getType()==0 || fp.isSerial() || maintransactor==null || maintransactor.length()==0)
  {
    Flowprocess fp1=Flowprocess.find(flow,fb.getStep()+1);
    if(!fp1.isExists())
    {
      out.print(fb.getStopbuttonToHtml(teasession._nLanguage));
      out.print("<input type=button value=返回 onclick='window.history.back();'>");
    }else
    {
      %>
      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <%
      if(fb.getFlow()==2&&fb.getStep()==3)//收文流程：部门处理步 选择跳转
      {
        out.print("<tr><td>请选择下一步:</td><td><input name='step' type='radio' value='4' onclick='f_change()' checked id='_st4' /><label for='_st4'>"+fp1.getName(teasession._nLanguage)+"</label>");
        Flowprocess fp6=Flowprocess.find(2,1);
        out.print(" <input name='step' type='radio' value='1' onclick='f_change(true)' id='_st1' /><label for='_st1'>文件管理员</label>");
        out.print("<script>function f_change(b){ var tdm=$('tdm');if(!tdm.old)tdm.old=tdm.innerHTML; if(b)tdm.innerHTML=\""+fp6.getMemberToHtml(flowbusiness)+"\";else tdm.innerHTML=tdm.old;}");
        if(fb.nextstep>0)
          out.print("window.onload=function(){ form1.step["+(fb.nextstep==1?1:0)+"].click(); t=form1.step; for(var i=0;i<t.length;i++)t[i].disabled=!t[i].checked; }");
        out.print("</script>");
      }
      %>
        <tr>
          <td style="width:260px">请指定下一步骤的经办人:</td>
          <td id='tdm'><%=fp1.getMemberToHtml(flowbusiness)%></td>
        </tr>
      </table>
      <input type="submit" name="submits" value="提交"/>
      <input type="button" value="返回" onclick="window.history.back();"/>
      <%
    }
  }else if(f.getType()==2&&f.getMainProcess()==fp.getFlowprocess())//member.equals(fb.getCreator()) || member.equals(maintransactor)||member.equals(mainconsign) )///控制流程转向
  {
    StringBuffer js=new StringBuffer();
    out.print("<table border=0 cellpadding=0 cellspacing=0 id=tablecenter>");
    out.print("<tr><td width='20%'>选定下一步:</td><td><select name=flowprocess onchange=f_change(this.value);><option value=''>-----------------------------");
    Enumeration e=Flowprocess.find(flow,"");
    while(e.hasMoreElements())
    {
      int id=((Integer)e.nextElement()).intValue();
      if(id!=f.getMainProcess()&&id!=fb.getStep())//不能是主控步和当前步
      {
        Flowprocess fp2=Flowprocess.find(id);
        int extend=fp2.getExtend();
        out.print("<option value="+id+">"+fp2.getStep()+". "+fp2.getName(teasession._nLanguage));
        String h=fp2.getMemberToHtml(flowbusiness);
        int j=h.lastIndexOf("<script>");
        String eval="";
        if(j!=-1)
        {
          eval=h.substring(j+8,h.length()-9);
          h=h.substring(0,j);
        }
        js.append("case ").append(id).append(": $('trdist').style.display='"+(id==f.getDistProcess()?"":"none")+"'; tdm.innerHTML=\""+h+"\";  eval(\""+eval+"\"); break; \r\n");
      }
    }
    out.print("</select>");
    int defPrint=0;
    if(f.getDynamic()==1032)//发文流程
    {
      try
      {
        defPrint=Integer.parseInt(DynamicValue.find(-flowbusiness, teasession._nLanguage, 100).getValue());
      }catch(Exception ex)
      {}
    }
    out.println("<tr id='trdist' style='display:none'><td>打印份数:</td><td><input name='prints' size='8' value='"+MT.f(defPrint)+"' mask='int' />份</td>");
    out.println("<tr><td>经办人:</td><td id=tdm>&nbsp;</td>");
    out.println("<tr><td>通知:</td><td><input name=message type=checkbox checked onclick_=\"trmsg.style.display=checked?'':'none'; form1.message.disabled=!checked;\" id='message'><label for='message'>站内信</label>");
    //当前社区存在发短信业务...
    CommunityOption co = CommunityOption.find(community);
    if(co.get("smstype")!=null)
    {
      out.println("<input type=checkbox onclick=\"trsms.style.display=checked?'':'none'; form1.sms.disabled=!checked;\" id='smsc'><label for='smsc'>手机短信</label>");
    }
    //out.println("<input name=mail type=checkbox >外部邮件");
    out.print("</td></tr>");
    out.print("<tr id=trsms style='display:none'><td>短信内容:</td><td>"+SMSMessage.contentToHtml(teasession,"sms")+"<script>form1.sms.value=\"工作流提醒:您有《"+fb.name+"》工作需要办理！\";</script>");
    //out.print("<tr id=trmsg><td>站内信内容:</td><td><textarea name=message cols='45' rows='5' ></textarea>");
    out.print("</td></table>");
    out.print("<script>function f_change(v){ switch(parseInt(v)){ "+js.toString()+" default: tdm.innerHTML=''; } }</script>");
    out.print("<input type=submit name='submits' value=提交 onclick=\"return submitText(form1.flowprocess,'无效-下一步')&&(!form1.sms.checked||submitText(form1.smssubject,'无效-短信通知'));\"> ");
    out.print(fb.getStopbuttonToHtml(teasession._nLanguage));
    out.print(" <input type=button value=返回 onclick=window.history.back();>");
  }else//回主控
  {
    //out.print("<table border=0 cellpadding=0 cellspacing=0 id=tablecenter><tr><td>下一步骤的经办人:</td><td><input name=members type=hidden value="+fb.getCreator()+">");
    //out.print("</td></tr></table>");
    //out.print("<input name=members type=hidden value="+fb.getCreator()+">");
    out.print("<input name=members type=hidden value="+maintransactor+" label='文件管理员'>");
    if(mainconsign!=null&&mainconsign.length()>0)
    {
      out.print("<input name=members type=hidden value="+mainconsign+">");
    }
    out.print("<input type=submit name='submits' value=提交 > <input type=button value=返回 onclick=window.history.back();>");
  }
}
%>
</form>
<script>
function f_conv()//下拉菜单 转 input.members
{
  if(form1.flowprocess&&form1.flowprocess.value=="<%=f.getDistProcess()%>")
  {
    if(!submitInteger(form1.prints,"请填写“打印份数”"))
    return false;
  }
  if(!form1.members&&form1.act.value!='stop')
  {
    if(form1.name.value=="")
    {
      alert("请指定下一步骤的经办人");
      return false;
    }
    var arr=form1.to.value.split("/");
    for(var i=1;i<arr.length-1;i++)
    {
      var ms=document.createElement("INPUT");
      ms.type="hidden";
      ms.name="members";
      ms.value=arr[i];
      form1.appendChild(ms);
    }
  }
  <%
  if(f.getDistProcess()==fp.getFlowprocess())
  {
    int corg=AdminUnitOrg.find(teasession._strCommunity,fb.getCreator());//创建者公司
    int morg=AdminUnitOrg.find(teasession._strCommunity,member);//办理者公司
    //总公司发文 接收人为分子公司人员
    if(flow==1&& corg>0&& AdminUnitOrg.find(teasession._strCommunity,0)==corg && morg>0&&AdminUnitOrg.find(teasession._strCommunity,1)==morg)
    {
      if(!Flowbusiness.findByCommunity(teasession._strCommunity," AND prev="+flowbusiness).hasMoreElements())
      out.print("form1.start.value=confirm('是否启动收文流程？');");
    }
  }
  %>
}

var ms=document.all("members");
if(!form1.flowprocess  //不存在"请选择下一步"
&&ms&&((!ms.length&&ms.type!="text")||f_try()))
{
  if(confirm("确认转给“"+<%=flow==43&&fb.getStep()==2?"'核稿人'":"(ms.label||ms.value)"%>+"”吗?"))
    form1.submits.click();
  else
    window.open(form1.nexturl.value,"_self");
}

function f_try()
{
  for(var i=0;i<ms.length;i++)
  {
    if(ms[i].type!="hidden"&&ms[i].style.display!='none')
	return false;
  }
  return true;
}
function f_add(count,en)
{
  var win=window.open('about:blank','fb_dl_add','width=460px,height=340px,top=300px,left=400px,resize=1');
  win.focus();
  try{win.document.write("加载中...");}catch(e){}
  formadd.count.value=count;
  formadd.enabled.value=en;
  formadd.submit();
}
</script>

<!-- 经办人 -->
<form name="formadd" action="/jsp/user/list/SelMembers2.jsp?community=<%=community%>&member=form1.to&unit=form1.tunit&name=form1.name" method="post" style="display:none" target="fb_dl_add">
<input name="count" type="hidden" value="" />
<input name="enabled" type="hidden" value="" />
</form>


<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
