package com.project.model;

public class Timetable {
    private String id;
    private String course;
    private String day;
    private String time;
    private String subject;
    private String faculty;

    public Timetable(String id, String course, String day, String time, String subject, String faculty) {
        this.id = id;
        this.course = course;
        this.day = day;
        this.time = time;
        this.subject = subject;
        this.faculty = faculty;
    }

    public String getId() {
        return id;
    }

    public String getCourse() {
        return course;
    }

    public String getDay() {
        return day;
    }

    public String getTime() {
        return time;
    }

    public String getSubject() {
        return subject;
    }

    public String getFaculty() {
        return faculty;
    }
}
