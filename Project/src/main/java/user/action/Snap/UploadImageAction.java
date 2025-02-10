package user.action.Snap;

import com.google.gson.JsonObject;
import service.S3Uploader;
import user.action.Action;


import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50   // 50MB
)
public class UploadImageAction implements Action {
  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    JsonObject jsonResponse = new JsonObject();
    response.setContentType("application/json");
    System.out.println("saaaaaaaaaaaaaaa");

    Part filePart = request.getPart("file"); // input name="file"
    System.out.println("saaaaaaaaaaaaaaa"+filePart.getSubmittedFileName());
    if (filePart == null) {
      jsonResponse.addProperty("success", false);
      jsonResponse.addProperty("message", "파일을 찾을 수 없습니다.");
      response.getWriter().write(jsonResponse.toString());
      return null;
    }


    String fileName = filePart.getSubmittedFileName();
    if (fileName == null || fileName.isEmpty()) {
      jsonResponse.addProperty("success", false);
      jsonResponse.addProperty("message", "파일 이름이 유효하지 않습니다.");
      response.getWriter().write(jsonResponse.toString());
      return null;
    }




    File tempFile = convertInputStreamToFile(filePart.getInputStream(), fileName);
    if (tempFile == null) {
      jsonResponse.addProperty("success", false);
      jsonResponse.addProperty("message", "파일 변환 실패");
      response.getWriter().write(jsonResponse.toString());
      return null;
    }


    S3Uploader uploader = new S3Uploader();
    String imageUrl = uploader.uploadFile(tempFile, fileName); // 기존 uploadFile() 메서드 사용




    if (imageUrl == null) {
      jsonResponse.addProperty("success", false);
      jsonResponse.addProperty("message", "S3 업로드 실패");
    } else {
      jsonResponse.addProperty("success", true);
      jsonResponse.addProperty("imageUrl", imageUrl);
    }


    tempFile.delete();

    response.getWriter().write(jsonResponse.toString());
    return null;
  }

  /**
   * InputStream을 File로 변환하는 메서드
   */
  private File convertInputStreamToFile(InputStream inputStream, String fileName) {
    try {
      File tempFile = File.createTempFile("upload_", fileName);
      FileOutputStream outputStream = new FileOutputStream(tempFile);

      byte[] buffer = new byte[1024];
      int bytesRead;
      while ((bytesRead = inputStream.read(buffer)) != -1) {
        outputStream.write(buffer, 0, bytesRead);
      }
      outputStream.close();
      inputStream.close();

      return tempFile;
    } catch (IOException e) {
      System.err.println(" 파일 변환 오류: " + e.getMessage());
      return null;
    }
  }
}
