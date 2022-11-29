// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   SimpleUploaderServlet.java

package com.fredck.FCKeditor.uploader;

import java.io.*;
import java.util.*;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import org.apache.commons.fileupload.DiskFileUpload;
import org.apache.commons.fileupload.FileItem;

public class SimpleUploaderServlet extends HttpServlet
{

    public SimpleUploaderServlet()
    {
    }

    public void init()
        throws ServletException
    {
        debug = (new Boolean(getInitParameter("debug"))).booleanValue();
        if(debug)
            System.out.println("\r\n---- SimpleUploaderServlet initialization started ----");
        baseDir = getInitParameter("baseDir");
        enabled = (new Boolean(getInitParameter("enabled"))).booleanValue();
        if(baseDir == null)
            baseDir = "/UserFiles/";
        String realBaseDir = getServletContext().getRealPath(baseDir);
        File baseFile = new File(realBaseDir);
        if(!baseFile.exists())
            baseFile.mkdir();
        allowedExtensions = new Hashtable(3);
        deniedExtensions = new Hashtable(3);
        allowedExtensions.put("File", stringToArrayList(getInitParameter("AllowedExtensionsFile")));
        deniedExtensions.put("File", stringToArrayList(getInitParameter("DeniedExtensionsFile")));
        allowedExtensions.put("Image", stringToArrayList(getInitParameter("AllowedExtensionsImage")));
        deniedExtensions.put("Image", stringToArrayList(getInitParameter("DeniedExtensionsImage")));
        allowedExtensions.put("Flash", stringToArrayList(getInitParameter("AllowedExtensionsFlash")));
        deniedExtensions.put("Flash", stringToArrayList(getInitParameter("DeniedExtensionsFlash")));
        if(debug)
            System.out.println("---- SimpleUploaderServlet initialization completed ----\r\n");
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException
    {
        if(debug)
            System.out.println("--- BEGIN DOPOST ---");
        response.setContentType("text/html; charset=UTF-8");
        response.setHeader("Cache-Control", "no-cache");
        PrintWriter out = response.getWriter();
        String typeStr = request.getParameter("Type");
        String currentPath = (new StringBuilder(String.valueOf(baseDir))).append(typeStr).toString();
        String currentDirPath = getServletContext().getRealPath(currentPath);
        currentPath = (new StringBuilder(String.valueOf(request.getContextPath()))).append(currentPath).toString();
        if(debug)
            System.out.println(currentDirPath);
        String retVal = "0";
        String newName = "";
        String fileUrl = "";
        String errorMessage = "";
        if(enabled)
        {
            DiskFileUpload upload = new DiskFileUpload();
            try
            {
                List items = upload.parseRequest(request);
                Map fields = new HashMap();
                for(Iterator iter = items.iterator(); iter.hasNext();)
                {
                    FileItem item = (FileItem)iter.next();
                    if(item.isFormField())
                        fields.put(item.getFieldName(), item.getString());
                    else
                        fields.put(item.getFieldName(), item);
                }

                FileItem uplFile = (FileItem)fields.get("NewFile");
                String fileNameLong = uplFile.getName();
                fileNameLong = fileNameLong.replace('\\', '/');
                String pathParts[] = fileNameLong.split("/");
                String fileName = pathParts[pathParts.length - 1];
                String nameWithoutExt = getNameWithoutExtension(fileName);
                String ext = getExtension(fileName);
                File pathToSave = new File(currentDirPath, fileName);
                fileUrl = (new StringBuilder(String.valueOf(currentPath))).append("/").append(fileName).toString();
                if(extIsAllowed(typeStr, ext))
                {
                    for(int counter = 1; pathToSave.exists(); counter++)
                    {
                        newName = (new StringBuilder(String.valueOf(nameWithoutExt))).append("(").append(counter).append(")").append(".").append(ext).toString();
                        fileUrl = (new StringBuilder(String.valueOf(currentPath))).append("/").append(newName).toString();
                        retVal = "201";
                        pathToSave = new File(currentDirPath, newName);
                    }

                    uplFile.write(pathToSave);
                } else
                {
                    retVal = "202";
                    errorMessage = "";
                    if(debug)
                        System.out.println((new StringBuilder("Invalid file type: ")).append(ext).toString());
                }
            }
            catch(Exception ex)
            {
                if(debug)
                    ex.printStackTrace();
                retVal = "203";
            }
        } else
        {
            retVal = "1";
            errorMessage = "This file uploader is disabled. Please check the WEB-INF/web.xml file";
        }
        out.println("<script type=\"text/javascript\">");
        out.println((new StringBuilder("window.parent.OnUploadCompleted(")).append(retVal).append(",'").append(fileUrl).append("','").append(newName).append("','").append(errorMessage).append("');").toString());
        out.println("</script>");
        out.flush();
        out.close();
        if(debug)
            System.out.println("--- END DOPOST ---");
    }

    private static String getNameWithoutExtension(String fileName)
    {
        return fileName.substring(0, fileName.lastIndexOf("."));
    }

    private String getExtension(String fileName)
    {
        return fileName.substring(fileName.lastIndexOf(".") + 1);
    }

    private ArrayList stringToArrayList(String str)
    {
        if(debug)
            System.out.println(str);
        String strArr[] = str.split("\\|");
        ArrayList tmp = new ArrayList();
        if(str.length() > 0)
        {
            for(int i = 0; i < strArr.length; i++)
            {
                if(debug)
                    System.out.println((new StringBuilder(String.valueOf(i))).append(" - ").append(strArr[i]).toString());
                tmp.add(strArr[i].toLowerCase());
            }

        }
        return tmp;
    }

    private boolean extIsAllowed(String fileType, String ext)
    {
        ext = ext.toLowerCase();
        ArrayList allowList = (ArrayList)(ArrayList)allowedExtensions.get(fileType);
        ArrayList denyList = (ArrayList)(ArrayList)deniedExtensions.get(fileType);
        if(allowList.size() == 0)
            return !denyList.contains(ext);
        if(denyList.size() == 0)
            return allowList.contains(ext);
        else
            return false;
    }

    private static String baseDir;
    private static boolean debug = false;
    private static boolean enabled = false;
    private static Hashtable allowedExtensions;
    private static Hashtable deniedExtensions;

}
