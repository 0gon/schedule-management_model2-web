package handler.chat;

import java.io.File;
import java.io.IOException;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.CommandHandler;
import dao.UserDAO;
import model.Chatdata;
import model.UserVO;

public class ChatForm implements CommandHandler {
	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws Exception {
		//dptNo name useyn
		String dptNo = req.getParameter("dptNo");
		String userId = req.getParameter("userId");
		String useyn = req.getParameter("useyn");
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String datetext = sdf.format(date);
		String cid = dptNo; 
		String rootDirPath = "C:\\save\\" + cid;
		
		UserDAO userDAO = UserDAO.getInstance();
		UserVO userVO = userDAO.selectUserInfoByPK(Integer.parseInt(userId));
		String name = userVO.getMemberNm();
		req.setAttribute("name", name);
		req.setAttribute("userVO", userVO);
		req.setAttribute("group", dptNo);
		//현재 사용중인 회원만 채팅폼 활성화(구분자 useryn, 0: 미사용, 1:사용)
		if(!useyn.equals("0")) {

		File rootDir = null;
		List<String> files = new ArrayList<String>();
		Charset cs = StandardCharsets.UTF_8;
	
		List<Chatdata> chatd = new ArrayList<Chatdata>();
		String lastday="";
		
		try {
			rootDir = new File(rootDirPath);
			   if(!rootDir.exists())
				   rootDir.mkdirs();
			File[] rootDirs = rootDir.listFiles();

		// 3일치 파일 가져오기
		if (rootDirs.length >= 3) {
			for (int i = rootDirs.length - 3; i < rootDirs.length; i++) {
				files.add(rootDirs[i].getPath());
				
				if(i==rootDirs.length-1) {
					lastday=rootDirs[i].getName().replace(cid+"_", "");
				}
			}
			// 파일이 3일치 이하인 경우
		} else {
			for (int i = 0; i < rootDirs.length; i++) {
				files.add(rootDirs[i].getPath());
				if(i==rootDirs.length-1) {
					lastday=rootDirs[i].getName().replace(cid+"_", "");
				}
			}
			}
		if(rootDirs.length==0) {
			req.setAttribute("isEmpty", "true");
		}else {
			req.setAttribute("isEmpty", "false");
		}
		for (String logPath : files) {
			File file = new File(logPath);
			if (file.exists()) {
				Path path = Paths.get(logPath);
				List<String> list = new ArrayList<String>();
				list = Files.readAllLines(path, cs);
					for (String readLine : list) {
						readLine.trim();
						if (readLine.substring(1,8).equals("=======")) {
							Chatdata cd = new Chatdata();
							cd.setName("server");
							cd.setDate("server");
							String str=readLine.substring( readLine.indexOf("[")+1, readLine.indexOf("]") );
							cd.setContent(str.trim());
							chatd.add(cd);
						} else {
							String[] tmp = readLine.substring(readLine.indexOf("[") + 1, readLine.lastIndexOf("]"))
									.split("\\]" + " " + "\\[");
							List tmplist = new ArrayList();
								for (int i = 0; i < tmp.length; i++) {
										tmplist.add(tmp[i]);
									}
								if (tmp.length == 2) {
										tmplist.add("");
									}
							Chatdata cd = new Chatdata();
							cd.setName((String) tmplist.get(0));
							cd.setDate((String) tmplist.get(1));
							cd.setContent((String) tmplist.get(2));
							chatd.add(cd);
						}

					}
				}
			}
		} catch (IOException e) {
			e.printStackTrace();}
		
		req.setAttribute("chatdata", chatd);
		req.setAttribute("today", datetext);
		String lastdayText="";
		
		if(!lastday.equals("")) {
		lastdayText=lastday.substring(0, lastday.indexOf("."));}else {
			lastdayText=datetext;
		}
		req.setAttribute("lastday", lastdayText);
		HashMap<String,String> namemap=new HashMap<String,String>();		//사진
		HashMap<String,String> namemap2=new HashMap<String,String>();			//닉네임
		HashMap<String,String> namemap3=new HashMap<String,String>();			//역할
		
		/*
		List<RelationVO> memberList=rPro.getJoinMemberListForChat(group);
		Iterator<RelationVO> it=memberList.iterator();
		while(it.hasNext()) {
			RelationVO member=(RelationVO)it.next();
			
			String username=member.getMemberId();
			namemap2.put(username, member.getNickName());
			
			String position=member.getPosition();
			if(position==null) {
				if(member.getMemberId().equals(member.getLeader())) {
					member.setPosition("방장");
				}else {
					member.setPosition("회원");
				}
				
			}
			namemap3.put(username, member.getPosition());
			if(member.getStatus().equals("2")) {
			
					if((member.getPhoto()!="")&&(member.getPhoto()!=null)) {
						
						namemap.put(username,req.getContextPath()+"/fileSave/"+member.getPhoto());
						
					}
					
					else {
						namemap.put(username,req.getContextPath()+"/imgs/profile.png");
						
					}
			
			}
			else {
				namemap.put(username,req.getContextPath()+"/imgs/Xprofile.png");
			}
			
		}
		 */
		
		
		
		
	        Set<String> set = namemap.keySet();
	        
	        Object obj[] = set.toArray();

	        StringBuffer stbf = new StringBuffer();
	        stbf.append("var map = new Array();");
	        for(int i=0; i<obj.length; i++)
	        {
	            if(i!=0)stbf.append("");
	            stbf.append("map['"+obj[i]+"'] = '"+namemap.get(obj[i])+"';");
	        }
	        
	        Set<String> set2 = namemap2.keySet();
	        
	        Object obj2[] = set2.toArray();

	        StringBuffer stbf2 = new StringBuffer();
	        stbf2.append("var map2 = new Array();");
	        for(int i=0; i<obj2.length; i++)
	        {
	            if(i!=0)stbf2.append("");
	            stbf2.append("map2['"+obj2[i]+"'] = '"+namemap2.get(obj2[i])+"';");
	        }
		
	        Set<String> set3 = namemap3.keySet();
	        
	        Object obj3[] = set3.toArray();

	        StringBuffer stbf3 = new StringBuffer();
	        stbf3.append("var map3 = new Array();");
	        for(int i=0; i<obj3.length; i++)
	        {
	            if(i!=0)stbf3.append("");
	            stbf3.append("map3['"+obj3[i]+"'] = '"+namemap3.get(obj3[i])+"';");
	        }
		
	    req.setAttribute("nameJs",stbf);
	    req.setAttribute("nameJs2",stbf2);
	    req.setAttribute("nameJs3",stbf3);
	  //  mv.addAttribute("nameJs",stbf);
	//    mv.addAttribute("nameJs2",stbf2);
//	    mv.addAttribute("nameJs3",stbf3);
		//mv.addAttribute("memberList",memberList);
		
		
	    return "/WEB-INF/views/chat/websocketGroup.jsp";
		}else {
			return null;
		}
	}
}
