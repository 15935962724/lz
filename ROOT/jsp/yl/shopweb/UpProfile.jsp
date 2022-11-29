<%--
  Created by IntelliJ IDEA.
  User: zyj32
  Date: 2019/5/27
  Time: 15:56
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="tea.entity.*"%>
<%@ page import="tea.entity.member.Profile" %>
<%@ page import="tea.entity.yl.shop.UpProfile" %>
<%@ page import="java.util.List" %>
<%@ page import="tea.entity.yl.shop.EmpowerRecord" %>
<%@ page import="tea.entity.yl.shop.ShopHospital" %>
<%@ page import="tea.ui.yl.shop.ShopTps" %>
<%@ page import="tea.entity.yl.shop.TpsOrder" %>
<%@ page import="java.util.Date" %>
<%@ page import="util.DateUtil" %>
<%

    Http h=new Http(request,response);
    if(h.member<1)
    {
        response.sendRedirect("/servlet/StartLogin?community="+h.community);
        return;
    }

    StringBuffer sql=new StringBuffer(),par=new StringBuffer();
    int member = h.member;
    Profile p = Profile.find(member);
    String[] stateArr = {"<font color=blue>申请中</font>","<font color=green>申请成功</font>","<font color=red>申请失败</font>"};
    String[] uptypeArr = {"服务商","vip"};

    Date date = new Date();
    String yyyy = DateUtil.getStringFromDate(date, "yyyy");
    //粒子积分
    int lizijifen = TpsOrder.sumNumber(member, yyyy+"-01-01 00:00:00");
    //TPS扣除积分
    int tpsjifen = TpsOrder.jianNumber(member, yyyy + "-01-01 00:00:00");
    //当前积分
    int jifen = lizijifen-tpsjifen;


%>
<html>
<head>
    <title>升级申请</title>
    <script>
        var ls=parent.document.getElementsByTagName("HEAD")[0];
        document.write(ls.innerHTML);
        var arr=parent.document.getElementsByTagName("LINK");
        for(var i=0;i<arr.length;i++)
        {
            document.write("<link href='"+arr[i].href+"' rel='"+arr[i].rel+"' type='text/css'>");
        }
    </script>
    <script src='/tea/mt.js'></script>
    <script src='/tea/city.js'></script>
    <script src="/tea/tea.js" type="text/javascript"></script>
    <script src='/tea/jquery-1.3.1.min.js'></script>
    <link rel="stylesheet" href="/tea/new/css/style.css">
    <script src="/tea/new/js/jquery.min.js"></script>
    <script src="/tea/new/js/superslide.2.1.js"></script>
    <script src="/tea/yl/mtDiag.js"></script>
    <style>
        .con-left .bd:nth-last-child(2){
            display:block;
        }
        .con-left ul.bd:nth-last-child(2) li:nth-child(1){
            font-weight: bold;
        }
        .con-left-list .tit-on7{color:#044694;}

    </style>

</head>
<body style="min-height:800px;">
<%@ include file="/jsp/yl/shopweb/PersonalTop.jsp" %>
<div id="Content">
    <div class="con-left">
        <%@ include file="/jsp/yl/shopweb/PersonalLeft.jsp" %>
    </div>
    <div class="con-right">
        <p class="right-zhgl">
            <span>账户管理</span>
        </p>
        <p class="right-dz">
            <span>基本信息</span>
        </p>
        <div class="qualification right-list">

            <table id="tab1" class="right-tab4" cellspacing="0" style="background:none;">
                <tr>
                    <td class="td-left">用户名：</td>
                    <td class="td-right"><%=MT.f(p.member)%></td>
                </tr>
                <tr>
                    <td class="td-left">手机：</td>
                    <td class="td-right"><% if(!MT.f(p.mobile).equals("")){
                        out.print(MT.f(p.mobile)/*+"&nbsp;&nbsp;<a href='javascript:void(0);' onclick=oncheckpage('mobile','修改手机号') >修改</a>"*/);
                    }else{
                        out.print("还未绑定手机&nbsp;&nbsp;<a href='javascript:void(0);' onclick=onsetpage('mobile','绑定手机号')>绑定</a>");
                    }%></td>
                </tr>
                <tr>
                    <td class="td-left">邮箱：</td>
                    <td class="td-right" style='padding-bottom:45px;'><% if(!MT.f(p.email).equals("")){
                        out.print(MT.f(p.email)/*+"&nbsp;&nbsp;<a href='javascript:void(0);' onclick=oncheckpage('email','修改邮箱')>修改</a>"*/);
                    }else{
                        out.print("还未绑定邮箱&nbsp;&nbsp;<a href='javascript:void(0);' onclick=onsetpage('email','绑定邮箱') >绑定</a>");
                    }%></td>
                </tr>
                <tr>
                    <td class="td-left">积分：</td>
                    <td class="td-right"><%=jifen%> &nbsp;&nbsp;&nbsp;<button onclick="jfbgxq()">查看积分变更详情</button></td>
                </tr>

                <tr style='border-top:1px solid #dedede'>
                    <td style='padding:15px 10px;'>资质信息</td>
                    <td></td>
                </tr>

                <%

                    List<UpProfile> list = UpProfile.find("AND isdele=0 and profile=" + member, 0, Integer.MAX_VALUE);
                    if(list.size()==0){
                        if(p.membertype==0){
                %>

            </table>
            <%}}else if(list.size()!=0){
                UpProfile up = list.get(0);
                
                Profile m = Profile.find(up.getMember());
                if(up.getUptype()==0){
                %>
                
            <tr>
                <td class="td-left">服务商公司名称：</td>
                <td class="td-right"><%=MT.f(up.getCompany())%></td>
            </tr>
            <tr>
                <td class="td-left">升级类型：</td>
                <td class="td-right"><%=uptypeArr[up.getUptype()]%></td>
            </tr>
            <tr>
                <td class="td-left">营业执照：</td>
                <td class="td-right">
                    <%
                        if(up.getBusiness()>0){
                    %>
                    <a href='javascript:void(0);' onclick="downatt('<%= MT.enc(up.getBusiness()) %>');">查看</a>
                    <%
                        }else{
                            out.print("无文件!");
                        }
                    %>
                </td>
            </tr>
            <tr>
                <td class="td-left">开户许可证：</td>
                <td class="td-right">
                    <%
                        if(up.getLicense()>0){
                    %>
                    <a href='javascript:void(0);' onclick="downatt('<%= MT.enc(up.getLicense()) %>');">查看</a>
                    <%
                        }else{
                            out.print("无文件!");
                        }
                    %>
                </td>
            </tr>
            <tr>
                <td class="td-left">其他材料：</td>
                <td class="td-right">
                    <%
                        if(up.getOther()>0){
                    %>
                    <a href='javascript:void(0);' onclick="downatt('<%= MT.enc(up.getOther()) %>');">查看</a>
                    <%
                        }else{
                            out.print("无文件!");
                        }
                    %>
                </td>
            </tr>
            <%
                }
            %>
            <tr>
                <td class="td-left">申请时间：</td>
                <td class="td-right"><%=MT.f(up.getUptime())%></td>
            </tr>
            <tr>
                <td class="td-left">审核时间：</td>
                <td class="td-right"><%=MT.f(up.getExtime())%></td>
            </tr>
            <%
                if(up.getState()!=0){
            %>
			
            <%
                if(up.getState()==2){
            %>
            <tr>
                <td class="td-left">审核不通过原因：</td>
                <td class="td-right"><%=MT.f(up.getDescribe())%></td>
            </tr>
            <%
                    }
                }
                if(up.getUptype()==1){
                    List<EmpowerRecord> erList = EmpowerRecord.find(" and upid="+up.getUpid(), 0, 1);
                    EmpowerRecord er = erList.get(0);
                    ShopHospital hos = ShopHospital.find(er.getHospital());

            %>
            <tr>
                <td class="td-left">医院：</td>
                <td class="td-right"><%=MT.f(hos.getName())%></td>
            </tr>
			<tr>
                <td class="td-left">转入转出审批表：</td>
                <td class="td-right">
                    <%
                        if(er.getTurnApproval()>0){
                    %>
                    <a href='javascript:void(0);' onclick="downatt('<%= MT.enc(er.getTurnApproval()) %>');">查看</a>
                    <%
                        }else{
                            out.print("无文件!");
                        }
                    %>
                </td>
            </tr>
            <tr>
                <td class="td-left">辐射安全许可证：</td>
                <td class="td-right">
                    <%
                        if(er.getRadiationCard()>0){
                    %>
                    <a href='javascript:void(0);' onclick="downatt('<%= MT.enc(er.getRadiationCard()) %>');">查看</a>
                    <%
                        }else{
                            out.print("无文件!");
                        }
                    %>
                </td>
            </tr>
            <tr>
        <td class="td-left">辐射安全许可证有效期:</td>
        <td class="td-right">
            <%=MT.f(er.getRaditaionStart())%>至<%=MT.f(er.getRadiation())%>
        </td>
    </tr>
            <tr>
                <td class="td-left">放射诊疗许可证:</td>
                <td class="td-right">
                    <%
                        if(er.getRadiate()>0){
                    %>
                    <a href='javascript:void(0);' onclick="downatt('<%= MT.enc(er.getRadiate()) %>');">查看</a>
                    <%
                        }else{
                            out.print("无文件!");
                        }
                    %>
                </td>
            </tr>
            <tr>
                <td class="td-left">放射性药品使用许可证：</td>
                <td class="td-right">
                    <%
                        if(er.getRadiateCard()>0){
                    %>
                    <a href='javascript:void(0);' onclick="downatt('<%= MT.enc(er.getRadiateCard()) %>');">查看</a>
                    <%
                        }else{
                            out.print("无文件!");
                        }
                    %>
                </td>
            </tr>
            <tr>
                <td class="td-left">粒子签收人/发票签收人：</td>
                <td class="td-right">
                    <%
                        if(er.getSignFor()>0){
                    %>
                    <a href='javascript:void(0);' onclick="downatt('<%= MT.enc(er.getSignFor()) %>');">查看</a>
                    <%
                        }else{
                            out.print("无文件!");
                        }
                    %>
                </td>
            </tr>
            
            <%}
            %>
            <tr>
                <td class="td-left">状态：</td>
                <td class="td-right"><%=stateArr[up.getState()]%></td>
            </tr>
            </table>

            <%}%>
        </div>

    </div>
</div>

<form action="/Attchs.do" name="form9" method="post" target="_ajax">
    <input name="act" type="hidden" value="down" />
    <input name="attch" type="hidden" />
</form>
</body>
</html>
<script>
    function oncheckpage(type,tit){
        layer.open({
            type: 2,
            title: tit,
            shadeClose: true,
            area: ['475px', '260px'],
            closeBtn:1,
            content: '/jsp/yl/shopweb/ShopCheckEmailMobile.jsp?type='+type
        });
    }
    function checkInfo(id){
        layer.open({
            type: 2,
            title: '申请详情',
            shadeClose: true,
            area: ['475px', '505px'],
            closeBtn:1,
            content: '/jsp/yl/shop/UpgradeInfo2.jsp?upid='+id
        });
    }
    function onsetpage(type,tit){
        layer.open({
            type: 2,
            title: tit,
            shadeClose: true,
            area: ['475px', '270px'],
            closeBtn:1,
            content: '/jsp/yl/shopweb/ShopCheckEmaiupdate.jsp?type='+type+'&nexturl=/jsp/yl/shopweb/UpProfile.jsp'
        });
        //location = '/jsp/yl/shopweb/ShopEmailMobile.jsp?type='+type;
    }

    mt.receive=function(h,n){
        //$("#"+n).val(h);
        //fchange(h,n);
        form1.hospital.value=h;
        form1.hospitals.value=n;
    }
    function downatt(num){
        form9.attch.value = num;
        form9.submit();
    }
    mt.fit();

    function jfbgxq() {

        location.href="/jsp/yl/shopweb/jfbgxq.jsp";

    }


</script>