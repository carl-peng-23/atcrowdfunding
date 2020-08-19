package com.atecut.atcrowdfunding.mapper;

import com.atecut.atcrowdfunding.bean.TAdminRole;
import com.atecut.atcrowdfunding.bean.TAdminRoleExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface TAdminRoleMapper {
    long countByExample(TAdminRoleExample example);

    int deleteByExample(TAdminRoleExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(TAdminRole record);

    int insertSelective(TAdminRole record);

    List<TAdminRole> selectByExample(TAdminRoleExample example);

    TAdminRole selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") TAdminRole record, @Param("example") TAdminRoleExample example);

    int updateByExample(@Param("record") TAdminRole record, @Param("example") TAdminRoleExample example);

    int updateByPrimaryKeySelective(TAdminRole record);

    int updateByPrimaryKey(TAdminRole record);

	void saveAdminAndRoleRelationship(@Param("adminId")Integer adminId, @Param("roleId")Integer[] roleId);

	void deleteAdminAndRoleRelationship(@Param("adminId")Integer adminId, @Param("roleId")Integer[] roleId);
}