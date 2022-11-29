<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.yl.shop.*"%><%@page import="tea.entity.member.Profile"%>
<%@page import="tea.entity.yl.shopnew.*"%><%@page import="tea.entity.member.*"%>
<%

//ShopOrder.changeInvoiceNA();


Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}



%><!DOCTYPE html><html><head>
<script>
var ls=parent.document.getElementsByTagName("HEAD")[0];
document.write(ls.innerHTML);
var arr=parent.document.getElementsByTagName("LINK");
for(var i=0;i<arr.length;i++)
{
	  document.write("<link href='"+arr[i].href+"' rel='"+arr[i].rel+"' type='text/css'>");
}

</script> 

<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<script src="/tea/jquery-1.11.1.min.js"></script>
<style>
.mt_data td,.mt_data th{padding:3px}

input[type=text]::-ms-clear{

                display: none;

                 

            }

            input::-webkit-search-cancel-button{

                display: none;

            }  

            input.t {

                border:1px solid #fff;

                background:#fff;            

                padding-left:5px; 

                height:30px; 

                line-height:30px ;

                font-size:12px;

                font-color: #004779;

                 

            } 
</style>

</head>
<body style='min-height:300px'>
<button onclick="fnsms()">发送短信</button>
<script type="text/javascript">
function fnsms(){
	<%
	SMSMessage.create("Home", "yantong", "15010809627", h.language, "你好!");
	%>
}
</script>
</body>
</html>
