package user.control;

import java.io.FileInputStream;
import java.io.InputStream;
import java.util.Properties;
import javax.servlet.ServletContext;

public class ConfigUtil {
  private Properties properties = new Properties();

  public ConfigUtil(ServletContext context) {
    try {
      // WEB-INF 폴더에 있는 파일 경로 가져오기
      String filePath = context.getRealPath("/WEB-INF/config.properties");
      try (InputStream input = new FileInputStream(filePath)) {
        properties.load(input);
      }
    } catch (Exception e) {
      e.printStackTrace();
    }
  }

  public String getProperty(String key) {
    return properties.getProperty(key);
  }
}
