package com.project.servlet;

import com.project.util.DatabaseUtil;

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
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@MultipartConfig
public class FacultyProfilePhotoUploadServlet extends HttpServlet {
    private static final long MAX_FILE_SIZE = 2L * 1024L * 1024L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("facultyLogin.jsp?error=Session Expired");
            return;
        }

        String facultyId = session.getAttribute("userId").toString();
        Part photoPart = request.getPart("facultyPhoto");
        if (photoPart == null || photoPart.getSize() <= 0) {
            redirectToProfile(response, "error", "Please choose a profile photo.");
            return;
        }

        String contentType = photoPart.getContentType();
        if (contentType == null || !contentType.toLowerCase().startsWith("image/")) {
            redirectToProfile(response, "error", "Only image files are allowed.");
            return;
        }

        if (photoPart.getSize() > MAX_FILE_SIZE) {
            redirectToProfile(response, "error", "Profile photo must be 2 MB or smaller.");
            return;
        }

        String extension = extensionFor(contentType, photoPart.getSubmittedFileName());
        String fileName = facultyId + "_" + System.currentTimeMillis() + extension;
        String uploadsRealPath = getServletContext().getRealPath("/uploads/faculty-profiles");
        if (uploadsRealPath == null) {
            redirectToProfile(response, "error", "Could not resolve upload path.");
            return;
        }

        File uploadDir = new File(uploadsRealPath);
        if (!uploadDir.exists() && !uploadDir.mkdirs()) {
            redirectToProfile(response, "error", "Could not create upload directory.");
            return;
        }

        File[] oldFiles = uploadDir.listFiles((dir, name) -> name.startsWith(facultyId + "_"));
        if (oldFiles != null) {
            for (File oldFile : oldFiles) {
                oldFile.delete();
            }
        }

        Path targetPath = new File(uploadDir, fileName).toPath();
        Files.copy(photoPart.getInputStream(), targetPath, StandardCopyOption.REPLACE_EXISTING);

        String relativePath = "uploads/faculty-profiles/" + fileName;
        String updateSql = "UPDATE faculty SET profile_photo_url = ? WHERE faculty_id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(updateSql)) {
            stmt.setString(1, relativePath);
            stmt.setString(2, facultyId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            redirectToProfile(response, "error", "Photo upload failed due to database issue.");
            return;
        }

        session.setAttribute("facultyAvatarPath", relativePath);
        redirectToProfile(response, "success", "Profile photo uploaded successfully.");
    }

    private String extensionFor(String contentType, String submittedFileName) {
        if ("image/png".equalsIgnoreCase(contentType)) {
            return ".png";
        }
        if ("image/webp".equalsIgnoreCase(contentType)) {
            return ".webp";
        }
        if ("image/gif".equalsIgnoreCase(contentType)) {
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

    private void redirectToProfile(HttpServletResponse response, String type, String message) throws IOException {
        String encoded = URLEncoder.encode(message, StandardCharsets.UTF_8.name());
        response.sendRedirect("facultyDashboard.jsp?" + type + "=" + encoded + "#profile");
    }
}
