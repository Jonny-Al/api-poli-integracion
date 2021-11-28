package com.api.Repository;

import com.api.Entity.DateMonitoring;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import java.util.Date;
import java.util.List;

@Repository
public interface IMonitoringRepository extends JpaRepository<DateMonitoring, Long> {

    @Query ("SELECT d FROM DateMonitoring d WHERE d.dateMonitoring = :dateMon")
    List<DateMonitoring> listMonitoringDate(Date dateMon);

}
