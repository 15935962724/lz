<%@page import="tea.entity.trust.TrustCompany"%>
<%@page import="tea.entity.trust.TrustProduct"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.ui.*"%><%@page import="tea.entity.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.entity.member.*"%><%@page import="tea.entity.sup.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?node="+h.node);
  return;
}

boolean _bNew=request.getParameter("NewNode")!=null;
String nexturl=h.get("nexturl","");
int node=h.getInt("node");
TrustProduct t=new TrustProduct(node);

if(_bNew){
	t=TrustProduct.find(0);
}else{
	t=TrustProduct.find(h.node);
	Node n=Node.find(node);
}





%><html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/city.js" type="text/javascript"></script>
<style type="text/css">
#gzd{position:absolute;position: relative;z-index:4;}
#gzd2{position:absolute;position: relative;z-index:2;}
#xilidiv{display:block;position: relative;position:absolute;height: auto;width: 281px;left: 0px;top: 19px;z-index:13;}
#xilidiv2{display:block;position: relative;position:absolute;height: auto;width: 155px;left: 0px;top: 19px;z-index:12;}
#tablecenter #xiaoliajatable{background:#ffffff;width: 281px;}
#tablecenter #xiaoliajatable td{padding:4px 5px 2px 5px;height:18px;border-collapse:collapse;border:1px solid #9BB7CC;border-top:0;}
#tablecenter #xiaoliajatable2{background:#ffffff;width: 155px;}
#tablecenter #xiaoliajatable2 td{padding:4px 5px 2px 5px;height:18px;border-collapse:collapse;border:1px solid #9BB7CC;border-top:0;}

#gzd3{position:absolute;position: relative;z-index:3;}
#xilidiv3{position:absolute;width: 200px;left: 0px;top: 19px;height:300px; z-index:15;}
#tablecenter #xiaoliajatable3{background:#ffffff;width: 155px;}
#tablecenter #xiaoliajatable3 td{padding:4px 5px 2px 5px;height:18px;border-collapse:collapse;border:1px solid #9BB7CC;border-top:0;}
</style>
<script type="text/javascript">
mt.receive=function(a,b,c)
{
	$$('t_s').innerHTML=a;
};
function chnews(obj,e,divname){
	if(e.toElement){
		if((!obj.contains(e.toElement))){
			document.getElementById(divname).style.display='none';
		}
	}
	//document.getElementById('xilidiv2').style.display='none';
}
function changeexperts(ntext){
	var nname="";
	if(!ntext){
		nname=document.getElementById("companyName").value;
	}
	sendx("/TrustProducts.do?act=changecom&ename="+encodeURIComponent(nname,"UTF-8"),
	function(data){
		document.getElementById("expertsshow").innerHTML=data;
	});
}
function setexperts(name,node){
	document.getElementById("companyName").value=name;
	document.getElementById("companyNode").value=node;
	document.getElementById("xilidiv3").style.display='none';
	}
</script>
</head>
<body>
<h1>编辑信托产品信息</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form2" action="/TrustProducts.do" method="post" enctype="multipart/form-data"  onsubmit="return mt.check(this)&&mt.show(null,0)">
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<input type="hidden" name="node" value="<%=node%>"/>
<input type="hidden" name="NewNode" value="<%=_bNew%>"/>

<table id="tablecenter" cellspacing="0">
  <tr>
    <td class="th">产品名称：</td>
    <td colspan="3"><input name="name" value="<%=MT.f(t.name)%>"  size="30" alt="产品名称"/></td>
  </tr>
  <tr>
    <td class="th">预期年化收效：</td>
    <td colspan="3"><input name="income1" value="<%=t.income1%>"  size="3" alt="预期年化收效"/>% 至 <input name="income2" value="<%=t.income2%>"  size="3" alt="预期年化收效"/>%</td>
  </tr>
  <tr>
    <td class="th" width="10%">发行机构：</td>
    <td width="40%">
    <div id="t_s" alt="" style="width:740px;height:auto;">
    <%
    if(t.companyNode>0){
    	out.print("<span id='_q" + t.companyNode + "' path=''><input type='hidden' name='companyNode' value='" + t.companyNode + "' />" +TrustCompany.find(t.companyNode).nameMsg + "<img src='/tea/image/d7.gif' onclick='mt.fdel(this)' /></span>");
    }else{
    	out.print("<span id='_q' path=''><input type='hidden' name='companyNode' value='0' /></span>");
    }
    %>
    </div>
    
    <span id="expertsshow" ><input type="button" value="选择发行机构" onclick="mt.show('/jsp/type/trustproduct/serchMsg.jsp',2,'选择发行机构',500,600)"></span>
    
    </td>
    <td class="th" width="10%">发行地区：</td>
    <td width="40%">
   
    <script>mt.city("city0","city1","","<%=t.city%>")</script>
   
    </td>
  </tr>
  <tr>
    <td class="th">发行日期：</td>
    <td><input name="releaseTime" value="<%=MT.f(t.releaseTime)%>" onClick="mt.date(this)" readonly class="date" size="30"/></td>
    <td class="th">收益分配：</td>
    <td><select name="distribution">
    <%
     for(int i=0;i<TrustProduct.DISTRIBUTION.length;i++){%>
     <option value="<%=i%>" <%=i==t.distribution?"selected":"" %>><%=TrustProduct.DISTRIBUTION[i] %></option>
    <% 
     }
    %>
    
    </select></td>
  </tr>
  <tr>
    <td class="th">投资规模：</td>
    <td><input name="sizeOf" value="<%=t.sizeOf==null?0:t.sizeOf%>"  size="15" />万元</td>
    <td class="th">投资门槛：</td>
    <td><input name="threshold" value="<%=t.threshold==null?0:t.threshold%>"  size="15"/>万元</td>
  </tr>
  <tr>
  <td class="th">产品期限（月）：</td>
    <td><input name="timeLimit" value="<%=t.timeLimit2>0?t.timeLimit1+"-"+t.timeLimit2:t.timeLimit1%>"  size="30" alt="产品期限"/><span style="color: red">如果是范围请用“-”隔开,如“12-24”,表示12月-24月</span></td>
    
    <td class="th">资金投向：</td>
    <td>
    <select name="field">
    <%
     for(int i=0;i<TrustProduct.FIELD.length;i++){%>
     <option value="<%=i%>" <%=i==t.field?"selected":"" %>><%=TrustProduct.FIELD[i] %></option>
    <% 
     }
    %>
    
    </select>
    </td>
  </tr>
  <tr>
    <td class="th">监管机构：</td>
    <td><input name="regulatory" value="<%=MT.f(t.regulatory)%>"  size="30" /></td>
    <td class="th">投资方式：</td>
    <td>
    <select name="investmentWay">
    <%
     for(int i=0;i<TrustProduct.INVESTMENTWAY.length;i++){%>
     <option value="<%=i%>" <%=i==t.investmentWay?"selected":"" %>><%=TrustProduct.INVESTMENTWAY[i] %></option>
    <% 
     }
    %>
    
    </select>
    </td>
  </tr>
  <tr>
    <td class="th">托管银行：</td>
    <td><input name="bankName" value="<%=MT.f(t.bankName)%>"  size="30"/></td>
    <td class="th">银行账号：</td>
    <td><input name="bankNum" value="<%=MT.f(t.bankNum)%>"  size="30"/></td>
  </tr>
  <tr>
    <td class="th">产品类型：</td>
    <td>
    <select name="type">
    <%
     for(int i=0;i<TrustProduct.TYPE.length;i++){%>
     <option value="<%=i%>" <%=i==t.type?"selected":"" %>><%=TrustProduct.TYPE[i] %></option>
    <% 
     }
    %>
    
    </select>
    </td>
    <td class="th">收益类型：</td>
    <td>
    <select name="earningsType">
    <%
     for(int i=0;i<TrustProduct.EARNINGSTYPE.length;i++){%>
     <option value="<%=i%>" <%=i==t.earningsType?"selected":"" %>><%=TrustProduct.EARNINGSTYPE[i] %></option>
    <% 
     }
    %>
    
    </select>
    </td>
  </tr>
  <tr>
    <td class="th">产品状态：</td>
    <td colspan="3">
    <select name="state">
    <%
     for(int i=0;i<TrustProduct.STATE.length;i++){%>
     <option value="<%=i%>" <%=i==t.state?"selected":"" %>><%=TrustProduct.STATE[i] %></option>
    <% 
     }
    %>
    
    </select>
    </td>
  </tr>
  <tr>
    <td class="th">收益详情：</td>
    <td colspan="3"><textarea  name="earnings" rows="3" cols="90"><%=MT.f(t.earnings) %></textarea></td>
  </tr>
  <tr>
    <td class="th">资金用途：</td>
    <td colspan="3"><textarea  name="maneyUse" rows="3" cols="90"><%=MT.f(t.maneyUse) %></textarea></td>
  </tr>
  <tr>
    <td class="th">风控措施：</td>
     <td colspan="3"><textarea style="display:none" name="measures" rows="12" cols="90"><%=MT.f(t.measures) %></textarea><iframe id="editor" src="/jsp/include/FCKeditor/editor/fckeditor.html?InstanceName=measures&Toolbar=<%=h.community%>" width="735" height="300" frameborder="no" scrolling="no"></iframe></td>
  </tr>
</table>


<br/>
<input type="submit" value="提交"/> <input type="button" value="返回" onclick="history.back();"/>
</form>



