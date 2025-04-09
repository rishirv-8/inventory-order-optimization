package com.rishi.inventory.repository;

import com.rishi.inventory.model.Item;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ItemRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public List<Item> findAll() {
        String sql = "SELECT segment1, description, primary_uom_code FROM MTL_SYSTEM_ITEMS_B";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Item.class));
    }
}
