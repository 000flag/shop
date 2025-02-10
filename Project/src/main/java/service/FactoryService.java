package service;

import java.io.InputStream;
import java.io.Reader;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class FactoryService {
	private static SqlSessionFactory factory;
	static {
		try {
			String resource = "mybatis/config/config.xml";

			// 🔥 파일이 존재하는지 확인
			InputStream inputStream = Resources.getResourceAsStream(resource);
			if (inputStream == null) {
				throw new RuntimeException("MyBatis 설정 파일을 찾을 수 없습니다: " + resource);
			}

			Reader r = Resources.getResourceAsReader(resource);
			factory = new SqlSessionFactoryBuilder().build(r);
			r.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	static {
		try {
      		Reader r = Resources.getResourceAsReader("mybatis/config/config.xml");
			factory = new SqlSessionFactoryBuilder().build(r);

			r.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public static SqlSessionFactory getFactory() {
		return factory;
	}
}




