package com.api.Services;

import com.api.Entity.DateMonitoring;
import com.api.Repository.IMonitoringRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.Date;
import java.util.List;
import java.util.Optional;

@Service
public class MonitoringService {

    @Autowired
    IMonitoringRepository repository;
    private Logger logger = LoggerFactory.getLogger(MonitoringService.class);

    public void saveMonitoring(DateMonitoring monitoring) {
        try {
            repository.save(monitoring);
            logger.info("Registrado");
        } catch (Exception e) {
            logger.error("Error al registrar el usuario");
        }
    }

    public DateMonitoring searchMonitoring() {
        Optional<DateMonitoring> dtm = repository.findById(new Long(20));
        return dtm.isPresent() ? dtm.get() : null;
    }

    public List<DateMonitoring> searchMonitoringdate(Date date) {
        List<DateMonitoring> list = repository.listMonitoringDate(date);
        return !list.isEmpty() ? list : null;
    }

}
