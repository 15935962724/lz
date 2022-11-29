<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.Resource"  %>
<%@page  import="tea.entity.copyright.*" %>
<%@page import="tea.entity.*"%>
<%@page import="java.util.*"%>
<%@page import ="tea.entity.admin.*" %>
<%@page import ="tea.entity.member.*" %>
<%@ page import="tea.ui.TeaSession" %><%@page import="tea.entity.admin.orthonline.*"%>
<%@page import="jxl.*"%><%@page import="java.io.*"%><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

String nexturl=teasession.getParameter("nexturl");
String act=teasession.getParameter("act");

%><html>
<head>
  <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
  <SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
      <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
        <META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>
<%!
public String cellToString(Cell c)
{
  String str=c.getContents();
  if(str==null||"null".equals(str))
  {
    str=null;
  }
  return str;
}
public java.util.Date cellToDate(Cell c)
{
  String str=c.getContents();
  if(str==null||"null".equals(str))
  {
    str=null;
  }
  java.util.Date d=null;
  try
  {
    d=Entity.sdf2.parse(str);
  }catch(Exception ex)
  {
    try
    {
      d=Entity.sdf.parse(str);
    }catch(Exception ex2)
    {
      java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy年MM月dd日");
      try
      {
        d=sdf.parse(str);
      }catch(Exception ex3)
      {
        sdf = new java.text.SimpleDateFormat("MM/dd/yyyy");
        try
        {
          d=sdf.parse(str);
        }catch(Exception ex4)
        {

        }
      }
    }
  }
  return d;
}
%>
<%
StringBuffer sp = new StringBuffer();
byte by[]=teasession.getBytesParameter("file");
if(by!=null)
{
  ByteArrayInputStream bais=new ByteArrayInputStream(by);
  try
  {
    Workbook wb=Workbook.getWorkbook(bais);
    Sheet s=wb.getSheet(0);
    if(teasession.getParameter("import")!=null)
    {
      out.println("总行数:"+s.getRows()+" 正在导入:<span id=c >0</span>");
      out.flush();
      if("jituanyonghu".equals(act))//导入集团用户
      {
        int jj=1;
        long t = System.currentTimeMillis();
        for(int i=1;i<s.getRows();i++)
        {

          String xingming=null; //姓名
          String xingbie=null; //性别
          String youxiaozhengjian=null; //有效证件
          String youxiaozhengjianhao=null; //有效证件号码
          String chushengnianyue=null; //出生年月
          String gerenzhaopianname=null; //个人照片名称
          String gerenzhaopianpath=null; //个人照片地址
          String yszigezheng=null; //医师资格证
          String yszigezhengtime=null; //获取时间---医师资格证
          String yszhY=null;          String yszhM=null;          String yszhD=null;
          String yszhiyezheng=null; //医师执业证
          String yszhiyezhengtime=null; //获取时间---医师执业证
           String yszhY2=null;          String yszhM2=null;          String yszhD2=null;
          String jishuzhicheng1=null; //技术职称 1
          String jishuzhicheng2=null; //技术职称 2
          String jishuzhicheng3=null; //技术职称 3
          String xingzhengzhicheng=null; //现任行政职务1
          String xingzhengzhicheng2=null; //现任行政职务2
          String sheng=null; //所属省份
          String shi=null; //市（县）
          String gongzuodanwei=null; //工作单位
          String gongzuodanwei2=null; //请您填写您的单位名称:
          String yyjibie=null; //医院级别
          String yyxingzhi=null; //医院性质
          String suoshukeshi=null; //所属科室
          String danweidizhi=null; //单位地址
          String youbian=null; //邮编编码
          String danweidianhua=null; //单位电话1
          String danweidianhua2=null; //单位电话2
          String shoujihao=null; //手 机 号
          String email=null; //Email地址1
          String email2=null; //Email地址2
          String zhuanyefangxiang1=null; //专业方向 第一专业
          String zhuanyefangxiang2=null; //专业方向  第二专业
          String zhuanyefangxiang3=null; //专业方向 第三专业
//          String zyfx1=null;// 专业方向的--其他1
//          String zyfx2=null;// 专业方向的--其他2
//          String zyfx3=null;// 专业方向的--其他3
          String biyeyuanxiao1=null; //毕业院校名称--国内
          String biyeyuanxiao2=null; //毕业院校名称--国外
          String biyeshijian1=null; //毕业或肄业时间--国内
            String yszhY3=null;          String yszhM3=null;          String yszhD3=null;
          String biyeshijian2=null; //毕业或肄业时间--国外
            String yszhY4=null;          String yszhM4=null;          String yszhD4=null;
          String zuigaoxuewei1=null; //最高学位--国内
          String zuigaoxuewei2=null; //最高学位--国外
          String zuigaoxueli1=null; //最高学历--国内
          String zuigaoxueli2=null; //最高学历--国外
          String gerenjianli=null; //个人简历(从参加工作起)
          String jizhiqingkuang=null; //学会或社会兼职情况
          String community=null; //社区
          String times=null; //添加时间



          for(int j=0;j<s.getColumns();j++)
          {
            switch(j)
            {
              case 0://姓名
              xingming=cellToString(s.getCell(j,i));
              break;
              case 1://性别
              xingbie=cellToString(s.getCell(j,i));
              break;
              case 2://身份证
              youxiaozhengjian=cellToString(s.getCell(j,i));
              break;
              case 3://身份证号
              youxiaozhengjianhao=cellToString(s.getCell(j,i));
              break;
              case 4://出生年月
              chushengnianyue=cellToString(s.getCell(j,i));
              break;
              case 5://照片名称
              gerenzhaopianname=cellToString(s.getCell(j,i));
              break;
              case 6://照片地址
              gerenzhaopianpath=cellToString(s.getCell(j,i));
              break;
              case 7://医师证号
              yszigezheng=cellToString(s.getCell(j,i));
              break;
              case 8://医生证号 年 a2_year
              yszhY=cellToString(s.getCell(j,i));
              break;
              case 9://医生证号 月 a2_year
              yszhM=cellToString(s.getCell(j,i));
              break;
              case 10://医生证号 日 a2_year
              yszhD=cellToString(s.getCell(j,i));
              break;
              case 11://执业医师证号
              yszhiyezheng=cellToString(s.getCell(j,i));
              break;
              case 12://执业医师证号 年 a2_year
              yszhY2=cellToString(s.getCell(j,i));
              break;
              case 13://执业医师证号 月 a2_year
              yszhM2=cellToString(s.getCell(j,i));
              break;
              case 14://执业医师证号 日 a2_year
              yszhD2=cellToString(s.getCell(j,i));
              break;
              case 15://技术职称
              jishuzhicheng1=cellToString(s.getCell(j,i));
              break;
              case 16://行政职务
              xingzhengzhicheng=cellToString(s.getCell(j,i));
              break;
              case 17://省
              sheng=cellToString(s.getCell(j,i));
              break;
              case 18://市县
              shi=cellToString(s.getCell(j,i));
              break;
              case 19://工作单位 --医院
              gongzuodanwei=cellToString(s.getCell(j,i));
              break;
              case 20://医院级别
              yyjibie=cellToString(s.getCell(j,i));
              break;
              case 21://医院性质
              yyxingzhi=cellToString(s.getCell(j,i));
              break;
              case 22://科室
              suoshukeshi=cellToString(s.getCell(j,i));
              break;
              case 23://单位地址
              danweidizhi=cellToString(s.getCell(j,i));
              break;
              case 24://邮编
              youbian=cellToString(s.getCell(j,i));
              break;
              case 25://单位电话
              danweidianhua=cellToString(s.getCell(j,i));
              break;
              case 26://手机号
              shoujihao=cellToString(s.getCell(j,i));
              break;
              case 27://Email
              email=cellToString(s.getCell(j,i));
              break;
              case 28://从事专业
              zhuanyefangxiang1=cellToString(s.getCell(j,i));
              break;
              case 29://从事专业2
              zhuanyefangxiang2=cellToString(s.getCell(j,i));
              break;
              case 30://从事专业3
              zhuanyefangxiang3=cellToString(s.getCell(j,i));
              break;
              case 31://院校名称_国内
              biyeyuanxiao1=cellToString(s.getCell(j,i));
              break;
              case 32://国内毕业时间 年 a2_year
              yszhY3=cellToString(s.getCell(j,i));
              break;
              case 33://国内毕业时间 月 a2_year
              yszhM3=cellToString(s.getCell(j,i));
              break;
              case 34://国内毕业时间 日 a2_year
              yszhD3=cellToString(s.getCell(j,i));
              break;
              case 35://最高学位_国内
              zuigaoxuewei1=cellToString(s.getCell(j,i));
              break;
              case 36://最高学历_国内
              zuigaoxueli1=cellToString(s.getCell(j,i));
              break;
              case 37://院校名称_国外
              biyeyuanxiao2=cellToString(s.getCell(j,i));
              break;
              case 38://国外毕业时间 年 a2_year
              yszhY4=cellToString(s.getCell(j,i));
              break;
              case 39://国外毕业时间 月 a2_year
              yszhM4=cellToString(s.getCell(j,i));
              break;
              case 40://国外毕业时间 日 a2_year
              yszhD4=cellToString(s.getCell(j,i));
              break;
              case 41://最高学位_国外
              zuigaoxuewei2=cellToString(s.getCell(j,i));
              break;
              case 42://最高学历_国外
              zuigaoxueli2=cellToString(s.getCell(j,i));
              break;
              case 43://个人简历
              gerenjianli=cellToString(s.getCell(j,i));
              break;
              case 44://学会或社会兼职情况
              jizhiqingkuang=cellToString(s.getCell(j,i));
              break;
              case 45://
              times=cellToString(s.getCell(j,i));
              break;

            }

          }
           int sfz = 0;
          if(youxiaozhengjian!=null && youxiaozhengjian.length()>0)
          {
            if(youxiaozhengjian.trim().equals("身份证"))
            {
              sfz = 1;
            }else
            if(youxiaozhengjian.trim().equals("军官证"))
            {
              sfz = 2;
            }else
            if(youxiaozhengjian.trim().equals("文职证"))
            {
              sfz = 3;
            }else
            if(youxiaozhengjian.trim().equals("护照"))
            {
              sfz = 4;
            }else
            {
              sfz=0;
            }
          }else
          {
            sfz=0;
          }
          if(youxiaozhengjianhao!=null&&youxiaozhengjianhao.length()>0)
          {}else
          {
             youxiaozhengjianhao="000000";
          }

          String tupian ="";
          if(gerenzhaopianpath!=null&&gerenzhaopianpath.length()>0&&gerenzhaopianpath.indexOf(".")!=-1)
          {
            tupian= gerenzhaopianpath.substring(gerenzhaopianpath.lastIndexOf("/")+1, gerenzhaopianpath.length());
          }
          //医师证号
          if(yszigezheng==null&&"null".equals(yszigezheng))
          {
            yszigezheng = "0000";
          }
          if(yszhY!=null&&yszhY.length()>0&&yszhM!=null&&yszhM.length()>0&&yszhD!=null&&yszhD.length()>0)
          {
               yszigezhengtime=yszhY+"-"+yszhM+"-"+yszhD;
          }
          //执业医师证号
          if(yszhiyezheng==null&&"null".equals(yszhiyezheng))
          {
            yszhiyezheng = "0000";
          }
          if(yszhY2!=null&&yszhY2.length()>0&&yszhM2!=null&&yszhM2.length()>0&&yszhD2!=null&&yszhD2.length()>0)
          {
               yszhiyezhengtime=yszhY2+"-"+yszhM2+"-"+yszhD2;
          }
          //技术支持
          int jszc = 0;
          if(jishuzhicheng1!=null && jishuzhicheng1.length()>0)
          {
            for(int ds =0;ds<Doctor.JISHU_ZHICHENG.length;ds++)
            {
              if(Doctor.JISHU_ZHICHENG[ds].equals(jishuzhicheng1))
              {
                jszc=ds;
              }
            }
          }
          //xingzhengzhicheng行政职务
           int xzzw = 0;
          if(xingzhengzhicheng!=null && xingzhengzhicheng.length()>0)
          {
            for(int ds =0;ds<Doctor.XINGZHENG_ZHICHENG.length;ds++)
            {
              if(xingzhengzhicheng.equals(Doctor.XINGZHENG_ZHICHENG[ds]))
              {
                xzzw=ds;
              }
            }
          }
          //省
          int shengint = 0;
          if(sheng!=null && sheng.length()>0)
          {
            java.util.Enumeration e = Provinces.find(" AND type= 0");
            while(e.hasMoreElements())
            {
              int pid =((Integer)e.nextElement()).intValue();
              Provinces pobj = Provinces.find(pid);
              if(pobj.getProvincity().equals(sheng))
              {
                shengint = pid;
              }
            }
          }
           int shiint = 0;
           if(shi!=null && shi.length()>0)
           {
             java.util.Enumeration e = Provinces.find(" AND type!= 0");
             while(e.hasMoreElements())
             {
               int pid =((Integer)e.nextElement()).intValue();
               Provinces pobj = Provinces.find(pid);
               if(pobj.getProvincity().equals(shi))
               {
                 shiint = pid;
               }
             }
           }

           int gzdwint = 0;
           String gzdwint2="";
           int gongzuodanwei2s = 0;
           if(gongzuodanwei!=null && gongzuodanwei.length()>0)
           {
             gongzuodanwei = gongzuodanwei.trim();
             java.util.Enumeration  e = Hospital.find("",0,Integer.MAX_VALUE);
             while(e.hasMoreElements())
             {
               int hid =((Integer)e.nextElement()).intValue();
               Hospital hobj = Hospital.find(hid);
               if(hobj.getHoname().equals(gongzuodanwei))
               {
                 gzdwint = hid;
               }else
               {
                 gzdwint2 = gongzuodanwei;
                 gongzuodanwei2s=1;
               }
             }
           }
           if(shoujihao!=null&&shoujihao.length()>0){}else{shoujihao="000000";}
String e1="",e2="";
           if(email!=null&&email.length()>0&&email.indexOf("@")!=-1)
           {
             e1=email.split("@")[0];
             e2= email.split("@")[1];
           }
           //从事专业1
           int zyfx=0;
           if(zhuanyefangxiang1!=null&& zhuanyefangxiang1.length()>0)
           {
             for(int ds =0;ds<Doctor.ZHUANYE_FANGXIANG.length;ds++)
             {
               if(Doctor.ZHUANYE_FANGXIANG[ds].equals(zhuanyefangxiang1))
               {
                 zyfx=ds;
               }
             }
           }
           int zyfx2=0;
           if(zhuanyefangxiang2!=null&& zhuanyefangxiang2.length()>0)
           {
             for(int ds =0;ds<Doctor.ZHUANYE_FANGXIANG.length;ds++)
             {
               if(Doctor.ZHUANYE_FANGXIANG[ds].equals(zhuanyefangxiang2))
               {
                 zyfx2=ds;
               }
             }
           }
             int zyfx3=0;
           if(zhuanyefangxiang3!=null&& zhuanyefangxiang3.length()>0)
           {
             for(int ds =0;ds<Doctor.ZHUANYE_FANGXIANG.length;ds++)
             {
               if(Doctor.ZHUANYE_FANGXIANG[ds].equals(zhuanyefangxiang3))
               {
                 zyfx3=ds;
               }
             }
           }

            //院校名称_国内毕业时间
           if(yszhY3!=null&&yszhY3.length()>0&&yszhM3!=null&&yszhM3.length()>0&&yszhD3!=null&&yszhD3.length()>0)
           {
             biyeshijian1=yszhY3+"-"+yszhM3+"-"+yszhD3;
           }

           if(yszhY4!=null&&yszhY4.length()>0&&yszhM4!=null&&yszhM4.length()>0&&yszhD4!=null&&yszhD4.length()>0)
           {
             biyeshijian2=yszhY4+"-"+yszhM4+"-"+yszhD4;
           }
               Date ystime = null,biyeshijian1s=null,biyeshijian2s=null;
		   if(yszhiyezhengtime!=null&&yszhiyezhengtime.length()>0)
		   {
			   ystime =Doctor.sdf.parse(yszhiyezhengtime);
           }
           if(biyeshijian1 != null && biyeshijian1.length() > 0)
           {
               biyeshijian1s = Doctor.sdf.parse(biyeshijian1);
           }
		   if(biyeshijian2 != null && biyeshijian2.length() > 0)
		 {
			 biyeshijian2s = Doctor.sdf.parse(biyeshijian2);
		 }

          String times2=null;
          if(times!=null && times.length()>0)
          {
            times2 = times.replaceAll("/","-");
          }


           //继续写

          //添加医院排名统计表

          //添加医生报名表数据
          String honame = null;
          if(gzdwint > 0) //说明是选中的医院
          {
            Hospital hobj = Hospital.find(gzdwint);
            honame = hobj.getHoname().trim();
          } else //不是选中的医院
          {
            if(gzdwint2!=null){
              honame = gzdwint2.trim();
            }
          }

          if(Doctor.isZJ(community,youxiaozhengjianhao.trim())){
            //  Doctor.getZJ("orthonline",youxiaozhengjianhao.trim());

            if(DoctorRanking.isDrid(teasession._strCommunity,honame,shengint,shiint) > 0) //说明有这家医院
            {
              DoctorRanking drobj = DoctorRanking.find(DoctorRanking.isDrid(teasession._strCommunity,honame,shengint,shiint));
              drobj.setQuantity(drobj.getMrnumber() + 1,shengint,shiint);
            } else //没有这家医院 直接添加医院信息
            {
              DoctorRanking.create(honame,1,shengint,shiint,teasession._strCommunity);
            }


            Doctor.create(xingming, xingbie, String.valueOf(sfz), youxiaozhengjianhao, Doctor.sdf.parse(chushengnianyue),
            tupian, gerenzhaopianpath,yszigezheng ,Doctor.sdf.parse(yszigezhengtime), yszhiyezheng,
            ystime, jszc, xzzw, shengint, shiint, gzdwint,
            gzdwint2, yyjibie, yyxingzhi, suoshukeshi, danweidizhi, youbian, danweidianhua, shoujihao,
            e1,zyfx, zyfx2, zyfx3, biyeyuanxiao1, biyeyuanxiao2 ,biyeshijian1s ,biyeshijian2s, zuigaoxuewei1,zuigaoxuewei2, zuigaoxueli1, zuigaoxueli2, gerenjianli,
            jizhiqingkuang, teasession._strCommunity,gongzuodanwei2s,0,0,0,danweidianhua2,e2,null,null,null,Doctor.sdf.parse(times2));



            long t2 = System.currentTimeMillis();
            long t3 = t2-t;
            System.out.println("重复医生:"+jj+":"+xingming+":"+times+":"+times2+":"+t3);
            jj++;
          }



          if(i%5==0)
          {
            out.print("<script>c.innerHTML="+(i+1)+"</script>");
            out.flush();
          }

        }
      }
//        FileWriter fw = new FileWriter("c:/十三局member.txt",true);
//            fw.write(sp.toString());
//            fw.close();
      out.print("<script>window.open('/jsp/info/Succeed.jsp?nexturl='+encodeURIComponent(\""+nexturl+"\"),'_parent');</script>");
    }else
    {
      out.print("<table border=0 cellpadding=0 cellspacing=0 id=tablecenter>");

                    for(int i=0;i<s.getRows()&&i<21;i++)
                    {
                      out.print("<tr onMouseOver=this.bgColor='#BCD1E9' onMouseOut=this.bgColor=''>");
                      for(int j=0;j<s.getColumns();j++)
                      {
                        String str=s.getCell(j,i).getContents();
                        out.print("<td>"+("null".equals(str)?"&nbsp;":str));
                      }
                      out.print("</tr>");
                      if(i==20)
                      {
                        out.print("<tr><td colspan=8>总行数为:"+s.getRows()+".   只显示前20行.......</td></tr>");
                      }
                    }
                    out.print("</table>");
                  }
                  wb.close();
                }catch(Exception ex)
                {
                  out.print("<table style=color:#FF0000 border=0 cellpadding=0 cellspacing=0 id=tablecenter>");
                  out.print("<tr><td>错误:  可能有以下原因导致</td></tr>");
                  out.print("<tr><td>1.文件格式错误</td></tr>");
                  out.print("<tr><td>2.列没有匹配,请按照预览的格式进行调整.</td></tr>");
                  out.print("<tr><td>&nbsp;</td></tr>");
                  out.print("<tr><td>描述:</td></tr>");
                  out.print("<tr><td>"+ex.getMessage()+"</td></tr>");
                  out.print("</table>");
                  ex.printStackTrace();
                  //		response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("文件格式错误.","UTF-8"));
                  return;
                }finally
                {
                  bais.close();
                }
              }
              %>

</body>
</HTML>

