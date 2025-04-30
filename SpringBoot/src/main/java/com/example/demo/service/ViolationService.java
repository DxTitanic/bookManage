
package com.example.demo.service;

import com.example.demo.entity.Violation;
import java.util.List;

public interface ViolationService {
    List<Violation> getViolationRecords(Integer userId);
}
