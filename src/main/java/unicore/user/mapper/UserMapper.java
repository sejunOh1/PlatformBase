package unicore.user.mapper;

import org.apache.ibatis.annotations.Mapper;
import unicore.user.model.User;

@Mapper
public interface UserMapper {
    User findByUsername(String username);
}