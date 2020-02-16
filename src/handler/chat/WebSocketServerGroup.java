package handler.chat;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import controller.CommandHandler;

@ServerEndpoint("/webGroup")
public class WebSocketServerGroup {
		private static Set<Session> clients = Collections.synchronizedSet(new HashSet<Session>());
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("a h:mm");
		SimpleDateFormat sdf2 = new SimpleDateFormat("yyyyMMdd");
		SimpleDateFormat sdf3 = new SimpleDateFormat("yyyy년 MM월 dd일");
		String datetext = sdf.format(date);
		String forDateTitle = sdf2.format(date);
		String checkDate = sdf3.format(date);
	@OnMessage
	public void onMessage(String message, Session session) throws IOException {
		System.out.println(message);
		synchronized (clients) {
			String name = session.getRequestParameterMap().get("name").toString();
			String movemessage = "[" + name.substring(1, name.indexOf("]")) + "] [" + datetext + "] [" + message + "]";
			String cid = (String) session.getRequestParameterMap().get("group").get(0);
			String logPath = "C:\\save\\" + cid;
			File file = new File(logPath);
			try {
				if (!file.exists())
					file.mkdirs();
				logPath = "C:\\save\\" + cid + "\\" + cid + "_" + forDateTitle + ".txt";
				file = new File(logPath);
				if (!file.exists()) {
					file.createNewFile();
					BufferedWriter bufferedWriter = new BufferedWriter(new FileWriter(file, true));
					if (file.isFile() && file.canWrite()) {
						bufferedWriter.write("=========[" + checkDate + "]=========");
						bufferedWriter.newLine();
						bufferedWriter.close();
					}
				}
				BufferedWriter bufferedWriter = new BufferedWriter(new FileWriter(file, true));
				if (file.isFile() && file.canWrite()) {
					bufferedWriter.write(movemessage.trim().replace("\n", "<br>"));
					bufferedWriter.newLine();
					bufferedWriter.close();
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			for (Session client : clients) {
				/*
				 * cid : client에서 보내는 group명 sid : 서버가 가지고 있는 session group명
				 */
				String sid = (String) client.getRequestParameterMap().get("group").get(0);
				System.out.println(sid + ":" + cid);
				// 자기 자신한테는 보내지 않음
				if (!client.equals(session)) {
					if (cid.equals(sid))
						client.getBasicRemote().sendText(movemessage);
				}
			}
		}
	}

	@OnOpen
	public void onOpen(Session session) {
		System.out.println("onOpen");
		System.out.println(session.getRequestParameterMap());
		HashSet<String> nameSet = new HashSet<String>();
		clients.add(session);

		for (Session client : clients) {

			String tmpgroup = client.getRequestParameterMap().get("group").get(0);
			String tmpname = client.getRequestParameterMap().get("name").get(0);

			nameSet.add(tmpgroup + "-" + tmpname);
		}
		String line = "===fromServer===";
		for (String name : nameSet) {
			line += name + ",";
		}
		System.out.println(line + "=============");
		try {
			for (Session client : clients) {
				String cid = (String) session.getRequestParameterMap().get("group").get(0);
				String sid = (String) client.getRequestParameterMap().get("group").get(0);
				System.out.println(sid + ":" + cid);
				client.getBasicRemote().sendText(line);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@OnClose
	public void onClose(Session session) {
		System.out.println("onClose");
		// Remove session from the connected sessions set
		clients.remove(session);
		HashSet<String> nameSet = new HashSet<String>();
		for (Session client : clients) {
			String tmpgroup = client.getRequestParameterMap().get("group").get(0);
			String tmpname = client.getRequestParameterMap().get("name").get(0);
			nameSet.add(tmpgroup + "-" + tmpname);
		}
		String line = "===fromServer===";
		for (String name : nameSet) {
			line += name + ",";
		}
		System.out.println(line + "=============");
		try {
			for (Session client : clients) {

				String cid = (String) session.getRequestParameterMap().get("group").get(0);
				String sid = (String) client.getRequestParameterMap().get("group").get(0);

				System.out.println(sid + ":" + cid);

				client.getBasicRemote().sendText(line);

			}

		} catch (IOException e) {

			e.printStackTrace();
		}

	}

}
