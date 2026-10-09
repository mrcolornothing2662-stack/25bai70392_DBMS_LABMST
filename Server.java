import java.io.*;
import java.net.*;

public class Server {
    public static void main(String[] args) throws Exception {

        ServerSocket ss = new ServerSocket(1234);
        System.out.println("Server Waiting...");

        Socket s = ss.accept();

        DataInputStream dis = new DataInputStream(s.getInputStream());
        DataOutputStream dos = new DataOutputStream(s.getOutputStream());

        String msg = dis.readUTF();
        System.out.println("Client says: " + msg);

        dos.writeUTF("Hello Client");

        ss.close();
    }
}