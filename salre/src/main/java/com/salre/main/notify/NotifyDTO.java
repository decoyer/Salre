package com.salre.main.notify;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class NotifyDTO {
    private int notify_id;
    private int user_id;
    private String notify_content;
    private String notify_url;
    private Timestamp notify_time;
    private boolean is_check;
}