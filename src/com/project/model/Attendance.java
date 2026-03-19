package com.project.model;

public class Attendance {
    private String id;
    private String studentId;
    private String subject;
    private String date;
    private String status;

    public Attendance(String id, String studentId, String subject, String date, String status) {
        this.id = id;
        this.studentId = studentId;
        this.subject = subject;
        this.date = date;
        this.status = status;
    }

    public String getId() {
        return id;
    }

    public String getStudentId() {
        return studentId;
    }

    public String getSubject() {
        return subject;
    }

    public String getDate() {
        return date;
    }

    public String getStatus() {
        return status;
    }
}
