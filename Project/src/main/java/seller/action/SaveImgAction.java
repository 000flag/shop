package seller.action;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import user.action.Action;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;

public class SaveImgAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) {
		// 이미지 파일을 저장할 위치를 절대경로화 시킨다.
		ServletContext application = request.getServletContext();
		String realPath = application.getRealPath("/upload");

		//첨부되어오는 이미지 파일을 위 절대경로에 업로드 시키기 위해 cos라이브러리의
		// MultipartRequest객체가 필요함!
		try {
			MultipartRequest mr = new MultipartRequest(request, realPath,
					1024*1024*3, "utf-8", new DefaultFileRenamePolicy());

			// 이미 이미지 파일은 업로드가 된 상태이며, 이제는 호출한 곳으로
			// 저장된 이미지의 전체경로를 보내줘서 에디터에 포현하도록 해야 한다.
			File f = mr.getFile("upload");
			String fname = null;
			if(f != null) {
				fname = f.getName();// 저장된 실제 파일명을 얻기
				//요청객체에 위의 파일명을 저장한다.
				request.setAttribute("f_name", fname);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/seller/jsp/saveImg.jsp";
	}

}
