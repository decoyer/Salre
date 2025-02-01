package com.salre.main.notify;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class NotifyService {
    @Autowired
    private NotifyRepository notifyRepository;

    // 알림 조회
    public List<NotifyDTO> select(int user_id) {
        return notifyRepository.select(user_id);
    }

    // 알림 상세 조회
    public NotifyDTO selectById(int notify_id) {
        return notifyRepository.selectById(notify_id);
    }

    // 읽지 않은 알림 개수 조회
    public int selectUnread(int user_id) {
        return notifyRepository.selectUnread(user_id);
    }

    // 알림 생성
    public void insert(NotifyDTO nofityDTO) {
        notifyRepository.insert(nofityDTO);
    }

    // 알림 상태 변경
    public void update(int notify_id) {
        notifyRepository.update(notify_id);
    }
}