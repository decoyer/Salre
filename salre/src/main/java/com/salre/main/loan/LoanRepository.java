package com.salre.main.loan;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class LoanRepository {
    @Autowired
    private SqlSession sqlSession;

    private String namespace = "com.salre.main.loan.";

    // 대출 조회
    public List<LoanDTO> select(int age, int income) {
        Map<String, Object> map = new HashMap<>(age, income);

        map.put("age", age);
        map.put("income", income);

        return sqlSession.selectList(namespace + "select", map);
    }

    // 대출 상세 조회
    public LoanDTO selectById(int id) {
        return sqlSession.selectOne(namespace + "selectById", id);
    }
}
