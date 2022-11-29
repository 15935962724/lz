package dzews;
import java.awt.*;
import java.net.*;
import java.awt.event.*;
import java.io.*;
import java.util.Hashtable;

public class ChatArea extends Panel implements ActionListener,Runnable
{
  Socket  socket=null;                               
  DataInputStream in=null;                           
  DataOutputStream out=null;                         
  Thread threadMessage=null;                         
  TextArea 谈话显示区,私聊显示区=null;
  TextField 送出信息=null;
  Button 确定,刷新谈话区,刷新私聊区;
  Label  提示条=null;
  String name=null;                                  
  Hashtable listTable;                               
  List  listComponent=null;                          
  Choice privateChatList;                             
  int width,height;                                   
  public ChatArea(String name,Hashtable listTable,int width,int height)
  {
    setLayout(null); 
    setBackground(Color.orange);
    this.width=width;
    this.height=height;
    setSize(width,height);
    this.listTable=listTable;
    this.name=name;
    threadMessage=new Thread(this); 
    谈话显示区=new TextArea(10,10);
    私聊显示区=new TextArea(10,10);
    确定=new Button("送出信息到:");
    刷新谈话区=new Button("刷新谈话区");
    刷新私聊区=new Button("刷新私聊区");
    提示条=new Label("双击聊天者可私聊",Label.CENTER);
    送出信息=new TextField(28);
    确定.addActionListener(this);
    送出信息.addActionListener(this);
    刷新谈话区.addActionListener(this);
    刷新私聊区.addActionListener(this);
    listComponent=new List();
    listComponent.addActionListener(this);           
    privateChatList=new Choice();
    privateChatList.add("大家(*)");
    privateChatList.select(0);                      
   
    add(谈话显示区);
    谈话显示区.setBounds(10,10,(width-120)/2,(height-120)); 
    add(私聊显示区);
    私聊显示区.setBounds(10+(width-120)/2,10,(width-120)/2,(height-120));
    add(listComponent);
    listComponent.setBounds(10+(width-120),10,100,(height-160));
    add(提示条);
    提示条.setBounds(10+(width-120),10+(height-160),110,40);
    Panel  pSouth=new Panel();
    pSouth.add(送出信息);
    pSouth.add(确定);
    pSouth.add(privateChatList);
    pSouth.add(刷新谈话区);
    pSouth.add(刷新私聊区); 
    add(pSouth);
    pSouth.setBounds(10,20+(height-120),width-20,60);
  
  }
 public void setName(String s)
  {
    name=s;
  }
 public void setSocketConnection(Socket socket,DataInputStream in,DataOutputStream out)
  {
    this.socket=socket;
    this.in=in;
    this.out=out;
    try
         { 
           threadMessage.start();
         }
    catch(Exception e)
         {
         } 
  }
 public void actionPerformed(ActionEvent e)
  {
   
   if(e.getSource()==确定||e.getSource()==送出信息)
     {  
        String message="";
        String people=privateChatList.getSelectedItem();
        people=people.substring(0,people.indexOf("("));     
        message=送出信息.getText();
        if(message.length()>0)
        {
         try {
               if(people.equals("大家"))
                 {
                   out.writeUTF("公共聊天内容:"+name+"说:"+message);
                 }
               else
                 {
                   out.writeUTF("私人聊天内容:"+name+"悄悄地说:"+message+"#"+people);
                 } 
             }
         catch(IOException event)
             {
             }
        }
     }
    else if(e.getSource()==listComponent)
     {
       privateChatList.insert(listComponent.getSelectedItem(),0);
       privateChatList.repaint();
     }
    else if(e.getSource()==刷新谈话区)
     {
       谈话显示区.setText(null);
     }
    else if(e.getSource()==刷新私聊区)
     {
       私聊显示区.setText(null);
     }
  }  
 public void run()                    
  {
     while(true)
        {
           String s=null;
            try
               { 
                 s=in.readUTF();               
                 if(s.startsWith("聊天内容:")) 
                    {
                      String content=s.substring(s.indexOf(":")+1);
                      谈话显示区.append("\n"+content);
                    }
                 if(s.startsWith("私人聊天内容:")) 
                    {
                      String content=s.substring(s.indexOf(":")+1);
                      私聊显示区.append("\n"+content);
                    }
                 else if(s.startsWith("聊天者:"))
                    {
                     String people=s.substring(s.indexOf(":")+1,s.indexOf("性别"));
                     String sex=s.substring(s.indexOf("性别")+2);
                     
                     listTable.put(people,people+"("+sex+")"); 
                     
                     listComponent.add((String)listTable.get(people)); 
                     listComponent.repaint();                       
                    } 
                 else if(s.startsWith("用户离线:"))
                    {
                      String awayPeopleName=s.substring(s.indexOf(":")+1);
                      listComponent.remove((String)listTable.get(awayPeopleName));
                      listComponent.repaint();
                      谈话显示区.append("\n"+(String)listTable.get(awayPeopleName)+"离线"); 
                      listTable.remove(awayPeopleName);
                    }
                 Thread.sleep(5); 
               } 
            catch(IOException e) 
               {
                  listComponent.removeAll();
                  listComponent.repaint(); 
                  listTable.clear();
                  谈话显示区.setText("和服务器的连接已中断\n必须刷新浏览器才能再次聊天");
                  break;
               }
            catch(InterruptedException e)
               {
               }
        }
  }
}
