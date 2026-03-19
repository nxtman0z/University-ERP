package com.project.model;

public class Notice {
    private String id;
    private String title;
    private String message;
    private String date;
    private String forRole;

    public Notice(String id, String title, String message, String date, String forRole) {
        this.id = id;
        this.title = title;
        this.message = message;
        this.date = date;
        this.forRole = forRole;
    }

    public String getId() {
        return id;
    }

    public String getTitle() {
        return title;
    }

    public String getMessage() {
        return message;
    }

    public String getDate() {
        return date;
    }

    public String getForRole() {
        return forRole;
    }
}
