package dzews;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.IOException;
import java.net.InetAddress;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.Hashtable;
import  java.util.*;

public class ChatServer 
{  
  /*public static void main(String args[])
    {
     ServerSocket server=null;
     Socket you=null;
     Hashtable peopleList;                                
     peopleList=new Hashtable(); 
     while(true) 
            {
             try
                  { 
                    server=new ServerSocket(6666);
                  }
             catch(IOException e1) 
                  {
                     System.out.println("正在监听");
                  } 
             try  {
                     you=server.accept();                 
                     InetAddress address=you.getInetAddress();
                     System.out.println("用户的IP:"+address);
                     
                  }
             catch (IOException e)
                  {
                  }
             if(you!=null) 
                  {  
                     Server_thread peopleThread=new Server_thread(you,peopleList);
                     peopleThread.start();               
                  }
             else {
                    continue;
                  }
           }
  }
}
class Server_thread extends Thread
{  
   String name=null,sex=null;                            
   Socket socket=null;
   File file=null;
   DataOutputStream out=null;
   DataInputStream  in=null;
   Hashtable peopleList=null;
   Server_thread(Socket t,Hashtable list)
       { 
         peopleList=list;
         socket=t;
         try {
               in=new DataInputStream(socket.getInputStream());
               out=new DataOutputStream(socket.getOutputStream());
             }
         catch (IOException e)
             {
             }
        }  
 public void run()        
  {  
     
     while(true)
      {    String s=null;   
        try
           {
            s=in.readUTF();                       
            if(s.startsWith("姓名:"))             
              {
                name=s.substring(s.indexOf(":")+1,s.indexOf("性别"));  
                sex=s.substring(s.lastIndexOf(":")+1);          
                
              
                boolean boo=peopleList.containsKey(name);
                if(boo==false) 
                  {
                    peopleList.put(name,this);          
                    out.writeUTF("可以聊天:");
                  Enumeration cc=peopleList.elements();   
                     while(cc.hasMoreElements())            
                     {
                       Server_thread th=(Server_thread)cc.nextElement();
                       th.out.writeUTF("聊天者:"+name+"性别"+sex);  
                       
                       
                       if(th!=this)
                         {
                           out.writeUTF("聊天者:"+th.name+"性别"+th.sex);
                         } 
                     } 
                     
                  }
                else
                  {
                    out.writeUTF("不可以聊天:");
                  }
              }
            else if(s.startsWith("公共聊天内容:")) 
              {
                 String message=s.substring(s.indexOf(":")+1);
                 Enumeration aa=peopleList.elements();    
                 while(aa.hasMoreElements())
                     {
                       ((Server_thread)aa.nextElement()).out.writeUTF("聊天内容:"+message);
                     }  
              }
          
            else if(s.startsWith("用户离开:"))
              {
                 Enumeration bb=peopleList.elements();    
                 while(bb.hasMoreElements())             
                   { try
                     {
                        Server_thread th=(Server_thread)bb.nextElement();
                        if(th!=this&&th.isAlive())
                         {
                           th.out.writeUTF("用户离线:"+name);
                         }
                     }
                   catch(IOException eee)
                     {
                     }
                   } 
                peopleList.remove(name); 
                socket.close();                        
                System.out.println(name+"用户离开了");
                break;                                 
              }
            else if(s.startsWith("私人聊天内容:"))
              {
                 String 悄悄话=s.substring(s.indexOf(":")+1,s.indexOf("#"));
                 String toPeople=s.substring(s.indexOf("#")+1);
                 
                 Server_thread toThread=(Server_thread)peopleList.get(toPeople);
                 if(toThread!=null)
                   {
                    toThread.out.writeUTF("私人聊天内容:"+悄悄话);
                   }
                 else  
                   {
                     out.writeUTF("私人聊天内容:"+toPeople+"已经离线");
                   }
              }
           }
       catch(IOException ee)   
           {
               Enumeration e=peopleList.elements();    
                 while(e.hasMoreElements())             
                   { try
                     {
                        Server_thread th=(Server_thread)e.nextElement();
                        if(th!=this&&th.isAlive())
                         {
                           th.out.writeUTF("用户离线:"+name);
                         }
                     }
                   catch(IOException eee)
                     {
                     }
                   } 
                peopleList.remove(name); 
                 try
                    { 
                      socket.close();
                    }                    
                catch(IOException eee)
                    {
                    }
                              
              System.out.println(name+"用户离开了");
              break;                                 
           }             
     } 
  }*/
}


