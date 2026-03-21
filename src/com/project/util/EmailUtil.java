package com.project.util;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.InetSocketAddress;
import java.net.Socket;
import java.nio.charset.StandardCharsets;
import java.util.Base64;
import javax.net.ssl.SSLSocket;
import javax.net.ssl.SSLSocketFactory;

public final class EmailUtil {
    private EmailUtil() {
    }

    public static boolean sendPlainText(String toEmail, String subject, String body) {
        String host = readConfig("ERP_SMTP_HOST", "");
        int port = parseInt(readConfig("ERP_SMTP_PORT", "25"), 25);
        String fromEmail = readConfig("ERP_SMTP_FROM", "noreply@university.local");
        String username = readConfig("ERP_SMTP_USERNAME", "");
        String password = readConfig("ERP_SMTP_PASSWORD", "");
        boolean startTls = "true".equalsIgnoreCase(readConfig("ERP_SMTP_STARTTLS", "false"));

        if (host.isEmpty() || toEmail == null || toEmail.trim().isEmpty()) {
            return false;
        }

        if (!startTls && port == 587) {
            startTls = true;
        }

        try (Socket socket = new Socket()) {
            socket.connect(new InetSocketAddress(host, port), 5000);
            socket.setSoTimeout(7000);

            BufferedReader reader = new BufferedReader(new InputStreamReader(socket.getInputStream(), StandardCharsets.UTF_8));
            BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(socket.getOutputStream(), StandardCharsets.UTF_8));

            if (!expectCode(reader, 220)) {
                return false;
            }

            sendLine(writer, "EHLO localhost");
            if (!expectCodePrefix(reader, 250)) {
                return false;
            }

            if (startTls) {
                sendLine(writer, "STARTTLS");
                if (!expectCode(reader, 220)) {
                    return false;
                }

                SSLSocketFactory sslFactory = (SSLSocketFactory) SSLSocketFactory.getDefault();
                SSLSocket tlsSocket = (SSLSocket) sslFactory.createSocket(socket, host, port, true);
                tlsSocket.setUseClientMode(true);
                tlsSocket.startHandshake();

                reader = new BufferedReader(new InputStreamReader(tlsSocket.getInputStream(), StandardCharsets.UTF_8));
                writer = new BufferedWriter(new OutputStreamWriter(tlsSocket.getOutputStream(), StandardCharsets.UTF_8));

                sendLine(writer, "EHLO localhost");
                if (!expectCodePrefix(reader, 250)) {
                    return false;
                }
            }

            if (!username.isEmpty() && !password.isEmpty()) {
                sendLine(writer, "AUTH LOGIN");
                if (!expectCode(reader, 334)) {
                    return false;
                }

                sendLine(writer, Base64.getEncoder().encodeToString(username.getBytes(StandardCharsets.UTF_8)));
                if (!expectCode(reader, 334)) {
                    return false;
                }

                sendLine(writer, Base64.getEncoder().encodeToString(password.getBytes(StandardCharsets.UTF_8)));
                if (!expectCode(reader, 235)) {
                    return false;
                }
            }

            sendLine(writer, "MAIL FROM:<" + fromEmail + ">");
            if (!expectAnyCode(reader, 250, 251)) {
                return false;
            }

            sendLine(writer, "RCPT TO:<" + toEmail.trim() + ">");
            if (!expectAnyCode(reader, 250, 251, 252)) {
                return false;
            }

            sendLine(writer, "DATA");
            if (!expectCode(reader, 354)) {
                return false;
            }

            writer.write("From: " + fromEmail + "\r\n");
            writer.write("To: " + toEmail.trim() + "\r\n");
            writer.write("Subject: " + safeHeader(subject) + "\r\n");
            writer.write("Content-Type: text/plain; charset=UTF-8\r\n");
            writer.write("\r\n");
            writer.write(body == null ? "" : body);
            writer.write("\r\n.\r\n");
            writer.flush();

            if (!expectCode(reader, 250)) {
                return false;
            }

            sendLine(writer, "QUIT");
            expectCode(reader, 221);
            return true;
        } catch (IOException ex) {
            return false;
        }
    }

    private static String readConfig(String key, String defaultValue) {
        String fromEnv = System.getenv(key);
        if (fromEnv != null && !fromEnv.trim().isEmpty()) {
            return fromEnv.trim();
        }

        String fromProp = System.getProperty(key);
        if (fromProp != null && !fromProp.trim().isEmpty()) {
            return fromProp.trim();
        }

        return defaultValue;
    }

    private static int parseInt(String value, int defaultValue) {
        try {
            return Integer.parseInt(value);
        } catch (NumberFormatException ex) {
            return defaultValue;
        }
    }

    private static void sendLine(BufferedWriter writer, String line) throws IOException {
        writer.write(line + "\r\n");
        writer.flush();
    }

    private static boolean expectCode(BufferedReader reader, int expectedCode) throws IOException {
        String line = reader.readLine();
        return line != null && line.startsWith(String.valueOf(expectedCode));
    }

    private static boolean expectCodePrefix(BufferedReader reader, int expectedPrefix) throws IOException {
        String prefix = String.valueOf(expectedPrefix);
        String line;
        boolean matched = false;

        do {
            line = reader.readLine();
            if (line == null) {
                return false;
            }
            if (line.startsWith(prefix)) {
                matched = true;
            }
        } while (line.length() >= 4 && line.charAt(3) == '-');

        return matched;
    }

    private static boolean expectAnyCode(BufferedReader reader, int... expectedCodes) throws IOException {
        String line = reader.readLine();
        if (line == null || line.length() < 3) {
            return false;
        }
        for (int code : expectedCodes) {
            if (line.startsWith(String.valueOf(code))) {
                return true;
            }
        }
        return false;
    }

    private static String safeHeader(String value) {
        if (value == null) {
            return "University ERP Credentials";
        }
        return value.replace("\r", " ").replace("\n", " ").trim();
    }
}
