<%@page import="tea.entity.node.Event"%>
<%@page import="tea.entity.node.Node"%>
<%@page import="tea.entity.util.Spell"%>
<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.resource.Resource" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.ui.TeaSession" %><%@page  import="java.util.*" %>
<%@page import="tea.entity.*"%><%@page import="tea.entity.volunteer.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.resource.*" %><%@page import="java.io.*" %>
<%

request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);
String community=teasession._strCommunity;


String firstname = teasession.getParameter("firstname");
if("POST".equals(request.getMethod()))
{
	 
	 String mobile = teasession.getParameter("mobile");
	 String member = null;
	   SeqTable seq = new SeqTable();
       final java.text.DecimalFormat df5 = new java.text.DecimalFormat("00000");
       if(firstname != null)
       {
           member = member = Spell.getSpell(firstname.replaceAll(" ","").toLowerCase()).replaceAll(" ","") + df5.format(seq.getSeqNo(teasession._strCommunity));
       }
       
       
        
       if(!Profile.isExisted(member))
       {
           Profile.create(member,"",teasession._strCommunity,"",null,1,teasession._nLanguage,firstname,"","","","","","","","","","",mobile);
           Profile pro = Profile.find(member);
           pro.setMobile(mobile);
          
       
           Volunteer.set(member,teasession._strCommunity,"","","","",4);
           //if(tongguo.equals("tongguo"))
           //{
               Volunteer.typeIf(member);
           //}
            
              
           	Node nobj = Node.find(teasession._nNode);
           	Event eobj =Event.find(teasession._nNode,teasession._nLanguage);
          
           	if(eobj.getRegmember()!=null && eobj.getRegmember().length()>0 && eobj.getRegmember().split("/").length>1)
           	{ 
           		if(eobj.getRegmember().indexOf("/"+member+"/")!=-1)//有
           		{
           			String s = eobj.getRegmember().replaceAll("/"+member,"");
           			eobj.setRegmember(s);
           			eobj.setRegmember();
           			
           		}else
           		{
           			String s = eobj.getRegmember()+member+"/";
           			eobj.setRegmember(s);
           			eobj.setRegmember();
           		}
           	}else
           	{
           		eobj.setRegmember("/"+member+"/");
           		eobj.setRegmember();
           	}
           
           
           
           
           
       }
       out.print("<script>alert('用户注册成功,并已经报名！');window.returnValue="+teasession._nNode+";window.close();</script>");
  	   return;   
       
}

%>
<html>
<HEAD>
<base target="dialog"/>
  <link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
  <link href="/tea/CssJs/Home.css" rel="stylesheet" type="text/css"/>
  <script src="/tea/tea.js" type="text/javascript"></script>
  <script src="/tea/mt.js" type="text/javascript"></script>
  <SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/load.js" type="text/javascript"></SCRIPT>
  <script src="/tea/Calendar.js" type="text/javascript"></script>
  <script type="text/javascript">
  window.name='dialog';
  function subs()
  {
 
    if(form1.firstname.value=="" )
    {
      alert("姓名不能为空！");
      form1.firstname.focus();
      return false;
    }

 
    
    if(form1.mobile.value=="" )
    {
      alert("手机号不能为空！");
      form1.mobile.focus();
      return false;
    }else
    {
    	var str = document.form1.mobile.value;
        var reg=/^(((13[0-9]{1})|150|151|152|153|154|155|156|157|158|159)+\d{8})$/;
        if(!reg.test(str)){
          alert("请填写正确的手机号！");
          form1.mobile.focus();
          return false;
        }

    }

    

    
   
  
    
    return true;
  }
  
	 

  
  </script>
  </HEAD> 
  <body id="bodyvl">
  <h1>志愿者报名表</h1>
  <form name="form1" action="?" method="POST"  target="dialog" >

<input type="hidden" name="community" value="<%=community %>"> 
<input type="hidden" name="act" value="EditVolunteer2" >

<input type="hidden" name="node" value="<%=teasession._nNode %>" >





  <TABLE border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
 
    <tr>
      <td align="right">*&nbsp;姓名：</td>
      <td><input type="text" size="20" name="firstname" value="<%=Entity.getNULL(firstname) %>"></td>
       
    </tr>
     <tr>
      <td align="right">*&nbsp;手机：</td>
      <td><input type="text" name="mobile" size="20"  mask="int" value=""></td>
    
       
    </tr>
   
    
  
   
   
</table>

 
  <br>
      <input type="submit" value="快速注册" name="submits" onclick="return subs();"/>&nbsp;
       <input type="button" value="关闭"  onClick="javascript:window.close();">
     

  </form>
  </body>
</html>
