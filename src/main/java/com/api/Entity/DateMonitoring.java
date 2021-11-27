package com.api.Entity;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table (name = "DATE_MONITORING")
public class DateMonitoring {

    @Id
    @Column (name = "ID", insertable = false)
    @GeneratedValue (strategy = GenerationType.IDENTITY)
    private int id;

    @Column (name = "DATE_MONITORING")
    private Date dateMonitoring;

    @Column (name = "TIME_ON")
    private Date timeOn;

    @Column (name = "TIME_OFF")
    private Date timeOff;

    @Column (name = "DAYS_WORKS")
    private int daysWorks;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getDateMonitoring() {
        return dateMonitoring;
    }

    public void setDateMonitoring(Date dateMonitoring) {
        this.dateMonitoring = dateMonitoring;
    }

    public Date getTimeOn() {
        return timeOn;
    }

    public void setTimeOn(Date timeOn) {
        this.timeOn = timeOn;
    }

    public Date getTimeOff() {
        return timeOff;
    }

    public void setTimeOff(Date timeOff) {
        this.timeOff = timeOff;
    }

    public int getDaysWorks() {
        return daysWorks;
    }

    public void setDaysWorks(int daysWorks) {
        this.daysWorks = daysWorks;
    }
}
