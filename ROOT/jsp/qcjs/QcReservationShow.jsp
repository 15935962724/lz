<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.photography.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.html.*"%>
<%@page import="tea.db.*"%><%@page import="tea.entity.member.*"%><%@page import="tea.resource.*"%><%@page import="java.util.*"%><%@page import="java.io.*"%>
<%@page import="java.net.URLEncoder"%><%@page import="tea.entity.Entity"%><%@page import="tea.entity.qcjs.*" %>

<% 
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);


String nexturl = teasession.getParameter("nexturl");



int rid = 0;
if(teasession.getParameter("rid")!=null && teasession.getParameter("rid").length()>0){
	rid  = Integer.parseInt(teasession.getParameter("rid"));
}
 QcReservation robj = QcReservation.find(rid);

 
 
%>

<html>
<head>
<title>在线预约会员登记表详细信息</title>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/Calendar.js" type="text/javascript"></script>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

</head>
<body >
<div id="head6"><img height="6" src="about:blank"></div>


  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id=tableonetr>
	       <td nowrap align="center" colspan="2"><div align="center">全程驾驶俱乐部预约登记表</div></td>
	     
    </tr>
    <tr id=tableonetr>
	       <td nowrap align="right"><font color="red">*</font>&nbsp;姓名：</td>
	       <td nowrap><%if(rid>0){out.print(Entity.getNULL(robj.getName()));}%></td>
	       
    </tr>
       <tr id=tableonetr>
    	 <td nowrap align="right">电话：</td>
	       <td nowrap><%if(rid>0){out.print(Entity.getNULL(robj.getTelephone()));}%></td>
    </tr>
    <tr id=tableonetr>
	       <td nowrap align="right"><font color="red">*</font>&nbsp;驾驶证号：</td>
	       <td nowrap><%if(rid>0){out.print(Entity.getNULL(robj.getCard()));}%></td>
    </tr>
     <tr id=tableonetr>
	       <td nowrap align="right"><font color="red">*</font>&nbsp;参加活动：</td>
	       <td nowrap><%=tea.entity.node.Node.find(robj.getActivity()).getSubject(teasession._nLanguage)%></td>
    </tr>
    <tr id=tableonetr>
	       <td nowrap align="right"><font color="red">*</font>&nbsp;接车方式：</td>
	       <td nowrap><%if(robj.getManner()==1){out.println("驾校集合");}else{out.print("接车地点&nbsp;&nbsp;");out.print(Entity.getNULL(robj.getMannerlocation()));} %> </td>
    </tr>
    
     <tr id=tableonetr>
	       <td nowrap align="right"><font color="red">*</font>&nbsp;活动形式：</td>
	       <td nowrap><%if(robj.getForms()==1)out.print("坐车");else{out.print("开车:"+QcReservation.FORMS_TYPE[robj.getForms3()]);} %></td>
    </tr>
        <tr id=tableonetr>
	       <td nowrap align="right">备注：</td>
	       <td nowrap><%=Entity.getNULL(robj.getNotes()) %></td>
    </tr>
  </table>
  <br/>
   <input name="按钮" id="printbutton1" type="button" onClick="window.print();" value="　打　印　">

     
  <input type="button" id="printbutton2" value="　返回　" onClick="window.open('<%=nexturl %>','_self');">&nbsp;
  
  <object  id="WebBrowser"  width=0  height=0  classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2"></object>
  <script>
  	
      
      //-----  下面是打印控制语句  ----------
      window.onbeforeprint=beforePrint;
      window.onafterprint=afterPrint;

      var hkey_root,hkey_path,hkey_key;
      hkey_root="HKEY_CURRENT_USER";
      hkey_path="\\Software\\Microsoft\\Internet Explorer\\PageSetup\\";
//设置网页打印的页眉页脚为空
    function pagesetup_null(){
     try{
             var RegWsh = new ActiveXObject("WScript.Shell");
             hkey_key="header"; 
             RegWsh.RegWrite(hkey_root+hkey_path+hkey_key,"");
             hkey_key="footer";
             RegWsh.RegWrite(hkey_root+hkey_path+hkey_key,"");
             }catch(e){
         }
    }
//设置网页打印的页眉页脚为默认值
    function pagesetup_default(){
     try{
             var RegWsh = new ActiveXObject("WScript.Shell");
             hkey_key="header" ;
             RegWsh.RegWrite(hkey_root+hkey_path+hkey_key,"&w&b页码，&p/&P");
             hkey_key="footer";
             RegWsh.RegWrite(hkey_root+hkey_path+hkey_key,"&u&b&d");
             print();
            }catch(e){}
        }


   

          //-----  下面是打印控制语句  ----------
          window.onbeforeprint=beforePrint;
          window.onafterprint=afterPrint;
          //打印之前隐藏不想打印出来的信息
          var printbutton1=document.getElementById('printbutton1');
          var printbutton2=document.getElementById('printbutton2');
          function beforePrint()
          {
            printbutton1.style.display='none';
            printbutton2.style.display='none';
          }
          //打印之后将隐藏掉的信息再显示出来
          function afterPrint()
          {
            printbutton1.style.display='';
            printbutton2.style.display='';
            //  window.close();
          }

          　　</SCRIPT>
      
  </script>
</form>
</body>
</html>
