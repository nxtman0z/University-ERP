package com.project.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;

@MultipartConfig
public class StudentProfilePhotoUploadServlet extends HttpServlet {
    private static final long MAX_FILE_SIZE = 2L * 1024L * 1024L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("studentLogin.jsp?error=Session Expired");
            return;
        }

        String studentId = session.getAttribute("userId").toString();
        Part photoPart = request.getPart("profilePhoto");
        if (photoPart == null || photoPart.getSize() <= 0) {
            redirectWithPopup(response, "error", "Invalid Photo", "Please choose a profile photo.");
            return;
        }

        String contentType = photoPart.getContentType();
        if (contentType == null || !contentType.toLowerCase().startsWith("image/")) {
            redirectWithPopup(response, "error", "Invalid Photo", "Only image files are allowed.");
            return;
        }

        if (photoPart.getSize() > MAX_FILE_SIZE) {
            redirectWithPopup(response, "error", "Photo Too Large", "Profile photo must be 2 MB or smaller.");
            return;
        }

        String extension = extensionFor(contentType, photoPart.getSubmittedFileName());
        String fileName = studentId + "_" + System.currentTimeMillis() + extension;

        String uploadsRealPath = getServletContext().getRealPath("/uploads/student-profiles");
        if (uploadsRealPath == null) {
            redirectWithPopup(response, "error", "Upload Failed", "Could not resolve upload path.");
            return;
        }

        File uploadDir = new File(uploadsRealPath);
        if (!uploadDir.exists() && !uploadDir.mkdirs()) {
            redirectWithPopup(response, "error", "Upload Failed", "Could not create upload directory.");
            return;
        }

        File[] oldFiles = uploadDir.listFiles((dir, name) -> name.startsWith(studentId + "_"));
        if (oldFiles != null) {
            for (File oldFile : oldFiles) {
                oldFile.delete();
            }
        }

        Path targetPath = new File(uploadDir, fileName).toPath();
        Files.copy(photoPart.getInputStream(), targetPath, StandardCopyOption.REPLACE_EXISTING);

        session.setAttribute("studentAvatarPath", "uploads/student-profiles/" + fileName);
        redirectWithPopup(response, "success", "Profile Updated", "Profile photo uploaded successfully.");
    }

    private String extensionFor(String contentType, String submittedFileName) {
        if (contentType.equalsIgnoreCase("image/png")) {
            return ".png";
        }
        if (contentType.equalsIgnoreCase("image/webp")) {
            return ".webp";
        }
        if (contentType.equalsIgnoreCase("image/gif")) {
            return ".gif";
        }
        if (submittedFileName != null) {
            int dot = submittedFileName.lastIndexOf('.');
            if (dot >= 0 && dot < submittedFileName.length() - 1) {
                return "." + submittedFileName.substring(dot + 1).replaceAll("[^A-Za-z0-9]", "").toLowerCase();
            }
        }
        return ".jpg";
    }

    private void redirectWithPopup(HttpServletResponse response, String type, String message, String popup) throws IOException {
        String encodedMessage = URLEncoder.encode(message, StandardCharsets.UTF_8.name());
        String encodedPopup = URLEncoder.encode(popup, StandardCharsets.UTF_8.name());
        response.sendRedirect("studentDashboard.jsp?" + type + "=" + encodedMessage + "&popup=" + encodedPopup + "#dashboard");
    }
}
