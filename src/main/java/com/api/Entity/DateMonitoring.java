package com.api.Entity;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table (name = "DATE_MONITORING")
public class DateMonitoring {

    @Id
    @Column (name = "ID", insertable = false)
    @GeneratedValue (strategy = GenerationType.IDENTITY)
    private long id;

    @Temporal (TemporalType.DATE)
    @Column (name = "DATE_MONITORING")
    private Date dateMonitoring;

    @Temporal (TemporalType.TIME)
    @Column (name = "TIME_MONITORING")
    private Date timeMonitoring;

    @Temporal (TemporalType.TIME)
    @Column (name = "TIME_ON")
    private Date timeOn;

    @Temporal (TemporalType.TIME)
    @Column (name = "TIME_OFF")
    private Date timeOff;

    @Column (name = "DAYS_WORKS")
    private int daysWorks;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public Date getDateMonitoring() {
        return dateMonitoring;
    }

    public void setDateMonitoring(Date dateMonitoring) {
        this.dateMonitoring = dateMonitoring;
    }

    public Date getTimeMonitoring() {
        return timeMonitoring;
    }

    public void setTimeMonitoring(Date timeMonitoring) {
        this.timeMonitoring = timeMonitoring;
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
