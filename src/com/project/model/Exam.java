package com.project.model;

public class Exam {
    private String id;
    private String course;
    private String subject;
    private String date;
    private String time;
    private String location;

    public Exam(String id, String course, String subject, String date, String time, String location) {
        this.id = id;
        this.course = course;
        this.subject = subject;
        this.date = date;
        this.time = time;
        this.location = location;
    }

    public String getId() {
        return id;
    }

    public String getCourse() {
        return course;
    }

    public String getSubject() {
        return subject;
    }

    public String getDate() {
        return date;
    }

    public String getTime() {
        return time;
    }

    public String getLocation() {
        return location;
    }
}
