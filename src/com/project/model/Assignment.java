package com.project.model;

public class Assignment {
    private String id;
    private String subject;
    private String title;
    private String description;
    private String dueDate;
    private String faculty;

    public Assignment(String id, String subject, String title, String description, String dueDate, String faculty) {
        this.id = id;
        this.subject = subject;
        this.title = title;
        this.description = description;
        this.dueDate = dueDate;
        this.faculty = faculty;
    }

    public String getId() {
        return id;
    }

    public String getSubject() {
        return subject;
    }

    public String getTitle() {
        return title;
    }

    public String getDescription() {
        return description;
    }

    public String getDueDate() {
        return dueDate;
    }

    public String getFaculty() {
        return faculty;
    }
}
