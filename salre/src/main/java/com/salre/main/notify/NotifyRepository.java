package com.salre.main.notify;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class NotifyRepository {
    @Autowired
    private SqlSession sqlSession;

    private String namespace = "com.salre.main.notify.";

    // 알림 조회
    public List<NotifyDTO> select(int user_id) {
        return sqlSession.selectList(namespace + "select", user_id);
    }

    // 알림 상세 조회
    public NotifyDTO selectById(int notify_id) {
        return sqlSession.selectOne(namespace + "selectById", notify_id);
    }

    // 읽지 않은 알림 개수 조회
    public int selectUnread(int user_id) {
        int count = sqlSession.selectList(namespace + "selectUnread", user_id).size();
        return count;
    }

    // 알림 생성
    public void insert(NotifyDTO nofityDTO) {
        sqlSession.insert(namespace + "insert", nofityDTO);
    }

    // 알림 상태 변경
    public void update(int notify_id) {
        sqlSession.update(namespace + "update", notify_id);
    }
}